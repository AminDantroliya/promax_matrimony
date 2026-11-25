import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/features/plan/providers/plan_notifier.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/features/profile/providers/profile_notifier.dart';
import 'package:pro_matrimony/features/plan/data/models/plan_models.dart';
import 'package:pro_matrimony/features/plan/data/repositories/plan_repository.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/plan/providers/membership_notifier.dart';
import 'package:pro_matrimony/features/plan/services/payment/payment_gateway_registry.dart';
import 'package:pro_matrimony/features/plan/services/payment/payment_models.dart';
import 'dart:convert';
import 'package:pro_matrimony/features/profile/data/models/profile_models.dart';
import 'package:pro_matrimony/services/app_session_service.dart';


// ── Provider ──────────────────────────────────────────────────────────────────

final addonPackageListProvider = FutureProvider.autoDispose<List<AddOnPlan>>((
  ref,
) async {
  return ref.read(planRepositoryProvider).getAddonPackageList();
});

// ── Screen ────────────────────────────────────────────────────────────────────

class AddonPlanScreen extends ConsumerStatefulWidget {
  const AddonPlanScreen({super.key});

  @override
  ConsumerState<AddonPlanScreen> createState() => _AddonPlanScreenState();
}

class _AddonPlanScreenState extends ConsumerState<AddonPlanScreen> {
  int? _selectedAddonId;
  AddOnPlan? _selectedAddon;

  // In-App Purchase
  StreamSubscription<List<PurchaseDetails>>? _iapSubscription;

