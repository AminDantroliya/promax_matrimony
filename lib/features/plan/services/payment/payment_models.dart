import '../../data/models/plan_models.dart';
import 'package:pro_matrimony/features/profile/data/models/profile_models.dart';

/// Request parameters passed to any payment gateway
class PaymentRequest {
  final double amount;
  final String currency;
  final String planId;
  final String planName;
  final String planDescription;
  final ProfileData? userProfile;
  final PaymentMethods? paymentMethods;
  final String couponCode;
  final String packageIds;
  final String? userEmail;
  final String? userPhone;
  final String? userName;
  final Map<String, dynamic>? metadata;

  const PaymentRequest({
    required this.amount,
    required this.currency,
    this.planId = '',
    required this.planName,
    this.planDescription = '',
    this.userProfile,
    this.paymentMethods,
    this.couponCode = '',
    this.packageIds = '',
    this.userEmail,
    this.userPhone,
    this.userName,
    this.metadata,
  });

  String get customerId => userProfile?.id?.toString() ?? metadata?['addon_id']?.toString() ?? 'guest';
  String get customerName => userName ?? userProfile?.fullname?.toString() ?? 'User';
  String get customerEmail => userEmail ?? userProfile?.email?.toString() ?? 'user@example.com';
  String get customerPhone => userPhone ?? userProfile?.mobile?.toString() ?? '9999999999';

  /// Resolves the API key or client ID from backend payment_methods
  String get clientId => paymentMethods?.clientId?.trim() ?? '';

  /// Resolves the secret or salt from backend payment_methods
  String get clientSecret => paymentMethods?.clientSecret?.trim() ?? '';

  /// "Test" or "Live"
  String get paymentMode => paymentMethods?.paymentMode?.trim() ?? 'Test';
  bool get isTestMode => paymentMode.toLowerCase() != 'live';
}

/// Standardized success response returned by any payment gateway
class PaymentSuccessResult {
  final String transactionId;
  final String gatewayName;
  final Map<String, dynamic>? metadata;

  const PaymentSuccessResult({
    required this.transactionId,
    required this.gatewayName,
    this.metadata,
  });
}
