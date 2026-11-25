import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/core/config/env_config.dart';

import '../../../features/success_stories/data/models/success_story_models.dart';

class SuccessStoryListItem extends ConsumerWidget {
  final SuccessStory story;
  final int index;

  const SuccessStoryListItem({
    super.key,
    required this.story,
    required this.index,
  });

  String _getFormattedDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "married_lbl".tr;
    try {
      final date = DateTime.parse(dateStr);
      final months = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec",
      ];
      return "${'married_lbl'.tr} ${months[date.month - 1]} ${date.year}";
    } catch (e) {
      return dateStr;
    }
  }

  String _getDuration(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "six_months".tr;
    try {
      final date = DateTime.parse(dateStr);
      final today = DateTime.now();
      final difference = today.difference(date).inDays;
      final months = (difference / 30).round();
      if (months <= 0) {
        return "recent_lbl".tr;
      }
      return "$months ${'months_lbl'.tr}";
    } catch (e) {
      return "six_months".tr;
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
      if (story.weddingVideoThumbnail != null &&
          story.weddingVideoThumbnail!.isNotEmpty) {
        return getFullMediaUrl(story.weddingVideoThumbnail);
      }
      if (story.weddingphoto != null && story.weddingphoto!.isNotEmpty) {
        return getFullMediaUrl(story.weddingphoto);
      }
    } else {
      if (story.weddingphoto != null && story.weddingphoto!.isNotEmpty) {
        return getFullMediaUrl(story.weddingphoto);
      }
      if (story.weddingVideoThumbnail != null &&
          story.weddingVideoThumbnail!.isNotEmpty) {
        return getFullMediaUrl(story.weddingVideoThumbnail);
      }
    }
    return "";
  }

  void _playVideo(BuildContext context) {
    final isYoutube = getDisplayString(story.videoType, defaultValue: "") == "youtube";
    final String url;
    if (isYoutube) {
      url = story.videoLink!;
    } else if (story.weddingVideoFile != null && story.weddingVideoFile!.isNotEmpty) {
      url = getFullMediaUrl(story.weddingVideoFile!);
    } else {
      url = "";
    }
    if (url.isNotEmpty) {
      context.push('/play-video', extra: {'videoUrl': url, 'isYoutube': isYoutube});
    }else{
      context.push('/success-story-details', extra: {'story': story});
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final isVideoStory = story.storyType == "Video Story";

    if (isVideoStory) {
      return _buildVideoStoryCard(context, isDark);
    } else {
      return _buildStandardStoryCard(context, isDark);
    }
  }

  Widget _buildVideoStoryCard(BuildContext context, bool isDark) {
    final imageUrl = _getStoryImageUrl(story);
    final formattedDate = _getFormattedDate(story.marriagedate);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: double.infinity,
        height: 335,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: AppShadows.card,
        ),
        child: Stack(
          children: [
            // 1. Background image (opens details on tap)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  context.push(
                    '/success-story-details',
                    extra: {'story': story},
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: getImageWidget(
                    url: imageUrl,
                    boxFit: BoxFit.cover,
                    placeHolder: AppAssets.placeholderPng,
                  ),
                ),
              ),
            ),
            // 2. Black linear overlay scrim (taps open details)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  context.push(
                    '/success-story-details',
                    extra: {'story': story},
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.85),
                        ],
                        stops: const [0.3, 1.0],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // 3. Top Badges
            Positioned(
              top: 14,
              left: 14,
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFB300),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.figmaSuccessStoryPremium,
                    width: 14,
                    height: 14,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 14,
              right: 14,
              child: GestureDetector(
                onTap: () => _playVideo(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24, width: 0.8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.videocam_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                      const Gap(4),
                      Text(
                        "watch_lbl".tr,
                        style: AppFont.font(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 4. Center Play Indicator (plays video on tap)
            Center(
              child: GestureDetector(
                onTap: () => _playVideo(context),
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
            // 5. Bottom Overlay Details (taps open details)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  context.push(
                    '/success-story-details',
                    extra: {'story': story},
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${story.bridename} ",
                            style: AppFont.font(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Icon(
                            Icons.favorite_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          Text(
                            " ${story.groomname}",
                            style: AppFont.font(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Gap(6),
                      Text(
                        story.successmessage != null &&
                            story.successmessage!.length > 90
                            ? "\"${story.successmessage!.substring(0, 90)}...\""
                            : "\"${story.successmessage ?? ""}\"",
                        style: AppFont.font(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.8),
                          height: 1.4,
                        ),
                      ),
                      const Gap(12),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.successStoryDate,
                            width: 12,
                            height: 12,
                            colorFilter: const ColorFilter.mode(
                              Colors.white60,
                              BlendMode.srcIn,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            formattedDate,
                            style: AppFont.font(
                              fontSize: 10,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandardStoryCard(BuildContext context, bool isDark) {
    final imageUrl = _getStoryImageUrl(story);
    final durationStr = _getDuration(story.marriagedate);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          context.push('/success-story-details', extra: {'story': story});
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.white.withValues(alpha: 0.05)
                : AppColors.bgCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : const Color(0xFFF1F5F9),
              width: 1,
            ),
            boxShadow: AppShadows.card,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Image with Top-Left Verified Badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: getImageWidget(
                      url: imageUrl,
                      boxFit: BoxFit.cover,
                      imageHeight: 300,
                      imageWidth: double.infinity,
                      placeHolder: AppAssets.placeholderPng,
                    ),
                  ),
                  Positioned(
                    top: 14,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24, width: 0.8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFB300),
                            size: 12,
                          ),
                          const Gap(4),
                          Text(
                            "verified_lbl".tr,
                            style: AppFont.font(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // 2. Card Details Box
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${story.bridename} ",
                          style: AppFont.font(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                        const Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                          size: 14,
                        ),
                        Text(
                          " ${story.groomname}",
                          style: AppFont.font(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const Gap(6),
                    Text(
                      story.successmessage != null &&
                          story.successmessage!.length > 110
                          ? "\"${story.successmessage!.substring(0, 110)}...\""
                          : "\"${story.successmessage ?? ""}\"",
                      style: AppFont.font(
                        fontSize: 12,
                        color: isDark
                            ? Colors.white60
                            : AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const Gap(14),
                    Divider(
                      color: isDark ? Colors.white12 : const Color(0xFFF1F5F9),
                      height: 1,
                      thickness: 1,
                    ),
                    const Gap(14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.successStoryDate,
                              width: 14,
                              height: 14,
                              colorFilter: ColorFilter.mode(
                                isDark ? Colors.white30 : AppColors.textMuted,
                                BlendMode.srcIn,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              durationStr,
                              style: AppFont.font(
                                fontSize: 11,
                                color: isDark
                                    ? Colors.white60
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "read_story".tr,
                                style: AppFont.font(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const Gap(4),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Theme.of(context).primaryColor,
                                size: 10,
                              ),
                            ],
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
      ),
    );
  }
}
