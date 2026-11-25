import 'package:flutter/material.dart';
import 'payment_models.dart';

/// Abstract contract implemented by every payment gateway service
abstract class PaymentGatewayService {
  /// Unique system name of the gateway, e.g. 'cashfree', 'razorpay', 'phonepe', 'paypal', 'stripe', 'inapppurchase'
  String get gatewayName;

  /// User-facing display name, e.g. 'Cashfree', 'Razorpay', 'PhonePe', 'PayPal', 'Stripe', 'In-App Purchase'
  String get displayName;

  /// Initiates and handles the complete payment flow
  Future<void> processPayment({
    required BuildContext context,
    required PaymentRequest request,
    required Function(PaymentSuccessResult result) onSuccess,
    required Function(String error) onError,
    required VoidCallback onCancel,
  });
}
