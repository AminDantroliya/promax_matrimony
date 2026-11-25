import 'package:flutter/material.dart';
import '../payment_gateway_service.dart';
import '../payment_models.dart';
import '../screens/cashfree_checkout_screen.dart';

class CashfreeGatewayService implements PaymentGatewayService {
  @override
  String get gatewayName => 'cashfree';

  @override
  String get displayName => 'Cashfree';

  @override
  Future<void> processPayment({
    required BuildContext context,
    required PaymentRequest request,
    required Function(PaymentSuccessResult result) onSuccess,
    required Function(String error) onError,
    required VoidCallback onCancel,
  }) async {
    final appId = request.clientId;
    final secretKey = request.clientSecret;

    if (appId.isEmpty) {
      onError('Cashfree App ID not provided from backend');
      return;
    }
    if (secretKey.isEmpty) {
      onError('Cashfree Secret Key not provided from backend');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CashfreeCheckoutScreen(
          amount: request.amount,
          currency: request.currency,
          appId: appId,
          secretKey: secretKey,
          isTestMode: request.isTestMode,
          planName: request.planName,
          customerId: request.customerId,
          customerName: request.customerName,
          customerEmail: request.customerEmail,
          customerPhone: request.customerPhone,
          onSuccess: (orderId) {
            onSuccess(
              PaymentSuccessResult(
                transactionId: orderId,
                gatewayName: gatewayName,
                metadata: {'order_id': orderId},
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
