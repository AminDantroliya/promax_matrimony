import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';

import '../../../features/success_stories/data/models/success_story_models.dart';
import '../../../utils/utils.dart';
import '../data/models/dashboard_models.dart';
import '../utils/home_helpers.dart';

class HomeSuccessStoriesSection extends StatelessWidget {
  final DashboardData data;

  const HomeSuccessStoriesSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final stories = data.successStories ?? [];

    if (stories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'success_space'.tr,
                      style: AppFont.font(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'stories_lbl'.tr,
                      style: AppFont.font(
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (stories.length > 4)
                GestureDetector(
                  onTap: () => context.push('/success-stories'),
                  child: Text(
                    'view_all'.tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const Gap(10),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: stories.length > 5 ? 5 : stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];
              String locationText = "";

              return GestureDetector(
                onTap: () {
                  context.push(
                    '/success-story-details',
                    extra: {'story': story},
                  );
                },
                child: Container(
                  width: 220,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF131422)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 140,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              child: getImageWidget(
                                url: _getStoryImageUrl(story),
                                boxFit: BoxFit.cover,
                                placeHolder: AppAssets.placeholderPng,
                              ),
                            ),
                            if (locationText.isNotEmpty)
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.55),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.figmaLocation,
                                        colorFilter: const ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcIn,
                                        ),
                                        width: 10,
                                        height: 10,
                                      ),
                                      const Gap(4),
                                      Text(
                                        locationText,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: story.groomname ?? '',
                                    style: TextStyle(
                                      // dynamic font
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : const Color(0xFF1A1A2E),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' & ',
                                    style: TextStyle(
                                      // dynamic font
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: story.bridename ?? '',
                                    style: TextStyle(
                                      // dynamic font
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : const Color(0xFF1A1A2E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(6),
                            Text(
                              story.successmessage ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppFont.font(
                                textStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white70
                                      : const Color(0xFF5A5A7A),
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getStoryImageUrl(SuccessStory story) {
    final isVideoStory = story.storyType == "Video Story";

    if (isVideoStory) {
      if (story.videoLink != null && story.videoLink!.isNotEmpty) {
        final videoId = HomeHelpers.getYouTubeId(story.videoLink);
        if (videoId != null && videoId.isNotEmpty) {
          return "https://img.youtube.com/vi/$videoId/hqdefault.jpg";
        }
      }
      if (story.weddingVideoThumbnail != null &&
          story.weddingVideoThumbnail!.isNotEmpty) {
        return HomeHelpers.getFullSuccessMediaUrl(story.weddingVideoThumbnail);
      }
      if (story.weddingphoto != null && story.weddingphoto!.isNotEmpty) {
        return HomeHelpers.getFullSuccessMediaUrl(story.weddingphoto);
      }
    } else {
      if (story.weddingphoto != null && story.weddingphoto!.isNotEmpty) {
        return HomeHelpers.getFullSuccessMediaUrl(story.weddingphoto);
      }
      if (story.weddingVideoThumbnail != null &&
          story.weddingVideoThumbnail!.isNotEmpty) {
        return HomeHelpers.getFullSuccessMediaUrl(story.weddingVideoThumbnail);
      }
    }
    return "";
  }
}
