import 'package:flutter/material.dart';
import '../payment_gateway_service.dart';
import '../payment_models.dart';
import '../screens/phonepe_checkout_screen.dart';

class PhonepeGatewayService implements PaymentGatewayService {
  @override
  String get gatewayName => 'phonepe';

  @override
  String get displayName => 'PhonePe';

  @override
  Future<void> processPayment({
    required BuildContext context,
    required PaymentRequest request,
    required Function(PaymentSuccessResult result) onSuccess,
    required Function(String error) onError,
    required VoidCallback onCancel,
  }) async {
    final merchantId = request.clientId;
    final rawSecret = request.clientSecret;

    if (merchantId.isEmpty) {
      onError('PhonePe Merchant ID not provided from backend');
      return;
    }
    if (rawSecret.isEmpty) {
      onError('PhonePe Salt Key not provided from backend');
      return;
    }

    // Support saltKey formatted as "KEY###INDEX" or just "KEY"
    String saltKey = rawSecret;
    String saltIndex = '1';
    if (rawSecret.contains('###')) {
      final parts = rawSecret.split('###');
      saltKey = parts[0];
      if (parts.length > 1 && parts[1].isNotEmpty) {
        saltIndex = parts[1];
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PhonepeCheckoutScreen(
          amount: request.amount,
          merchantId: merchantId,
          saltKey: saltKey,
          saltIndex: saltIndex,
          isTestMode: request.isTestMode,
          planName: request.planName,
          customerId: request.customerId,
          customerPhone: request.customerPhone,
          onSuccess: (transactionId) {
            onSuccess(
              PaymentSuccessResult(
                transactionId: transactionId,
                gatewayName: gatewayName,
                metadata: {'merchant_transaction_id': transactionId},
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
