import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/plan_models.dart';
import '../data/repositories/plan_repository.dart';

part 'payment_notifier.freezed.dart';
part 'payment_notifier.g.dart';

@freezed
abstract class PaymentState with _$PaymentState {
  const factory PaymentState({
    @Default(false) bool isLoading,
    MembershipPlan? selectedPlan,
    @Default([]) List<CouponData> coupons,
    @Default({}) Set<int> selectedAddonIds,
    @Default([]) List<AddOnPlan> addOnPlans,
    @Default(-1) int selectedCouponIndex,
    @Default("") String appliedCouponCode,
    @Default(0.0) double baseAmount,
    @Default(0.0) double discountAmount,
    @Default(0.0) double addonAmount,
    @Default(0.0) double couponAmount,
    @Default(0.0) double taxAmount,
    @Default(0.0) double finalAmount,
    @Default("No") String taxApplicable,
    @Default("Tax") String taxName,
    @Default(0) int serviceTax,
    OfflinePayment? offlinePayment,
    PaymentMethods? paymentMethods,
  }) = _PaymentState;
}

@riverpod
class PaymentNotifier extends _$PaymentNotifier {
  @override
  PaymentState build() {
    return const PaymentState();
  }

  void initialize(
    MembershipPlan plan,
    List<AddOnPlan>? addons,
    OfflinePayment? offline, [
    PaymentMethods? paymentMethods,
  ]) async {
    state = state.copyWith(
      selectedPlan: plan,
      addOnPlans: addons ?? [],
      offlinePayment: offline,
      paymentMethods: paymentMethods,
      baseAmount: double.tryParse(plan.planAmount?.toString() ?? "0") ?? 0.0,
      isLoading: true,
    );

    // Fetch Checkout API details
    try {
      final checkoutRes = await ref.read(planRepositoryProvider).getPlanCheckout({
        'plan_id': plan.id,
      });
      if (checkoutRes.code == 200 && checkoutRes.data != null) {
        state = state.copyWith(
          selectedPlan: checkoutRes.data?.plan ?? state.selectedPlan,
          addOnPlans: checkoutRes.data?.addOnPackages ?? state.addOnPlans,
          baseAmount: double.tryParse(checkoutRes.data?.plan?.planAmount?.toString() ?? "0") ?? state.baseAmount,
        );
      }
    } catch (_) {}

    await calculateTotal();
    state = state.copyWith(isLoading: false);
  }

  void toggleAddon(AddOnPlan addon) {
    final newIds = Set<int>.from(state.selectedAddonIds);
    if (newIds.contains(addon.id)) {
      newIds.remove(addon.id);
    } else {
      newIds.add(addon.id!);
    }
    state = state.copyWith(selectedAddonIds: newIds);
    calculateTotal();
  }

  void selectCoupon(int index) {
    if (index >= 0 && index < state.coupons.length) {
      applyCoupon(state.coupons[index].coupanCode ?? "");
    } else {
      removeCoupon();
    }
  }

  Future<bool> applyCoupon(String code) async {
    final planId = state.selectedPlan?.id?.toString() ?? "";
    final packageIds = state.selectedAddonIds.join(",");

    try {
      final res = await ref.read(planRepositoryProvider).calculatePlanPrice({
        'plan_id': planId,
        'package_ids': packageIds,
        'coupon_code': code,
      });

      if (res.code == 200 && res.data != null) {
        final d = res.data!;
        if (d.couponApplied == true) {
          state = state.copyWith(
            appliedCouponCode: code,
            baseAmount: double.tryParse(d.planAmount?.toString() ?? "0") ?? state.baseAmount,
            discountAmount: double.tryParse(d.planDiscount?.toString() ?? "0") ?? 0.0,
            addonAmount: double.tryParse(d.addonTotal?.toString() ?? "0") ?? 0.0,
            couponAmount: double.tryParse(d.couponDiscount?.toString() ?? "0") ?? 0.0,
            taxAmount: double.tryParse(d.taxAmount?.toString() ?? "0") ?? 0.0,
            finalAmount: double.tryParse(d.grandTotal?.toString() ?? "0") ?? 0.0,
            taxApplicable: d.taxApplicable ?? state.taxApplicable,
            taxName: d.taxName ?? state.taxName,
            serviceTax: int.tryParse(d.taxPercentage?.toString() ?? "0") ?? state.serviceTax,
          );
          return true;
        }
      }
    } catch (_) {}
    return false;
  }

  Future<void> removeCoupon() async {
    state = state.copyWith(appliedCouponCode: "");
    await calculateTotal();
  }

  Future<void> calculateTotal() async {
    final planId = state.selectedPlan?.id?.toString() ?? "";
    final packageIds = state.selectedAddonIds.join(",");
    final coupon = state.appliedCouponCode;

    try {
      final res = await ref.read(planRepositoryProvider).calculatePlanPrice({
        'plan_id': planId,
        'package_ids': packageIds,
        'coupon_code': coupon,
      });

      if (res.code == 200 && res.data != null) {
        final d = res.data!;
        state = state.copyWith(
          baseAmount: double.tryParse(d.planAmount?.toString() ?? "0") ?? state.baseAmount,
          discountAmount: double.tryParse(d.planDiscount?.toString() ?? "0") ?? 0.0,
          addonAmount: double.tryParse(d.addonTotal?.toString() ?? "0") ?? 0.0,
          couponAmount: double.tryParse(d.couponDiscount?.toString() ?? "0") ?? 0.0,
          taxAmount: double.tryParse(d.taxAmount?.toString() ?? "0") ?? 0.0,
          finalAmount: double.tryParse(d.grandTotal?.toString() ?? "0") ?? 0.0,
          taxApplicable: d.taxApplicable ?? state.taxApplicable,
          taxName: d.taxName ?? state.taxName,
          serviceTax: int.tryParse(d.taxPercentage?.toString() ?? "0") ?? state.serviceTax,
        );
        return;
      }
    } catch (_) {}

    _calculateTotalLocal();
  }

  void _calculateTotalLocal() {
    double base = state.baseAmount;
    double discPerc =
        double.tryParse(state.selectedPlan?.planDiscount?.toString() ?? "0") ??
        0.0;
    double disc = base * discPerc / 100;

    double afterDisc = base - disc;

    double addons = 0.0;
    for (var id in state.selectedAddonIds) {
      final addon = state.addOnPlans.firstWhere((element) => element.id == id);
      addons += double.tryParse(addon.packageAmount?.toString() ?? "0") ?? 0.0;
    }

    double couponAmt = 0.0;

    double subTotal = (afterDisc - couponAmt) + addons;
    double tax = 0.0;
    if (state.taxApplicable == "Yes") {
      tax = subTotal * state.serviceTax / 100;
    }

    state = state.copyWith(
      discountAmount: disc,
      addonAmount: addons,
      couponAmount: couponAmt,
      taxAmount: tax,
      finalAmount: subTotal + tax,
    );
  }
}
