import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/app_no_records_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/invoice_download_button.dart';
import '../providers/plan_notifier.dart';

class DashedDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashGap;

  const DashedDivider({
    super.key,
    this.height = 1.0,
    this.color = Colors.grey,
    this.dashWidth = 5.0,
    this.dashGap = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (dashWidth + dashGap)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }
}

class PlanHistoryScreen extends ConsumerWidget {
  const PlanHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(planHistoryProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Premium Gradient Header Background
            Container(
              height: 245,
              decoration: BoxDecoration(
                gradient: FigmaColors.primaryGradient(context),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
            ),
            // Header Content & Scroll View
            SafeArea(
              child: Column(
                children: [
                  // App Bar Row
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        _buildHeaderButton(
                          context,
                          icon: Icons.arrow_back,
                          onTap: () => Navigator.pop(context),
                        ),
                        const Gap(14),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _buildSplitHeaderTitle(
                              context,
                              'plan_history'.tr,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Content area
                  Expanded(
                    child: historyAsync.when(
                      data: (historyList) {
                        if (historyList == null || historyList.isEmpty) {
                          return Center(
                            child: AppNoRecordsWidget(
                              noRecordFoundMessage: 'no_plan_history_found'.tr,
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(16),
                            vertical: 12,
                          ),
                          itemCount: historyList.length,
                          itemBuilder: (context, index) {
                            final item = historyList[index];
                            final activeDate =
                                item.planActivateDate ??
                                item.planActivated ??
                                "";
                            final expiryDate =
                                item.planExpiryDate ?? item.planExpired ?? "";
                            final currency =
                                item.currencyCode ?? item.planCurrency ?? "₹";
                            final isSuccess =
                                item.status?.toUpperCase() == "SUCCESS" ||
                                item.status?.toUpperCase() == "APPROVED";

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF1E1F2E)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 15,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Plan Title & Status Badge Row
                                  Row(
                                    children: [
                                      Container(
                                        width: 42,
                                        height: 42,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: SvgPicture.asset(
                                          AppAssets.figmaDiamonds,
                                          colorFilter: ColorFilter.mode(
                                            Theme.of(context).primaryColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                      const Gap(12),
                                      Expanded(
                                        child: Text(
                                          item.planName ?? "n_a".tr,
                                          style: AppFont.font(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSuccess
                                              ? const Color(0xFFE8F5E9)
                                              : const Color(0xFFFFF3E0),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text(
                                          item.status?.toUpperCase() ??
                                              "PENDING",
                                          style: AppFont.font(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w800,
                                            color: isSuccess
                                                ? const Color(0xFF4CAF50)
                                                : const Color(0xFFFF9800),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(16),
                                  DashedDivider(
                                    color: isDark
                                        ? Colors.white24
                                        : Colors.grey.shade200,
                                    dashWidth: 4,
                                    dashGap: 3,
                                  ),
                                  const Gap(16),
                                  // Details Grid
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _detailColumn(
                                          context,
                                          'active_from_lbl'.tr,
                                          getFormattedPlanDate(activeDate),
                                          isDark,
                                        ),
                                      ),
                                      Expanded(
                                        child: _detailColumn(
                                          context,
                                          'expires_on_lbl'.tr,
                                          getFormattedPlanDate(expiryDate),
                                          isDark,
                                          alignEnd: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(14),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _detailColumn(
                                          context,
                                          'amount_paid_lbl'.tr,
                                          "$currency ${item.grandTotal ?? "0"}",
                                          isDark,
                                          valueColor: const Color(0xFF4CAF50),
                                        ),
                                      ),
                                      Expanded(
                                        child: _detailColumn(
                                          context,
                                          'payment_mode_lbl2'.tr,
                                          item.paymentMode ?? "n_a".tr,
                                          isDark,
                                          alignEnd: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Download Invoice Button if download link exists
                                  if (item.downloadInvoice != null &&
                                      item.downloadInvoice!.isNotEmpty) ...[
                                    const Gap(16),
                                    DashedDivider(
                                      color: isDark
                                          ? Colors.white24
                                          : Colors.grey.shade200,
                                      dashWidth: 4,
                                      dashGap: 3,
                                    ),
                                    const Gap(14),
                                    InvoiceDownloadButton(
                                      url: item.downloadInvoice!,
                                      invoiceId:
                                          item.id?.toString() ?? "hist_$index",
                                    ),
                                  ],
                                ],
                              ),
                            );
                          },
                        );
                      },
                      loading: () => const Center(child: AppLoadingWidget()),
                      error: (err, stack) => Center(child: Text("Error: $err")),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSplitHeaderTitle(BuildContext context, String text) {
    return buildAppTitleWidget(
      context,
      text,
      primaryColor: Colors.white,
      secondaryColor: Colors.white,
    );
  }

  Widget _buildHeaderButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }

  Widget _detailColumn(
    BuildContext context,
    String label,
    String value,
    bool isDark, {
    Color? valueColor,
    bool alignEnd = false,
  }) {
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFont.font(
            fontSize: 11,
            color: isDark ? Colors.white54 : Colors.grey.shade500,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(4),
        Text(
          value,
          style: AppFont.font(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
