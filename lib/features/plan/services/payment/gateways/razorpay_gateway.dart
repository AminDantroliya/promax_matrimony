import 'package:flutter/material.dart';
import '../payment_gateway_service.dart';
import '../payment_models.dart';
import '../screens/razorpay_checkout_screen.dart';

class RazorpayGatewayService implements PaymentGatewayService {
  @override
  String get gatewayName => 'razorpay';

  @override
  String get displayName => 'Razorpay';

  @override
  Future<void> processPayment({
    required BuildContext context,
    required PaymentRequest request,
    required Function(PaymentSuccessResult result) onSuccess,
    required Function(String error) onError,
    required VoidCallback onCancel,
  }) async {
    final keyId = request.clientId;
    if (keyId.isEmpty) {
      onError('Razorpay Key ID not provided from backend');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RazorpayCheckoutScreen(
          amount: request.amount,
          currency: request.currency,
          keyId: keyId,
          planName: request.planName,
          userName: request.customerName,
          userEmail: request.customerEmail,
          userPhone: request.customerPhone,
          onSuccess: (paymentId) {
            onSuccess(
              PaymentSuccessResult(
                transactionId: paymentId,
                gatewayName: gatewayName,
                metadata: {'payment_id': paymentId},
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
