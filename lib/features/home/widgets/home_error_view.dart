import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../utils/utils.dart';
import '../providers/dashboard_notifier.dart';

class HomeErrorView extends ConsumerWidget {
  final bool isDark;
  final String? errorMessage;

  const HomeErrorView({
    super.key,
    required this.isDark,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rawMsg = errorMessage?.replaceAll('Exception: ', '').trim();
    final msg = (rawMsg != null && rawMsg.isNotEmpty)
        ? rawMsg.tr
        : 'something_went_wrong_please_retry'.tr;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final secondaryColor = theme.colorScheme.secondary;
    final config = ref.watch(appConfigProvider);

    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () => ref.read(dashboardProvider.notifier).refresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withValues(alpha: 0.18),
                      secondaryColor.withValues(alpha: 0.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.cloud_off_rounded,
                    size: 48,
                    color: primaryColor,
                  ),
                ),
              ),
              const Gap(24),
              Text(
                'failed_to_load_dashboard'.tr,
                textAlign: TextAlign.center,
                style: AppFont.font(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : theme.colorScheme.onSurface,
                ),
              ),
              const Gap(8),
              Text(
                msg,
                textAlign: TextAlign.center,
                style: AppFont.font(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? Colors.white70
                      : theme.colorScheme.onSurface.withValues(alpha: 0.65),
                  height: 1.4,
                ),
              ),
              const Gap(28),
              Container(
                height: 48,
                width: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      config.gradientStart,
                      config.gradientEnd,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(
                    config.borderRadius > 0 ? config.borderRadius : 24,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.35),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(
                      config.borderRadius > 0 ? config.borderRadius : 24,
                    ),
                    onTap: () => ref.read(dashboardProvider.notifier).refresh(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.refresh_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        const Gap(8),
                        Text(
                          'btn_retry'.tr,
                          style: AppFont.font(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
