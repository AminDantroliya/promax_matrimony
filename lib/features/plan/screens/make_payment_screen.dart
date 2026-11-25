import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/features/plan/providers/plan_notifier.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import '../../profile/providers/profile_notifier.dart';
import '../data/models/plan_models.dart';
import '../data/repositories/plan_repository.dart';
import '../providers/payment_notifier.dart';
import '../services/payment/payment_gateway_registry.dart';
import '../services/payment/payment_models.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:pro_matrimony/services/app_session_service.dart';
import '../../profile/data/models/profile_models.dart';

class MakePaymentScreen extends ConsumerStatefulWidget {
  final MembershipPlan plan;
  final List<AddOnPlan>? addons;
  final OfflinePayment? offlinePayment;
  final PaymentMethods? paymentMethods;

  const MakePaymentScreen({
    super.key,
    required this.plan,
    this.addons,
    this.offlinePayment,
    this.paymentMethods,
  });

  @override
  ConsumerState<MakePaymentScreen> createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends ConsumerState<MakePaymentScreen> {
  late final TextEditingController _couponController;

  @override
  void initState() {
    super.initState();
    _couponController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(paymentProvider.notifier)
          .initialize(widget.plan, widget.addons, widget.offlinePayment, widget.paymentMethods);
    });
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(myProfileProvider);
    final state = ref.watch(paymentProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen<PaymentState>(paymentProvider, (previous, next) {
      if (next.appliedCouponCode.isNotEmpty) {
        if (_couponController.text != next.appliedCouponCode) {
          _couponController.text = next.appliedCouponCode;
        }
      } else {
        if (previous?.appliedCouponCode.isNotEmpty == true) {
          _couponController.clear();
        }
      }
    });

    return Scaffold(
      backgroundColor: isDark ? premiumScreenBgDark : premiumScreenBgLight,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar to match Figma
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildGlassButton(
                    context,
                    icon: Icons.arrow_back,
                    onPressed: () => Navigator.pop(context),
                    isDark: isDark,
                  ),
                  Column(
                    children: [
                      Text(
                        'checkout_title'.tr,
                        style: AppFont.font(
                          color: isDark ? Colors.white : premiumDarkText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        'secure_payment_gateway'.tr,
                        style: AppFont.font(
                          color: isDark ? Colors.white60 : premiumSubtitle,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: state.isLoading
                  ? const Center(child: AppLoadingWidget())
                  : _buildBody(state, isDark),
            ),
          ],
        ),
      ),
      bottomNavigationBar: state.isLoading
          ? null
          : Container(
              color: isDark ? premiumScreenBgDark : premiumScreenBgLight,
              padding: EdgeInsets.fromLTRB(
                20,
                10,
                20,
                MediaQuery.of(context).padding.bottom > 0
                    ? MediaQuery.of(context).padding.bottom
                    : 16,
              ),
              child: _buildPaySecurelyButton(state, isDark),
            ),
    );
  }

  Widget _buildGlassButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
    bool showBadge = false,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isDark ? Theme.of(context).colorScheme.surface : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: premiumShadowColor.withValues(alpha: isDark ? 0.25 : 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isDark
                ? Colors.white10
                : Colors.black.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: isDark ? Colors.white : Theme.of(context).primaryColor, size: 20),
            if (showBadge)
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(PaymentState state, bool isDark) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopGradientCard(state, isDark),
          const Gap(20),
          _buildReceiptContainer(state, isDark),
          const Gap(20),
          _buildCouponInputSection(state, isDark),
          const Gap(20),
          _buildAddonList(state, isDark),
          const Gap(20),
          _buildSavingsBanner(state, isDark),
          const Gap(24),
          if (state.offlinePayment?.status == "APPROVED") ...[
            _buildOfflinePaymentHeader(isDark),
            const Gap(16),
            _buildQRCode(state.offlinePayment, isDark),
            const Gap(16),
            _buildBankDetails(state.offlinePayment, isDark),
            const Gap(24),
          ],
          const Gap(40), // Extra space so scroll content is not covered by sticky bottom bar
        ],
      ),
    );
  }

  Widget _buildTopGradientCard(PaymentState state, bool isDark) {
    final plan = state.selectedPlan;
    if (plan == null) return const SizedBox.shrink();

    final planNameUpper = (plan.planName ?? "PLAN").toUpperCase();
    final amt = plan.planAmount?.toString() ?? "";
    final isFree = amt == "0" || amt.toLowerCase() == "free" || amt.isEmpty;

    final String currency = isFree ? "" : (plan.planCurrency ?? "₹");
    final String amountStr = isFree ? "Free" : amt;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withValues(alpha: isDark ? 0.25 : 0.12),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Clipped Background Layer (Gradient + Circle Overlays)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                decoration: BoxDecoration(
                  gradient: FigmaColors.primaryGradient(context),
                ),
                child: Stack(
                  children: [
                    // Top Right Circle Overlay (Gentle Figma curve)
                    Positioned(
                      right: -60,
                      top: -80,
                      child: Container(
                        width: 240,
                        height: 240,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // Bottom Left Circle Overlay (Gentle Figma curve)
                    Positioned(
                      left: -50,
                      bottom: -70,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.06),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Unclipped Foreground Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag and Crown row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: premiumYellowLight,
                            size: 14,
                          ),
                          const Gap(5),
                          Text(
                            planNameUpper.contains("PLAN")
                                ? planNameUpper
                                : "$planNameUpper PLAN",
                            style: AppFont.font(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.figmaPremium,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          width: 28,
                          height: 28,
                          placeholderBuilder: (_) => const Icon(
                            Icons.workspace_premium_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                // Price text
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    if (currency.isNotEmpty) ...[
                      Text(
                        currency,
                        style: AppFont.font(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Gap(4),
                    ],
                    Text(
                      amountStr,
                      style: AppFont.font(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      '/ ${plan.planValidity ?? "30"} days',
                      style: AppFont.font(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Gap(18),
                // Subscription details row
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                    const Gap(6),
                    Text(
                      '${plan.planValidity ?? "0"} days subscription',
                      style: AppFont.font(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIcon(IconData icon, Color color, Color bgColor) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Center(child: Icon(icon, color: color, size: 18)),
    );
  }

  Widget _buildReceiptContainer(PaymentState state, bool isDark) {
    final plan = state.selectedPlan;
    if (plan == null) return const SizedBox.shrink();

    final currency = plan.planCurrency ?? "₹";

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: premiumShadowColor.withValues(alpha: isDark ? 0.25 : 0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'selected_plan_caps'.tr,
                style: AppFont.font(
                  color: isDark ? Colors.white60 : premiumSubtitle,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Text(
                      'btn_change'.tr,
                      style: AppFont.font(
                        color: Theme.of(context).primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(10),
          Text(
            '${plan.planName ?? "n_a".tr} • ${plan.planValidity ?? "30"} ${'days_lbl'.tr}',
            style: AppFont.font(
              color: isDark ? Colors.white : premiumDarkText,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(2),
          Text(
            'all_taxes_included'.tr,
            style: AppFont.font(
              color: isDark ? Colors.white60 : premiumSubtitle,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Gap(15),
          const Divider(height: 1, thickness: 0.5),
          const Gap(15),
          _buildReceiptRow(
            'plan_amount_lbl'.tr,
            '$currency${state.baseAmount.toStringAsFixed(2)}',
            _buildCircularIcon(
              Icons.account_balance_wallet_outlined,
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withValues(alpha: 0.1),
            ),
            isDark,
          ),
          if (state.taxApplicable == "Yes") ...[
            const Gap(12),
            _buildReceiptRow(
              '${state.taxName} (${state.serviceTax}%)',
              '+$currency${state.taxAmount.toStringAsFixed(2)}',
              _buildCircularIcon(
                Icons.description_outlined,
                Colors.blue,
                Colors.blue.withValues(alpha: 0.1),
              ),
              isDark,
              valueColor: Colors.blue,
            ),
          ],
          if (state.addonAmount > 0) ...[
            const Gap(12),
            _buildReceiptRow(
              'add_on_packages_caps'.tr,
              '+$currency${state.addonAmount.toStringAsFixed(2)}',
              _buildCircularIcon(
                Icons.add_circle_outline_rounded,
                Colors.orange,
                Colors.orange.withValues(alpha: 0.1),
              ),
              isDark,
              valueColor: Colors.orange,
            ),
          ],
          if (state.discountAmount > 0) ...[
            const Gap(12),
            _buildReceiptRow(
              'Discount'.tr,
              '-$currency${state.discountAmount.toStringAsFixed(2)}',
              _buildCircularIcon(
                Icons.local_offer_outlined,
                Colors.green,
                Colors.green.withValues(alpha: 0.1),
              ),
              isDark,
              valueColor: Colors.green,
            ),
          ],
          if (state.couponAmount > 0) ...[
            const Gap(12),
            _buildReceiptRow(
              'coupon_discount'.tr,
              '-$currency${state.couponAmount.toStringAsFixed(2)}',
              _buildCircularIcon(
                Icons.confirmation_number_outlined,
                Colors.green,
                Colors.green.withValues(alpha: 0.1),
              ),
              isDark,
              valueColor: Colors.green,
            ),
          ],
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : const Color(0xFFF5F7FC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'total_amount_lbl'.tr,
                  style: AppFont.font(
                    color: isDark ? Colors.white : premiumDarkText,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$currency${state.finalAmount.toStringAsFixed(2)}',
                  style: AppFont.font(
                    color: isDark ? Colors.white : premiumDarkText,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptRow(
    String label,
    String value,
    Widget leading,
    bool isDark, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        leading,
        const Gap(12),
        Expanded(
          child: Text(
            label,
            style: AppFont.font(
              color: isDark ? Colors.white70 : premiumDarkText,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          value,
          style: AppFont.font(
            color: valueColor ?? (isDark ? Colors.white : premiumDarkText),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCouponInputSection(PaymentState state, bool isDark) {
    final hasCoupon = state.appliedCouponCode.isNotEmpty;

    final borderPaint = DashedBorderPainter(
      color: isDark ? Colors.white24 : Theme.of(context).primaryColor.withValues(alpha: 0.3),
      strokeWidth: 1.5,
      radius: 18,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'coupon_caps'.tr,
            style: AppFont.font(
              color: isDark ? Colors.white60 : premiumSubtitle,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
        CustomPaint(
          painter: borderPaint,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _showCouponsBottomSheet(state),
                  child: _buildCircularIcon(
                    Icons.confirmation_number_outlined,
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'coupon_code_caps'.tr,
                        style: AppFont.font(
                          color: isDark ? Colors.white60 : premiumSubtitle,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const Gap(2),
                      TextField(
                        controller: _couponController,
                        enabled: !hasCoupon,
                        style: AppFont.font(
                          color: isDark ? Colors.white : premiumDarkText,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: "enter_promo_code".tr,
                          hintStyle: AppFont.font(
                            color: isDark ? Colors.white30 : Colors.black38,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (hasCoupon) {
                      ref.read(paymentProvider.notifier).removeCoupon();
                      _couponController.clear();
                    } else {
                      final code = _couponController.text.trim();
                      if (code.isEmpty) {
                        showToast('please_enter_coupon_code'.tr);
                        return;
                      }
                      final success = await ref
                          .read(paymentProvider.notifier)
                          .applyCoupon(code);
                      if (success) {
                        showToast('coupon_code_applied_success'.tr);
                      } else {
                        showToast('invalid_coupon_code'.tr);
                      }
                    }
                  },
                  child: Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: hasCoupon
                          ? null
                          : FigmaColors.primaryGradient(context),
                      color: hasCoupon
                          ? Colors.red.withValues(alpha: 0.1)
                          : null,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: hasCoupon
                          ? null
                          : [
                              BoxShadow(
                                color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    child: Center(
                      child: Text(
                        hasCoupon ? 'btn_remove'.tr : 'btn_apply'.tr,
                        style: AppFont.font(
                          color: hasCoupon ? Colors.red : Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showCouponsBottomSheet(PaymentState state) {
    if (state.coupons.isEmpty) {
      showToast('no_coupons_found'.tr);
      return;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF13141F) : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Gap(20),
              Text(
                'available_coupons'.tr,
                style: AppFont.font(
                  color: isDark ? Colors.white : premiumDarkText,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.coupons.length,
                  itemBuilder: (ctx, index) {
                    final coupon = state.coupons[index];
                    final isSelected = state.selectedCouponIndex == index;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : const Color(0xFFF5F7FC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        onTap: () {
                          ref
                              .read(paymentProvider.notifier)
                              .selectCoupon(index);
                          Navigator.pop(context);
                        },
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.confirmation_number_outlined,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              coupon.coupanCode ?? "n_a".tr,
                              style: AppFont.font(
                                color: isDark ? Colors.white : premiumDarkText,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${coupon.discountAmount ?? 0}% ${'off_lbl'.tr}",
                              style: AppFont.font(
                                color: Colors.green,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            'applicable_on_plan'.trParams({'plan': state.selectedPlan?.planName ?? 'this_plan'.tr}),
                            style: AppFont.font(
                              color: isDark ? Colors.white60 : premiumSubtitle,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(
                                Icons.check_circle_rounded,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              )
                            : const Icon(
                                Icons.circle_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddonList(PaymentState state, bool isDark) {
    if (state.addOnPlans.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'add_on_packages_caps'.tr,
            style: AppFont.font(
              color: isDark ? Colors.white60 : premiumSubtitle,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.addOnPlans.length,
          itemBuilder: (context, index) {
            final addon = state.addOnPlans[index];
            final selected = state.selectedAddonIds.contains(addon.id);
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: premiumShadowColor.withValues(
                      alpha: isDark ? 0.2 : 0.05,
                    ),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: selected
                      ? Theme.of(context).primaryColor
                      : (isDark
                            ? Colors.white10
                            : Colors.black.withValues(alpha: 0.05)),
                  width: selected ? 2 : 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  onTap: () =>
                      ref.read(paymentProvider.notifier).toggleAddon(addon),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                addon.packageTitle ?? "n_a".tr,
                                style: AppFont.font(
                                  color: isDark
                                      ? Colors.white
                                      : premiumDarkText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (selected)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "added_caps".tr,
                                  style: AppFont.font(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const Gap(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Amount: ${state.selectedPlan?.planCurrency ?? "₹"}${addon.packageAmount}",
                              style: AppFont.font(
                                color: isDark ? Colors.white : premiumDarkText,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${addon.packageCategory}: ${addon.packageCount}",
                              style: AppFont.font(
                                color: isDark
                                    ? Colors.white70
                                    : premiumSubtitle,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        if (addon.description != null &&
                            addon.description!.isNotEmpty) ...[
                          const Gap(6),
                          const Divider(height: 1, thickness: 0.5),
                          const Gap(6),
                          Text(
                            addon.description!,
                            style: AppFont.font(
                              color: isDark ? Colors.white60 : premiumSubtitle,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSavingsBanner(PaymentState state, bool isDark) {
    final savings = state.discountAmount + state.couponAmount;
    final currency = state.selectedPlan?.planCurrency ?? "₹";

    final bool hasSavings = savings > 0;
    final savingsText = hasSavings
        ? 'saving_order_msg'.trParams({'amount': '$currency${savings.toStringAsFixed(0)}'})
        : 'unlock_best_value_matches'.tr;
    final subtitleText = hasSavings
        ? 'best_value_discount_applied'.tr
        : 'connect_instantly_premium'.tr;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF8F1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF2ECC71).withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFF2ECC71),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.card_giftcard_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  savingsText,
                  style: AppFont.font(
                    color: const Color(0xFF196F3D),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(2),
                Text(
                  subtitleText,
                  style: AppFont.font(
                    color: const Color(0xFF196F3D).withValues(alpha: 0.7),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaySecurelyButton(PaymentState state, bool isDark) {
    final currency = state.selectedPlan?.planCurrency ?? "₹";
    final paymentMethods = state.paymentMethods ?? widget.paymentMethods;
    final rawGatewayName = (paymentMethods?.paymentName != null && paymentMethods!.paymentName!.trim().isNotEmpty)
        ? paymentMethods.paymentName!.trim()
        : (paymentMethods?.paypal?.trim().isNotEmpty == true ? 'paypal' : 'cashfree');

    final gateway = PaymentGatewayRegistry.getGateway(rawGatewayName) ??
        PaymentGatewayRegistry.getGateway('cashfree') ??
        PaymentGatewayRegistry.getGateway('paypal');

    return GestureDetector(
      onTap: () async{
        ProfileData? myProfile = ref.read(myProfileProvider).value;
        if (myProfile == null) {
          showLoading(context);
          try {
            myProfile = await ref.read(myProfileProvider.future);
          } catch (_) {}
          hideLoading();
        }
        if (myProfile == null) {
          final jsonStr = AppSessionService.getValue("userProfileData") as String?;
          if (jsonStr != null && jsonStr.isNotEmpty) {
            try {
              myProfile = ProfileData.fromJson(json.decode(jsonStr));
            } catch (_) {}
          }
        }
        if (myProfile == null) {
          showToast("user_profile_not_found".tr);
          return;
        }

        if (gateway == null) {
          showToast("Payment gateway ($rawGatewayName) is not available.");
          return;
        }

        final request = PaymentRequest(
          amount: state.finalAmount,
          currency: currency,
          planId: state.selectedPlan?.id?.toString() ?? "",
          planName: state.selectedPlan?.planName ?? "Membership Plan",
          planDescription: state.selectedPlan?.planDescription ?? "",
          userProfile: myProfile,
          paymentMethods: paymentMethods,
          couponCode: state.appliedCouponCode,
          packageIds: state.selectedAddonIds.join(','),
        );

        gateway.processPayment(
          context: context,
          request: request,
          onSuccess: (result) async {
            if (!mounted) return;
            showLoading(context);
            try {
              final params = {
                "plan_id": request.planId,
                "member_id": myProfile?.id.toString(),
                "coupon_code": request.couponCode,
                "package_ids": request.packageIds,
                "transaction_id": result.transactionId,
                "payment_gateway": result.gatewayName,
              };

              final res = await ref.read(planRepositoryProvider).assignPlanNew(params);
              if (!mounted) return;
              hideLoading();

              if (res['status'] == "success") {
                showToast("payment_success_matrimonial".tr);
                ref.invalidate(currentPlanProvider);
                ref.invalidate(myProfileProvider);
                context.go('/current-plan', extra: true);
              } else {
                showToast(res['message'] ?? "failed_to_assign_plan".tr);
              }
            } catch (e) {
              if (mounted) hideLoading();
              showToast("error_processing_payment".tr);
            }
          },
          onCancel: () {
            showToast("payment_cancelled_by_user".tr);
          },
          onError: (error) {
            showToast(error);
          },
        );
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: FigmaColors.primaryGradient(context),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            const Gap(16),
            const Icon(
              Icons.verified_user_rounded,
              color: Colors.white,
              size: 20,
            ),
            const Gap(10),
            Expanded(
              child: Text(
                gateway != null
                    ? '${'pay_securely'.tr} (${gateway.displayName})'
                    : 'pay_securely'.tr,
                style: AppFont.font(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$currency${state.finalAmount.toStringAsFixed(0)}',
                    style: AppFont.font(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(6),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 14,
                  ),
                ],
              ),
            ),
            const Gap(8),
          ],
        ),
      ),
    );
  }

  Widget _buildOfflinePaymentHeader(bool isDark) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        const Gap(12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Text(
            'offline_payment_options_caps'.tr,
            style: AppFont.font(
              color: Theme.of(context).primaryColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const Gap(12),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildQRCode(OfflinePayment? offline, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: premiumShadowColor.withValues(alpha: isDark ? 0.25 : 0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'scan_pay_bhim_upi'.tr,
            style: AppFont.font(
              color: isDark ? Colors.white : premiumDarkText,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: getImageWidget(
              url: offline?.qrCode ?? "",
              placeHolder: AppAssets.qrPlaceholder,
              imageWidth: 160,
              imageHeight: 160,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetails(OfflinePayment? offline, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: premiumShadowColor.withValues(alpha: isDark ? 0.25 : 0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'pay_by_bank_transfer'.tr,
              style: AppFont.font(
                color: isDark ? Colors.white : premiumDarkText,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Gap(16),
          _bankRow('bank_name'.tr, offline?.bankName ?? "n_a".tr, isDark),
          const Divider(height: 12, thickness: 0.5),
          _bankRow(
            'account_holder'.tr,
            offline?.accountHolderNumber ?? "n_a".tr,
            isDark,
          ),
          const Divider(height: 12, thickness: 0.5),
          _bankRow('account_number'.tr, offline?.accountNumber ?? "n_a".tr, isDark),
          const Divider(height: 12, thickness: 0.5),
          _bankRow('bank_branch'.tr, offline?.bankBranch ?? "n_a".tr, isDark),
          const Divider(height: 12, thickness: 0.5),
          _bankRow('ifsc_code'.tr, offline?.ifscCode ?? "n_a".tr, isDark),
        ],
      ),
    );
  }

  Widget _bankRow(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppFont.font(
                color: isDark ? Colors.white70 : premiumSubtitle,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            "::",
            style: AppFont.font(
              color: isDark ? Colors.white30 : Colors.black12,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(12),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppFont.font(
                color: isDark ? Colors.white : premiumDarkText,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dash;
  final double radius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1,
    this.gap = 4,
    this.dash = 6,
    this.radius = 16,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ),
    );

    final Path dashedPath = Path();
    double distance = 0.0;
    for (PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        dashedPath.addPath(
          measurePath.extractPath(distance, distance + dash),
          Offset.zero,
        );
        distance += dash + gap;
      }
    }
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.gap != gap ||
      oldDelegate.dash != dash ||
      oldDelegate.radius != radius;
}
