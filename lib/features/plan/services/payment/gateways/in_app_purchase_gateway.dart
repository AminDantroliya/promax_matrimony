import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../payment_gateway_service.dart';
import '../payment_models.dart';

class InAppPurchaseGatewayService implements PaymentGatewayService {
  @override
  String get gatewayName => 'inapppurchase';

  @override
  String get displayName => 'In-App Purchase';

  @override
  Future<void> processPayment({
    required BuildContext context,
    required PaymentRequest request,
    required Function(PaymentSuccessResult result) onSuccess,
    required Function(String error) onError,
    required VoidCallback onCancel,
  }) async {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    final bool isAvailable = await InAppPurchase.instance.isAvailable();
    if (!isAvailable) {
      onError('In-app purchase store is currently not available.');
      return;
    }
    final productId = isIOS
        ? (request.planId.isNotEmpty ? request.planId : '')
        : (request.planId.isNotEmpty ? request.planId : '');

    if (productId.isEmpty) {
      onError('In-app purchase product ID not configured.');
      return;
    }

    try {
      final ProductDetailsResponse response =
          await InAppPurchase.instance.queryProductDetails({productId});

      if (response.error != null) {
        onError('Store error: ${response.error!.message}');
        return;
      }

      if (response.productDetails.isEmpty) {
        onError('Product ($productId) not found in store.');
        return;
      }

      final ProductDetails productDetails = response.productDetails.first;
      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: productDetails,
      );

      // One-time purchase plan using buyNonConsumable
      await InAppPurchase.instance.buyNonConsumable(
        purchaseParam: purchaseParam,
      );
    } catch (e) {
      onError('In-app purchase initiation failed: $e');
    }
  }
}
