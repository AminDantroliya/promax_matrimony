  import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_no_records_widget.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shimmer/shimmer.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/profile/providers/profile_notifier.dart';
import 'dart:async';

import '../data/models/plan_models.dart';
import '../providers/membership_notifier.dart';
import '../providers/plan_notifier.dart';
import '../data/repositories/plan_repository.dart';
import 'make_payment_screen.dart';
import 'dart:convert';
import 'package:pro_matrimony/features/profile/data/models/profile_models.dart';
import 'package:pro_matrimony/services/app_session_service.dart';


class PlansScreen extends ConsumerStatefulWidget {
  const PlansScreen({super.key});

  @override
  ConsumerState<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends ConsumerState<PlansScreen> {
  int _currentIndex = 0;
  int _selectedPlanTab = 0; // 0: Matrimonial Plan (is_personalized: 0), 1: Personalize Plan (is_personalized: 1)
  late final PageController _pageController;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  List<MembershipPlan> _getFilteredPlans(dynamic state) {
    final rawList = state.planList?.data?.membershipPlanArr;
    final List<MembershipPlan> allPlans = rawList != null
        ? List<MembershipPlan>.from(rawList)
        : <MembershipPlan>[];
    return allPlans.where((plan) {
      final isPersonalized =
          plan.isPersonalized == 1 || plan.isPersonalized?.toString() == '1';
      return _selectedPlanTab == 1 ? isPersonalized : !isPersonalized;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.88);

    // In-App Purchase setup
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription?.cancel();
      },
      onError: (error) {
        showToast("Purchase stream error: $error");
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(membershipProvider.notifier).fetchPlans();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  void _listenToPurchaseUpdated(
    List<PurchaseDetails> purchaseDetailsList,
  ) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showLoading(context);
      } else {
        hideLoading();

        if (purchaseDetails.status == PurchaseStatus.error) {
          showToast(purchaseDetails.error?.message ?? "Purchase failed");
        } else if (purchaseDetails.status == PurchaseStatus.canceled) {
          // Purchase canceled by user
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          showLoading(context);
          await _assignPlan(purchaseDetails);
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> _assignPlan(PurchaseDetails purchaseDetails) async {
    final transactionId = purchaseDetails.purchaseID ??
        purchaseDetails.transactionDate ??
        DateTime.now().millisecondsSinceEpoch.toString();
    final productId = purchaseDetails.productID;

    final state = ref.read(membershipProvider);
    final plans = state.planList?.data?.membershipPlanArr ?? [];
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    final plan = plans.firstWhere((p) {
      final pId = isIOS ? p.inAppPurchaseIosId : p.inAppPurchaseAndroidId;
      return pId == productId;
    }, orElse: () => const MembershipPlan());

    if (plan.id == null) {
      hideLoading();
      showToast("Purchased product ID ($productId) doesn't match any configured plan.");
      return;
    }

    var myProfile = ref.read(myProfileProvider).value;
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
      showToast("User profile not found. Please log in again.");
      return;
    }

    try {
      final params = {
        "plan_id": plan.id.toString(),
        "member_id": myProfile.id.toString(),
        "coupon_code": "",
        "package_ids": "",
        "transaction_id": transactionId,
        "product_id": productId,
        "platform": isIOS ? "ios" : "android",
        "purchase_token":
            purchaseDetails.verificationData.serverVerificationData,
        "local_verification_data":
            purchaseDetails.verificationData.localVerificationData,
        "verification_source": purchaseDetails.verificationData.source,
        "purchase_type": "one_time",
        "purchase_status": purchaseDetails.status.name,
      };

      final result = await ref
          .read(planRepositoryProvider)
          .assignPlanNew(params);
      hideLoading();

      if (result['status'] == "success") {
        final successMsg = purchaseDetails.status == PurchaseStatus.restored
            ? "Your plan has been restored successfully."
            : "Your plan purchase was successful. Enjoy our matrimonial services.";
        showToast(successMsg);
        ref.invalidate(currentPlanProvider);
        ref.invalidate(myProfileProvider);
        if (mounted) {
          context.go('/current-plan', extra: true);
        }
      } else {
        showToast(result['message'] ?? "Failed to verify and assign plan");
      }
    } catch (e) {
      hideLoading();
      showToast("Error processing payment response: $e");
    }
  }

  Future<void> _buyInAppPlan(MembershipPlan plan) async {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final productId = isIOS
        ? plan.inAppPurchaseIosId
        : plan.inAppPurchaseAndroidId;

    if (productId == null || productId.isEmpty) {
      showToast("In-app purchase product ID not configured for this plan.");
      return;
    }

    showLoading(context);

    try {
      final bool isAvailable = await InAppPurchase.instance.isAvailable();
      if (!isAvailable) {
        hideLoading();
        showToast("In-app purchase store is not available.");
        return;
      }

      final ProductDetailsResponse response = await InAppPurchase.instance
          .queryProductDetails({productId});

      if (response.error != null) {
        hideLoading();
        showToast("Error loading product details: ${response.error!.message}");
        return;
      }

      if (response.productDetails.isEmpty) {
        hideLoading();
        showToast("Product $productId not found in store.");
        return;
      }

      final ProductDetails productDetails = response.productDetails.first;
      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: productDetails,
      );

      hideLoading();

      await InAppPurchase.instance.buyNonConsumable(
        purchaseParam: purchaseParam,
      );
    } catch (e) {
      hideLoading();
      showToast("Error initiating purchase: $e");
    }
  }

  Future<void> _restorePurchase() async {
    showLoading(context);
    try {
      final bool isAvailable = await InAppPurchase.instance.isAvailable();
      if (!isAvailable) {
        hideLoading();
        showToast("In-app purchase store is not available.");
        return;
      }

      await InAppPurchase.instance.restorePurchases();
      hideLoading();
      showToast("Purchase restoration request sent.");
    } catch (e) {
      hideLoading();
      showToast("Error restoring purchases: $e");
    }
  }

  bool _shouldUseInAppPurchase(BuildContext context, dynamic state) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) return true;

    final isAndroid = Theme.of(context).platform == TargetPlatform.android;
    if (isAndroid) {
      final paymentMethods = state.planList?.data?.paymentMethods;
      final isInAppActive =
          paymentMethods?.inAppPayment?.toLowerCase() == "active";

      if (isInAppActive) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(myProfileProvider);
    final state = ref.watch(membershipProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? premiumScreenBgDark : premiumScreenBgLight,
      body: Stack(
        children: [
          // Curved gradient background at the top with circular overlays
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.52,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: FigmaColors.primaryGradient(context),
              ),
              child: Stack(
                children: [
                  // Top Right Overlay
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
                  // Bottom Left Overlay
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

          // Foreground content
          SafeArea(
            child: Column(
              children: [
                // Custom transparent app bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button (Glassmorphic Rounded Square)
                      _buildGlassButton(
                        context,
                        icon: Icons.arrow_back,
                        onPressed: () => Navigator.pop(context),
                      ),
                      // Title in serif style (Fraunces)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${'premium_lbl'.tr} ',
                            style: AppFont.font(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              height: 1.25,
                            ),
                          ),
                          Text(
                            'plans_title'.tr,
                            style: AppFont.font(
                              color: Colors.white,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              height: 1.25,
                            ),
                          ),
                        ],
                      ),
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? _buildGlassButton(
                              context,
                              icon: Icons.restore_rounded,
                              onPressed: _restorePurchase,
                            )
                          : const SizedBox(width: 44),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    children: [
                      const Gap(10),

                      // TabBar for Matrimonial Plan & Personalize Plan
                      _buildPlanTabBar(isDark),
                      const Gap(12),

                      // PageView of plans
                      Expanded(
                        child: _buildPlansCarousel(state, isDark),
                      ),

                      const Gap(12),
                      // Dots Indicator with figma spec
                      _buildDotsIndicator(state),
                      const Gap(12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
  );
}

  Widget _buildPlanTabBar(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.18),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_selectedPlanTab != 0) {
                  setState(() {
                    _selectedPlanTab = 0;
                    _currentIndex = 0;
                  });
                  if (_pageController.hasClients) {
                    _pageController.jumpToPage(0);
                  }
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  color: _selectedPlanTab == 0
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: _selectedPlanTab == 0
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    'matrimonial_plan'.tr,
                    style: AppFont.font(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _selectedPlanTab == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_selectedPlanTab != 1) {
                  setState(() {
                    _selectedPlanTab = 1;
                    _currentIndex = 0;
                  });
                  if (_pageController.hasClients) {
                    _pageController.jumpToPage(0);
                  }
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  color: _selectedPlanTab == 1
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: _selectedPlanTab == 1
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    'personalized_plan'.tr,
                    style: AppFont.font(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _selectedPlanTab == 1
                          ? Theme.of(context).primaryColor
                          : Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
    bool showBadge = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            if (showBadge)
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: premiumYellowLight,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlansCarousel(dynamic state, bool isDark) {
    if (state.isLoading) {
      return PageView.builder(
        controller: _pageController,
        itemCount: 3,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return _buildShimmerPlanCard(context, isDark);
        },
      );
    }

    final plans = _getFilteredPlans(state);
    if (plans.isEmpty) {
      return const Center(child: AppNoRecordsWidget());
    }

    return PageView.builder(
      controller: _pageController,
      itemCount: plans.length,
      clipBehavior: Clip.none,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final plan = plans[index];
        return _buildPlanCard(context, plan, state, isDark, index);
      },
    );
  }

  String _getAiInterestDisplay(MembershipPlan plan) {
    final aiInt = plan.aiInterest;
    if (aiInt == 1 ||
        aiInt?.toString() == '1' ||
        aiInt?.toString().toLowerCase() == 'yes' ||
        aiInt == true) {
      return 'yes'.tr;
    }
    return 'no'.tr;
  }

  Widget _buildPlanCard(
    BuildContext context,
    MembershipPlan plan,
    dynamic state,
    bool isDark,
    int index,
  ) {
    final cardColor = Theme.of(context).colorScheme.surface;
    final textColor = isDark ? Colors.white : premiumDarkText;
    final subtitleColor = isDark ? Colors.white60 : premiumSubtitle;
    final useInApp = _shouldUseInAppPurchase(context, state);

    final validity = plan.validityDays?.toString() ?? plan.planValidity ?? "30";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: premiumShadowColor.withValues(alpha: isDark ? 0.25 : 0.12),
            blurRadius: 50,
            spreadRadius: 0,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Main card elements
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row
                Row(
                  children: [
                    // Left Icon with shadow
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: FigmaColors.primaryGradient(context),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.figmaPremium,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          width: 24,
                          height: 24,
                          placeholderBuilder: (_) => const Icon(
                            Icons.workspace_premium_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    const Gap(14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.planName ?? "N/A",
                            style: AppFont.font(
                              color: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            'valid_for_days'.trParams({'days': validity}),
                            style: AppFont.font(
                              color: subtitleColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Right side popular tag space
                    const Gap(85),
                  ],
                ),
                const Gap(14),

                // Pricing Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      _getAmountDisplay(plan, useInApp),
                      style: AppFont.font(
                        color: isDark ? Colors.white : premiumDarkText,
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      '/ $validity ${'days_lbl'.tr}',
                      style: AppFont.font(
                        color: subtitleColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.25,
                      ),
                    ),
                    const Spacer(),
                    if (_hasStrikethrough(plan, useInApp))
                      Text(
                        _getOriginalPriceDisplay(plan, useInApp),
                        style: AppFont.font(
                          color: premiumOriginalPrice,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w400,
                          height: 1.25,
                        ),
                      ),
                  ],
                ),
                const Gap(14),

                // Scrollable Features & Description list
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFeatureRow(
                          context,
                          'allowed_connect'.tr,
                          _getConnectsDisplay(plan),
                          isDark,
                        ),
                        _buildFeatureRow(
                          context,
                          'allowed_view_profiles'.tr,
                          _getViewProfileDisplay(plan),
                          isDark,
                        ),
                        _buildFeatureRow(
                          context,
                          'allowed_contact'.tr,
                          _getContactsDisplay(plan),
                          isDark,
                        ),
                        _buildFeatureRow(
                          context,
                          'live_chat'.tr,
                          _getChatDisplay(plan),
                          isDark,
                        ),
                        if (ref.watch(featureProvider('enableVideoCall')))
                          _buildFeatureRow(
                            context,
                            'video_call'.tr,
                            _getVideoMinutesDisplay(plan),
                            isDark,
                          ),
                        if (ref.watch(featureProvider('enableVoiceCall')))
                          _buildFeatureRow(
                            context,
                            'voice_call'.tr,
                            _getVoiceMinutesDisplay(plan),
                            isDark,
                          ),
                        if (ref.watch(featureProvider('enableAiMatchmaking')))
                          _buildFeatureRow(
                            context,
                            'allowed_auto_ai_interest'.tr,
                            _getAiInterestDisplay(plan),
                            isDark,
                          ),
                        if (plan.planDescription != null &&
                            plan.planDescription!.trim().isNotEmpty) ...[
                          const Gap(10),
                          Divider(
                            height: 1,
                            color: isDark
                                ? Colors.white12
                                : Colors.grey.shade200,
                          ),
                          const Gap(10),
                          Text(
                            'plan_description_lbl'.tr,
                            style: AppFont.font(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            plan.planDescription!,
                            style: AppFont.font(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: subtitleColor,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const Gap(12),

                // Select button with dynamic shadows
                GestureDetector(
                  onTap: () {
                    if (useInApp) {
                      _buyInAppPlan(plan);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MakePaymentScreen(
                            plan: plan,
                            addons: state.planList?.data?.addOnPlanArr,
                            offlinePayment:
                                state.planList?.data?.offlinePayment,
                            paymentMethods:
                                state.planList?.data?.paymentMethods,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: FigmaColors.primaryGradient(context),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                          blurRadius: 34,
                          offset: const Offset(0, 18),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'select_plan'.tr,
                            style: AppFont.font(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              height: 1.13,
                            ),
                          ),
                          const Gap(10),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Personalize tag positioned in the top right corner
          if (plan.isPersonalized == true)
            Positioned(
              right: 14,
              top: 14,
              child: Container(
                height: 26,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [premiumYellowLight, premiumYellowDark],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.white,
                      size: 12,
                    ),
                    const Gap(3),
                    Text(
                      "personalize_caps".tr,
                      style: AppFont.font(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(
    BuildContext context,
    String label,
    String value,
    bool isDark,
  ) {
    final labelColor = isDark ? Colors.white70 : premiumDarkText;

    final valClean = value.trim().toLowerCase();
    final isNoOrZero = valClean == "no" ||
        valClean == "false" ||
        valClean == "0" ||
        valClean == "0 / 0" ||
        valClean.startsWith("0 ");

    final bool isEnabled = !isNoOrZero;

    final IconData iconData =
        isEnabled ? Icons.check_rounded : Icons.close_rounded;

    final List<Color> iconGradientColors = isEnabled
        ? const [Color(0xFF4CAF50), Color(0xFF2E7D32)]
        : const [Color(0xFFB0B6C8), Color(0xFF8D94AB)];

    final Color regularValueColor = isEnabled
        ? (isDark ? Colors.white : premiumDarkText)
        : (isDark ? Colors.white38 : Colors.grey.shade500);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 44,
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: iconGradientColors,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(iconData, color: Colors.white, size: 14),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Text(
              label,
              style: AppFont.font(
                color: labelColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
          ),
          Text(
            value,
            style: AppFont.font(
              color: regularValueColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDotsIndicator(dynamic state) {
    final plans = _getFilteredPlans(state);
    if (plans.isEmpty) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(plans.length, (index) {
        final isSelected = index == _currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: isSelected ? 28 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            gradient: isSelected
                ? FigmaColors.primaryGradient(context)
                : null,
            color: isSelected ? null : Theme.of(context).primaryColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }

  String _getCurrencySymbol(String? currencyCode) {
    if (currencyCode == null) return "₹";
    final code = currencyCode.toUpperCase();
    if (code == "INR") return "₹";
    if (code == "USD") return "\$";
    if (code == "EUR") return "€";
    if (code == "GBP") return "£";
    return currencyCode;
  }

  String _getAmountDisplay(MembershipPlan plan, bool useInApp) {
    if (useInApp) {
      final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
      final amt = isIOS
          ? plan.inAppPurchaseIosAmount?.toString()
          : plan.inAppPurchaseAndroidAmount?.toString();
      if (amt == null ||
          amt == "0" ||
          amt.toLowerCase() == "free" ||
          amt.isEmpty) {
        return "free".tr;
      }
      final symbol = _getCurrencySymbol(plan.currencyCode ?? plan.planCurrency);
      return "$symbol$amt";
    }

    final amt = plan.planAmount?.toString() ?? "";
    if (amt == "0" || amt.toLowerCase() == "free" || amt.isEmpty) {
      return "free".tr;
    }
    final symbol = _getCurrencySymbol(plan.currencyCode ?? plan.planCurrency);
    return "$symbol$amt";
  }

  bool _hasStrikethrough(MembershipPlan plan, bool useInApp) {
    if (useInApp) return false;

    final amt = plan.planAmount?.toString() ?? "";
    if (amt == "0" || amt.toLowerCase() == "free" || amt.isEmpty) {
      return true;
    }

    if (plan.planDiscount != null) {
      try {
        final disc = double.parse(plan.planDiscount.toString());
        return disc > 0;
      } catch (_) {}
    }
    return false;
  }

  String _getOriginalPriceDisplay(MembershipPlan plan, bool useInApp) {
    if (useInApp) return "";

    final amt = plan.planAmount?.toString() ?? "";
    if (amt == "0" || amt.toLowerCase() == "free" || amt.isEmpty) {
      final symbol = _getCurrencySymbol(plan.currencyCode ?? plan.planCurrency);
      return "${symbol}1,499";
    }

    if (plan.planDiscount != null) {
      try {
        final amountVal = double.parse(plan.planAmount.toString());
        final discVal = double.parse(plan.planDiscount.toString());
        if (discVal > 0) {
          final original = amountVal + discVal;
          final symbol = _getCurrencySymbol(
            plan.currencyCode ?? plan.planCurrency,
          );
          if (original == original.toInt()) {
            return "$symbol${original.toInt()}";
          }
          return "$symbol${original.toStringAsFixed(2)}";
        }
      } catch (_) {}
    }
    return "";
  }

  String _getContactsDisplay(MembershipPlan plan) {
    if (plan.contactViewsLimit != null) {
      return plan.contactViewsLimit.toString();
    }
    return plan.planViewContact ?? "0";
  }

  String _getViewProfileDisplay(MembershipPlan plan) {
    if (plan.viewProfileLimit != null) {
      return plan.viewProfileLimit.toString();
    }
    if (plan.planViewProfile != null) {
      return plan.planViewProfile.toString();
    }
    return "0";
  }

  String _getConnectsDisplay(MembershipPlan plan) {
    if (plan.interestsLimit != null) {
      return plan.interestsLimit.toString();
    }
    return plan.planInterest ?? "0";
  }

  String _getChatDisplay(MembershipPlan plan) {
    if (plan.canChat != null) {
      final v = plan.canChat;
      final isYes = v == true || v == 1 || v.toString() == "1" || v.toString().toLowerCase() == "true";
      return isYes ? "Yes" : "No";
    }
    final chatVal = plan.chat ?? "No";
    if (chatVal.toLowerCase() == "yes" || chatVal.toLowerCase() == "true" || chatVal == "1") {
      return "Yes";
    }
    return "No";
  }

  String _getVideoMinutesDisplay(MembershipPlan plan) {
    if (plan.videoMinutesLimit != null) {
      final limit = plan.videoMinutesLimit!;
      if (limit == 0) return "No";
      return "$limit min";
    }
    return _getVideoCallMinutes(plan.planVideocallMinute);
  }

  String _getVoiceMinutesDisplay(MembershipPlan plan) {
    if (plan.audioMinutesLimit != null) {
      final limit = plan.audioMinutesLimit!;
      if (limit == 0) return "No";
      return "$limit min";
    }
    final minutes = plan.planAudiocallMinute;
    if (minutes == null || minutes.isEmpty || minutes == "0") {
      return "No";
    }
    if (minutes.toLowerCase().contains("min") ||
        minutes.toLowerCase().contains("unlimited")) {
      return minutes;
    }
    return "$minutes min";
  }

  String _getVideoCallMinutes(String? minutes) {
    if (minutes == null || minutes.isEmpty || minutes == "0") {
      return "No";
    }
    if (minutes.toLowerCase().contains("min") ||
        minutes.toLowerCase().contains("unlimited")) {
      return minutes;
    }
    return "$minutes min";
  }

  Widget _buildShimmerPlanCard(BuildContext context, bool isDark) {
    final shimmerBase = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final shimmerHighlight = isDark ? Colors.grey[700]! : Colors.grey[100]!;
    final cardColor = Theme.of(context).colorScheme.surface;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: premiumShadowColor.withValues(alpha: isDark ? 0.25 : 0.12),
            blurRadius: 50,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: shimmerBase,
        highlightColor: shimmerHighlight,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header Row
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  const Gap(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Gap(6),
                        Container(
                          width: 80,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(18),

              // Pricing Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Container(
                    width: 120,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const Gap(18),

              // Features list placeholders
              for (int i = 0; i < 5; i++) ...[
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ],

              const Gap(20),

              // Select button placeholder
              Container(
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
