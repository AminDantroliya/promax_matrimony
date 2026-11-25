import 'package:flutter/material.dart';
import 'package:pro_matrimony/core/config/env_config.dart';
import 'package:pro_matrimony/features/plan/screens/paypal_checkout_screen.dart';
import '../payment_gateway_service.dart';
import '../payment_models.dart';

class PaypalGatewayService implements PaymentGatewayService {
  @override
  String get gatewayName => 'paypal';

  @override
  String get displayName => 'PayPal';

  @override
  Future<void> processPayment({
    required BuildContext context,
    required PaymentRequest request,
    required Function(PaymentSuccessResult result) onSuccess,
    required Function(String error) onError,
    required VoidCallback onCancel,
  }) async {
    final effectiveClientId = request.clientId.isNotEmpty
        ? request.clientId
        : EnvConfig.paypalClientId;
    final effectiveClientSecret = request.clientSecret.isNotEmpty
        ? request.clientSecret
        : EnvConfig.paypalClientSecret;

    if (effectiveClientId.isEmpty) {
      onError('PayPal Client ID not provided from backend');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaypalCheckoutScreen(
          amount: request.amount,
          currency: request.currency,
          clientId: effectiveClientId,
          clientSecret: effectiveClientSecret,
          onSuccess: (transactionId) {
            onSuccess(
              PaymentSuccessResult(
                transactionId: transactionId,
                gatewayName: gatewayName,
                metadata: {'order_id': transactionId},
              ),
            );
          },
          onCancel: onCancel,
          onError: onError,
        ),
      ),
    );
  }
}
