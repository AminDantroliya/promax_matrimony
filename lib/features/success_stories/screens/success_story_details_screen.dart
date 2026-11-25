import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/core/config/env_config.dart';
import 'package:share_plus/share_plus.dart';

import '../../../features/success_stories/data/models/success_story_models.dart';
import '../providers/success_story_notifier.dart';

class SuccessStoryDetailsScreen extends ConsumerWidget {
  final SuccessStory story;

  const SuccessStoryDetailsScreen({super.key, required this.story});

  String _getFormattedDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "married_lbl".tr;
    try {
      final date = DateTime.parse(dateStr);
      final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
      return "${'married_lbl'.tr} ${months[date.month - 1]} ${date.year}";
    } catch (e) {
      return dateStr;
    }
  }

  String getFullMediaUrl(String? path) {
    if (path == null || path.isEmpty) return "";
    if (path.startsWith("http://") || path.startsWith("https://")) {
      return path;
    }
    String host = EnvConfig.baseUrl.replaceAll("/api/", "/");
    if (!host.endsWith("/")) {
      host += "/";
    }
    return "${host}uploads/success_story/$path";
  }

  String _getProfileImageUrl(String? path) {
    if (path == null || path.isEmpty) return "";
    if (path.startsWith("http://") || path.startsWith("https://")) {
      return path;
    }
    final cleanBaseUrl = EnvConfig.baseUrl.replaceAll("api/", "storage/assets/memberPhotos/");
    if (!cleanBaseUrl.endsWith("/")) {
      return "$cleanBaseUrl/$path";
    }
    return "$cleanBaseUrl$path";
  }

  String? _getYouTubeId(String? url) {
    if (url == null || url.isEmpty) return null;
    final RegExp regExp = RegExp(
      r'^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/|shorts\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(url);
    return (match != null && match.groupCount >= 1) ? match.group(1) : null;
  }

  String _getStoryImageUrl(SuccessStory story) {
    final isVideoStory = story.storyType == "Video Story";

    if (isVideoStory) {
      if (story.videoLink != null && story.videoLink!.isNotEmpty) {
        final videoId = _getYouTubeId(story.videoLink);
        if (videoId != null && videoId.isNotEmpty) {
          return "https://img.youtube.com/vi/$videoId/hqdefault.jpg";
        }
      }
      if (story.weddingVideoThumbnail != null && story.weddingVideoThumbnail!.isNotEmpty) {
        return getFullMediaUrl(story.weddingVideoThumbnail);
      }
      if (story.weddingphoto != null && story.weddingphoto!.isNotEmpty) {
        return getFullMediaUrl(story.weddingphoto);
      }
    } else {
      if (story.weddingphoto != null && story.weddingphoto!.isNotEmpty) {
        return getFullMediaUrl(story.weddingphoto);
      }
      if (story.weddingVideoThumbnail != null && story.weddingVideoThumbnail!.isNotEmpty) {
        return getFullMediaUrl(story.weddingVideoThumbnail);
      }
    }
    return "";
  }

  void _openPhotoViewer(BuildContext context, String imageUrl) {
    if (imageUrl.isNotEmpty) {
      context.push('/photo-viewer', extra: {
        'imageList': [imageUrl],
        'initialIndex': 0,
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final detailsAsync = ref.watch(successStoryDetailsProvider(story.id ?? 0));
    final appConfig = ref.watch(appConfigProvider);
    final appName = appConfig.appName;

    return detailsAsync.when(
      data: (detailedStory) => _buildDetailsContent(context, detailedStory, isDark, appName: appName),
      loading: () => _buildDetailsContent(context, story, isDark, isLoading: true, appName: appName),
      error: (err, stack) => _buildDetailsContent(context, story, isDark, appName: appName),
    );
  }

  Widget _buildDetailsContent(
      BuildContext context,
      SuccessStory detailedStory,
      bool isDark, {
        bool isLoading = false,
        required String appName,
      }) {
    final fullMsg = detailedStory.successmessage ?? "";

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgApp,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                children: [
                  // 1. Hero Image Card (Width: 335px, Height: 380px with rounded corners)
                  _buildHeroHeader(context, isDark, detailedStory),

                  // Translate the cards up by 64px to overlap the bottom of the hero image precisely like Figma
                  Transform.translate(
                    offset: const Offset(0, -64),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 2. Overlap Couple Profiles Row Card
                        _buildCoupleProfilesCard(context, isDark, detailedStory),
                        const Gap(20),

                        // 3. How We Met Section (using Figma document SVG icon)
                        _buildStorySection(
                          svgAsset: AppAssets.figmaDocument,
                          iconColor: Theme.of(context).primaryColor,
                          title: "how_we_met".tr,
                          content: fullMsg,
                          isDark: isDark,
                        ),
                        const Gap(32),

                        // 4. Bottom Share Button (using Figma send message SVG icon)
                        _buildShareButton(context, isDark, detailedStory, appName),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  minHeight: 2,
                  color: AppColors.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, SuccessStory detailedStory) {
    final imageUrl = _getStoryImageUrl(detailedStory);
    final formattedDate = _getFormattedDate(detailedStory.marriagedate);

    return Container(
      height: 380,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            // Background Hero image
            Positioned.fill(
              child: getImageWidget(
                url: imageUrl,
                boxFit: BoxFit.cover,
                placeHolder: AppAssets.placeholderPng,
              ),
            ),
            // Dark gradient mask for readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.45),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.75),
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),
            // Transparent GestureDetector to capture taps anywhere except back button
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _openPhotoViewer(context, imageUrl),
                child: const SizedBox.shrink(),
              ),
            ),
            // Floating App Bar elements inside the card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppRadius.mdRadius,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).primaryColor,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.figmaVerified,
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                        const Gap(5),
                        Text(
                          "verified_lbl".tr,
                          style: AppFont.font(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Video story play button overlay in the center
            if (detailedStory.storyType == "Video Story")
              Center(
                child: GestureDetector(
                  onTap: () {
                    final isYoutube = getDisplayString(detailedStory.videoType, defaultValue: "") == "youtube";
                    final String url;
                    if (isYoutube) {
                      url = detailedStory.videoLink!;
                    } else if (detailedStory.weddingVideoFile != null && detailedStory.weddingVideoFile!.isNotEmpty) {
                      url = getFullMediaUrl(detailedStory.weddingVideoFile!);
                    } else {
                      url = "";
                    }
                    if (url.isNotEmpty) {
                      context.push('/play-video', extra: {'videoUrl': url, 'isYoutube': isYoutube});
                    }
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: AppColors.primary,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ),

            // Overlay Texts on top of the image bottom
            Positioned(
              bottom: 80, // Positioned high enough to stay above the overlapping profiles card
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.white,
                          size: 12,
                        ),
                        const Gap(4),
                        Text(
                          "featured_lbl".tr,
                          style: AppFont.font(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Text(
                        "${detailedStory.bridename} ",
                        style: AppFont.font(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                        size: 18,
                      ),
                      Text(
                        " ${detailedStory.groomname}",
                        style: AppFont.font(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Gap(6),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.successStoryDate,
                        width: 12,
                        height: 12,
                        colorFilter: const ColorFilter.mode(
                          Colors.white70,
                          BlendMode.srcIn,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        formattedDate,
                        style: AppFont.font(
                          fontSize: 11,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoupleProfilesCard(BuildContext context, bool isDark, SuccessStory detailedStory) {
    final imageUrl = _getStoryImageUrl(detailedStory);
    final brideImageUrl = _getProfileImageUrl(detailedStory.brideProfileImage);
    final groomImageUrl = _getProfileImageUrl(detailedStory.groomProfileImage);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.white.withValues(alpha: 0.05) : AppColors.bgCard,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFF1F5F9),
          width: 1,
        ),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Bride Circular Profile Avatar with white border and soft shadow
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _openPhotoViewer(context, brideImageUrl.isNotEmpty ? brideImageUrl : imageUrl),
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: getImageWidget(
                        url: brideImageUrl.isNotEmpty ? brideImageUrl : imageUrl,
                        boxFit: BoxFit.cover,
                        placeHolder: AppAssets.placeholderPng,
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                Text(
                  detailedStory.bridename ?? "Bride Name",
                  style: AppFont.font(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.white : AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(4),
                const SizedBox.shrink(),
              ],
            ),
          ),

          SvgPicture.asset(
            AppAssets.icSuccessStoryHeart,
            width: 46,
            height: 46,
          ),

          // Groom Circular Profile Avatar with white border and soft shadow
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _openPhotoViewer(context, groomImageUrl.isNotEmpty ? groomImageUrl : imageUrl),
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: getImageWidget(
                        url: groomImageUrl.isNotEmpty ? groomImageUrl : imageUrl,
                        boxFit: BoxFit.cover,
                        placeHolder: AppAssets.placeholderPng,
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                Text(
                  detailedStory.groomname ?? "Groom Name",
                  style: AppFont.font(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.white : AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(4),
                const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorySection({
    required String svgAsset,
    required Color iconColor,
    required String title,
    required String content,
    required bool isDark,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.white.withValues(alpha: 0.05) : AppColors.bgCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFF1F5F9),
          width: 1,
        ),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.08),
                  borderRadius: AppRadius.smRadius,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    svgAsset,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                    width: 18,
                    height: 18,
                  ),
                ),
              ),
              const Gap(12),
              Text(
                title,
                style: AppFont.font(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.white : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const Gap(12),
          Text(
            content,
            style: AppFont.font(
              fontSize: 12,
              color: isDark ? Colors.white70 : AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton(BuildContext context, bool isDark, SuccessStory detailedStory, String appName) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: FigmaColors.primaryGradient(context),
        borderRadius: AppTheme.getButtonBorderRadius(context),
        boxShadow: [FigmaColors.buttonShadow(context)],
      ),
      child: ElevatedButton(
        onPressed: () {
          String host = EnvConfig.baseUrl.replaceAll("/api/", "/");
          if (!host.endsWith("/")) {
            host += "/";
          }
          SharePlus.instance.share(
            ShareParams(
              text: "${'check_out_success_story'.trParams({'appName': appName})}: ${host}success-story/details/${detailedStory.id}",
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.getButtonBorderRadius(context),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.figmaSendMessage,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 20,
              height: 20,
            ),
            const Gap(10),
            Text(
              "share_this_story".tr,
              style: AppFont.font(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
