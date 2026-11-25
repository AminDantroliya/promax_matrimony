import 'package:flutter/material.dart';
import '../payment_gateway_service.dart';
import '../payment_models.dart';
import '../screens/stripe_checkout_screen.dart';

class StripeGatewayService implements PaymentGatewayService {
  @override
  String get gatewayName => 'stripe';

  @override
  String get displayName => 'Stripe';

  @override
  Future<void> processPayment({
    required BuildContext context,
    required PaymentRequest request,
    required Function(PaymentSuccessResult result) onSuccess,
    required Function(String error) onError,
    required VoidCallback onCancel,
  }) async {
    final publishableKey = request.clientId;
    final secretKey = request.clientSecret;

    if (secretKey.isEmpty) {
      onError('Stripe Secret Key not provided from backend');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StripeCheckoutScreen(
          amount: request.amount,
          currency: request.currency,
          secretKey: secretKey,
          publishableKey: publishableKey,
          planName: request.planName,
          customerEmail: request.customerEmail,
          customerId: request.customerId,
          onSuccess: (sessionId) {
            onSuccess(
              PaymentSuccessResult(
                transactionId: sessionId,
                gatewayName: gatewayName,
                metadata: {'session_id': sessionId},
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
