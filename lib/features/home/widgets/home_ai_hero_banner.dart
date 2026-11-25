import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';
import '../../matches/dynamic/screens/dynamic_ai_match_filter_screen.dart';

class HomeAiHeroBanner extends ConsumerWidget {
  final bool isDark;

  const HomeAiHeroBanner({super.key, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final primaryColor = Theme.of(context).primaryColor;

    void handleAiNavigation() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DynamicAiMatchFilterScreen()),
      );
    }

    return GestureDetector(
      onTap: handleAiNavigation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            secondaryColor,
            secondaryColor.withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: secondaryColor.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pill Tag: ⚡ AI POWERED
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppAssets.icAIMatch,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  height: 10,
                  width: 10,
                ),
                const Gap(4),
                Text(
                  'ai_powered'.tr,
                  style: AppFont.font(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          Builder(
            builder: (context) {
              final fullAiText = 'let_ai_find_your_perfect_match'.tr;
              String aiMainText = fullAiText;
              String aiHighlightedText = '';
              if (fullAiText.toLowerCase().contains('your perfect match')) {
                final idx = fullAiText.toLowerCase().indexOf('your perfect match');
                aiMainText = fullAiText.substring(0, idx);
                aiHighlightedText = fullAiText.substring(idx);
              }
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: aiMainText,
                      style: AppFont.font(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    if (aiHighlightedText.isNotEmpty)
                      TextSpan(
                        text: aiHighlightedText,
                        style: AppFont.font(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: primaryColor,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          const Gap(6),
          Text(
            'ai_algorithm_desc'.tr,
            style: AppFont.font(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.4,
            ),
          ),
          const Gap(16),
          // Action Bar
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: handleAiNavigation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.icAIMatchCard,
                          colorFilter: ColorFilter.mode(
                            primaryColor,
                            BlendMode.srcIn,
                          ),
                          height: 16,
                          width: 16,
                        ),
                        const Gap(6),
                        Text(
                          'match_with_ai'.tr,
                          style: AppFont.font(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}