  @override
  void initState() {
    super.initState();
    final purchaseStream = InAppPurchase.instance.purchaseStream;
    _iapSubscription = purchaseStream.listen(
      _handleIapUpdates,
      onDone: () => _iapSubscription?.cancel(),
      onError: (e) => showToast('IAP stream error: $e'),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(membershipProvider).planList == null) {
        ref.read(membershipProvider.notifier).fetchPlans();
      }
    });
  }

  @override
  void dispose() {
    _iapSubscription?.cancel();
    super.dispose();
  }

  // ── IAP handlers ───────────────────────────────────────────────────────────

  void _handleIapUpdates(List<PurchaseDetails> list) async {
    for (final pd in list) {
      if (pd.status == PurchaseStatus.pending) {
        showLoading(context);
      } else {
        hideLoading();

        if (pd.status == PurchaseStatus.error) {
          showToast(pd.error?.message ?? 'purchase_failed'.tr);
        } else if (pd.status == PurchaseStatus.canceled) {
          // User canceled purchase
        } else if (pd.status == PurchaseStatus.purchased ||
            pd.status == PurchaseStatus.restored) {
          showLoading(context);
          final txId =
              pd.purchaseID ??
              pd.transactionDate ??
              DateTime.now().millisecondsSinceEpoch.toString();
          await _assignAddonPlan(txId, pd);
        }
        if (pd.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(pd);
        }
      }
    }
  }

  // ── Payment flows ──────────────────────────────────────────────────────────

  bool _shouldUseInAppPurchase(MembershipState state) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) return true;

    final isAndroid = Theme.of(context).platform == TargetPlatform.android;
    if (isAndroid) {
      final paymentMethods = state.planList?.data?.paymentMethods;
      final isInAppActive =
          paymentMethods?.inAppPayment?.toLowerCase() == "active";
      if (isInAppActive) return true;
    }
    return false;
  }

  String _getCurrencySymbol(String? currencyCode) {
    if (currencyCode == null || currencyCode.trim().isEmpty) return "₹";
    final code = currencyCode.toUpperCase().trim();
    if (code == "INR" || code == "₹") return "₹";
    if (code == "USD" || code == "\$") return "\$";
    if (code == "EUR" || code == "€") return "€";
    if (code == "GBP" || code == "£") return "£";
    return currencyCode;
  }

  String _resolveCurrencyCode(AddOnPlan? addon, MembershipState membershipState) {
    if (addon?.currencyCode != null && addon!.currencyCode!.trim().isNotEmpty) {
      return addon.currencyCode!.trim();
    }
    if (addon?.packageCurrency != null && addon!.packageCurrency!.trim().isNotEmpty) {
      return addon.packageCurrency!.trim();
    }
    if (addon?.planCurrency != null && addon!.planCurrency!.trim().isNotEmpty) {
      return addon.planCurrency!.trim();
    }
    final firstPlan = membershipState.planList?.data?.membershipPlanArr?.firstOrNull;
    if (firstPlan?.currencyCode != null && firstPlan!.currencyCode!.trim().isNotEmpty) {
      return firstPlan.currencyCode!.trim();
    }
    if (firstPlan?.planCurrency != null && firstPlan!.planCurrency!.trim().isNotEmpty) {
      return firstPlan.planCurrency!.trim();
    }
    return "INR";
  }

  String _getAddonCurrencySymbol(AddOnPlan? addon, MembershipState membershipState) {
    final code = _resolveCurrencyCode(addon, membershipState);
    return _getCurrencySymbol(code);
  }

  Future<void> _handleBuyTapped(MembershipState state) async {
    if (_selectedAddon == null) {
      showToast('please_select_addon'.tr);
      return;
    }

    if (_shouldUseInAppPurchase(state)) {
      await _initiateIapPurchase();
    } else {
      await _initiateGatewayPurchase(state);
    }
  }

  Future<void> _initiateIapPurchase() async {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final productId = isIOS
        ? (_selectedAddon!.inAppPurchaseIosId ??
            _selectedAddon!.inAppProductId?.toString() ??
            _selectedAddon!.id.toString())
        : (_selectedAddon!.inAppPurchaseAndroidId ??
            _selectedAddon!.inAppProductId?.toString() ??
            _selectedAddon!.id.toString());

    if (productId.isEmpty) {
      showToast("In-app purchase product ID not configured for this addon.");
      return;
    }

    showLoading(context);
    try {
      final bool isAvailable = await InAppPurchase.instance.isAvailable();
      if (!isAvailable) {
        hideLoading();
        showToast('iap_store_unavailable'.tr);
        return;
      }

      final ProductDetailsResponse response = await InAppPurchase.instance
          .queryProductDetails({productId});

      if (response.error != null) {
        hideLoading();
        showToast(
          'iap_product_error'.trParams({'error': response.error!.message}),
        );
        return;
      }

      if (response.productDetails.isEmpty) {
        hideLoading();
        showToast('iap_product_not_found'.tr);
        return;
      }

      hideLoading();
      final productDetails = response.productDetails.first;
      await InAppPurchase.instance.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: productDetails),
      );
    } catch (e) {
      hideLoading();
      showToast('iap_initiate_error'.trParams({'error': '$e'}));
    }
  }

  Future<void> _initiateGatewayPurchase(MembershipState state) async {
    final addon = _selectedAddon!;
    final amount = double.tryParse(addon.packageAmount?.toString() ?? '0') ?? 0;
    final currencyCode = _resolveCurrencyCode(addon, state);
    final paymentMethods = state.planList?.data?.paymentMethods;
    ProfileData? myProfile = ref.read(myProfileProvider).value;
    if (myProfile == null) {
      try {
        myProfile = await ref.read(myProfileProvider.future);
      } catch (_) {}
    }
    if (myProfile == null) {
      final jsonStr = AppSessionService.getValue("userProfileData") as String?;
      if (jsonStr != null && jsonStr.isNotEmpty) {
        try {
          myProfile = ProfileData.fromJson(json.decode(jsonStr));
        } catch (_) {}
      }
    }

    final gateway = PaymentGatewayRegistry.getGateway(paymentMethods?.paymentName);
    if (gateway == null) {
      showToast('Payment gateway not available.');
      return;
    }

    final request = PaymentRequest(
      amount: amount,
      currency: currencyCode,
      planName: addon.packageTitle ?? 'Addon Package',
      planDescription: addon.description ?? 'Addon Plan Purchase',
      userProfile: myProfile,
      paymentMethods: paymentMethods,
      userEmail: myProfile?.email?.toString(),
      userPhone: myProfile?.mobile?.toString(),
      userName: myProfile?.fullname?.toString(),
      metadata: {
        'addon_id': addon.id,
      },
    );

    try {
      gateway.processPayment(
        context: context,
        request: request,
        onSuccess: (result) async {
          if (!mounted) return;
          showLoading(context);
          await _assignAddonPlan(result.transactionId);
        },
        onError: (error) {
          if (!mounted) return;
          showToast(error);
        },
        onCancel: () {
          if (!mounted) return;
          showToast('payment_cancelled_by_user'.tr);
        },
      );
    } catch (e) {
      if (mounted) hideLoading();
      showToast('error_processing_payment'.tr);
    }
  }

  Future<void> _assignAddonPlan(String transactionId, [PurchaseDetails? purchaseDetails]) async {
    ProfileData? myProfile = ref.read(myProfileProvider).value;
    if (myProfile == null) {
      try {
        myProfile = await ref.read(myProfileProvider.future);
      } catch (_) {}
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
      hideLoading();
      showToast('user_profile_not_found'.tr);
      return;
    }

    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final productId = purchaseDetails?.productID ??
        (isIOS
            ? (_selectedAddon?.inAppPurchaseIosId ??
                _selectedAddon?.inAppProductId?.toString() ??
                _selectedAddon?.id.toString())
            : (_selectedAddon?.inAppPurchaseAndroidId ??
                _selectedAddon?.inAppProductId?.toString() ??
                _selectedAddon?.id.toString()));

    try {
      final params = {
        'plan_id': '',
        'member_id': myProfile.id.toString(),
        'coupon_code': '',
        'package_ids': _selectedAddon?.id.toString() ?? '',
        'transaction_id': transactionId,
        'product_id': productId ?? '',
        'platform': isIOS ? 'ios' : 'android',
        'purchase_token':
            purchaseDetails?.verificationData.serverVerificationData ?? '',
        'local_verification_data':
            purchaseDetails?.verificationData.localVerificationData ?? '',
        'verification_source': purchaseDetails?.verificationData.source ?? '',
        'purchase_type': 'addon',
        'purchase_status': purchaseDetails?.status.name ?? 'purchased',
      };

      final result = await ref
          .read(planRepositoryProvider)
          .assignPlanNew(params);

      if (!mounted) return;
      hideLoading();

      if (result['status'] == 'success') {
        showToast('payment_success_matrimonial'.tr);
        ref.invalidate(currentPlanProvider);
        ref.invalidate(myProfileProvider);
        context.go('/current-plan', extra: true);
      } else {
        showToast(result['message'] ?? 'failed_to_assign_plan'.tr);
      }
    } catch (e) {
      if (mounted) hideLoading();
      showToast('error_processing_payment'.tr);
    }
  }

  // ── UI ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    ref.watch(myProfileProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final addonAsync = ref.watch(addonPackageListProvider);
    final membershipState = ref.watch(membershipProvider);

    return Scaffold(
      backgroundColor: isDark ? premiumScreenBgDark : premiumScreenBgLight,
      body: Stack(
        children: [
          // ── Gradient header background ──
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.28,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: FigmaColors.primaryGradient(context),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -80,
                    top: -100,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: -60,
                    bottom: -80,
                    child: Container(
                      width: 200,
                      height: 200,
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

          // ── Foreground ──
          SafeArea(
            child: Column(
              children: [
                // App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      _glassButton(
                        icon: Icons.arrow_back,
                        onTap: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${'addon'.tr} ',
                            style: AppFont.font(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'plans_title'.tr,
                            style: AppFont.font(
                              color: Colors.white,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const SizedBox(width: 44),
                    ],
                  ),
                ),

                // Sub-header badge
                const Gap(4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.extension_rounded,
                        color: premiumYellowLight,
                        size: 14,
                      ),
                      const Gap(6),
                      Text(
                        'extend_your_plan_caps'.tr,
                        style: AppFont.font(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.55,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                Text(
                  'select_one_addon_sub'.tr,
                  textAlign: TextAlign.center,
                  style: AppFont.font(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(16),

                // List
                Expanded(
                  child: addonAsync.when(
                    data: (list) => list.isEmpty
                        ? Center(
                            child: Text(
                              'no_addon_plans_found'.tr,
                              style: AppFont.font(
                                color: isDark
                                    ? Colors.white54
                                    : Colors.grey.shade600,
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                            physics: const BouncingScrollPhysics(),
                            itemCount: list.length,
                            separatorBuilder: (context, index) => const Gap(12),
                            itemBuilder: (context, i) =>
                                _addonCard(context, list[i], isDark, membershipState),
                          ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(
                      child: Text(
                        'error_loading_addons'.tr,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ── Sticky bottom button ──
      bottomNavigationBar: _buildStickyBuyButton(isDark, membershipState),
    );
  }

  // ── Addon Card ─────────────────────────────────────────────────────────────

  Widget _addonCard(
    BuildContext context,
    AddOnPlan addon,
    bool isDark,
    MembershipState membershipState,
  ) {
    final isSelected = _selectedAddonId == addon.id;
    final amount = addon.packageAmount?.toString() ?? '0';
    final currencySymbol = _getAddonCurrencySymbol(addon, membershipState);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAddonId = addon.id;
          _selectedAddon = addon;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1F2E) : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : (isDark ? Colors.white12 : Colors.grey.shade200),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.18)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: isSelected ? 20 : 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? FigmaColors.primaryGradient(context)
                      : null,
                  color: isSelected
                      ? null
                      : Theme.of(context).primaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _iconForCategory(addon.packageCategory ?? ''),
                  color: isSelected ? Colors.white : Theme.of(context).primaryColor,
                  size: 24,
                ),
              ),
              const Gap(14),
              // Title + Category
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addon.packageTitle ?? '',
                      style: AppFont.font(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF1E1E2F),
                      ),
                    ),
                    const Gap(4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.08)
                                : const Color(0xFFF1F3F9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            addon.packageCategory ?? '',
                            style: AppFont.font(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.white70
                                  : const Color(0xFF4A5568),
                            ),
                          ),
                        ),
                        const Gap(6),
                        Text(
                          '+${addon.packageCount?.toString() ?? '0'}',
                          style: AppFont.font(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? Colors.white60
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    if ((addon.description ?? '').isNotEmpty) ...[
                      const Gap(6),
                      Text(
                        addon.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppFont.font(
                          fontSize: 11,
                          color: isDark ? Colors.white38 : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Gap(12),
              // Price + Radio
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$currencySymbol$amount',
                    style: AppFont.font(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF1E1E2F),
                    ),
                  ),
                  const Gap(6),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade400,
                        width: isSelected ? 0 : 2,
                      ),
                      gradient: isSelected
                          ? FigmaColors.primaryGradient(context)
                          : null,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 13)
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Sticky Buy Button ──────────────────────────────────────────────────────

  Widget _buildStickyBuyButton(bool isDark, MembershipState membershipState) {
    final hasSelection = _selectedAddon != null;
    final currencySymbol = _getAddonCurrencySymbol(_selectedAddon, membershipState);
    final amount = hasSelection
        ? '$currencySymbol${_selectedAddon!.packageAmount?.toString() ?? '0'}'
        : '';

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF13141F) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: GestureDetector(
        onTap: hasSelection ? () => _handleBuyTapped(membershipState) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            gradient: hasSelection
                ? FigmaColors.primaryGradient(context)
                : null,
            color: hasSelection
                ? null
                : (isDark ? Colors.white12 : Colors.grey.shade200),
            borderRadius: BorderRadius.circular(28),
            boxShadow: hasSelection
                ? [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              const Gap(16),
              Icon(
                Icons.verified_user_rounded,
                color: hasSelection ? Colors.white : Colors.grey,
                size: 20,
              ),
              const Gap(10),
              Text(
                hasSelection ? 'buy_addon_plan'.tr : 'select_addon_to_buy'.tr,
                style: AppFont.font(
                  color: hasSelection ? Colors.white : Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (hasSelection)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        amount,
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
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  Widget _glassButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  IconData _iconForCategory(String category) {
    final cat = category.toLowerCase();
    if (cat.contains('validity') || cat.contains('duration')) {
      return Icons.timer_outlined;
    } else if (cat.contains('contact')) {
      return Icons.contacts_outlined;
    } else if (cat.contains('connect') || cat.contains('interest')) {
      return Icons.people_outline;
    } else if (cat.contains('video')) {
      return Icons.videocam_outlined;
    } else if (cat.contains('audio') || cat.contains('call')) {
      return Icons.call_outlined;
    }
    return Icons.extension_outlined;
  }
}
