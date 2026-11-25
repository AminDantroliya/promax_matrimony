import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/home/data/models/dashboard_models.dart';
import 'package:pro_matrimony/features/home/providers/home_notifier.dart';
import 'package:pro_matrimony/utils/utils.dart';

class HomeStatsRow extends ConsumerWidget {
  final DashboardData data;
  final bool isDark;

  const HomeStatsRow({
    super.key,
    required this.data,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildCategory3StatCard(
              context: context,
              icon: AppAssets.icProfileCardCall,
              iconBg: Theme.of(context).primaryColor.withValues(alpha: 0.12),
              iconColor: Theme.of(context).primaryColor,
              count: '${data.callCount ?? 0}',
              label: 'calls_caps'.tr,
              onTap: () => context.push('/call-history'),
            ),
          ),
          const Gap(12),
          Expanded(
            child: _buildCategory3StatCard(
              context: context,
              icon: AppAssets.icProfileCardMatch,
              iconBg: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.12),
              iconColor: Theme.of(context).colorScheme.secondary,
              count: '${data.matchesCount ?? 0}',
              label: 'matches_caps'.tr,
              onTap: () {
                ref.read(homePageIndexProvider.notifier).setIndex(3);
                context.go('/home');
              },
            ),
          ),
          const Gap(12),
          Expanded(
            child: _buildCategory3StatCard(
              context: context,
              icon: AppAssets.icProfileCardChat,
              iconBg: Theme.of(context).primaryColor.withValues(alpha: 0.20),
              iconColor: Theme.of(context).primaryColor,
              count: '${data.chatCount ?? 0}',
              label: 'chats_caps'.tr,
              onTap: () {
                ref.read(homePageIndexProvider.notifier).setIndex(2);
                context.go('/home');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory3StatCard({
    required BuildContext context,
    required String icon,
    required Color iconBg,
    required Color iconColor,
    required String count,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          const Gap(10),
          Text(
            count,
            style: AppFont.font(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF16182F),
            ),
          ),
          const Gap(2),
          Text(
            label,
            style: AppFont.font(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF7C809B),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    ),
  );
}
}
