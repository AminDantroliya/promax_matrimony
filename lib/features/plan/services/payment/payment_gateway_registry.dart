import 'payment_gateway_service.dart';
import 'gateways/cashfree_gateway.dart';
import 'gateways/in_app_purchase_gateway.dart';
import 'gateways/paypal_gateway.dart';
import 'gateways/phonepe_gateway.dart';
import 'gateways/razorpay_gateway.dart';
import 'gateways/stripe_gateway.dart';

/// Central registry managing all payment gateway integrations.
/// Easy to register new gateways or remove existing ones without touching UI screens.
class PaymentGatewayRegistry {
  static final Map<String, PaymentGatewayService> _gateways = {};

  static bool _initialized = false;

  /// Ensures default gateways are registered
  static void _ensureInitialized() {
    if (_initialized) return;
    _initialized = true;

    registerGateway('cashfree', CashfreeGatewayService());
    registerGateway('razorpay', RazorpayGatewayService());
    registerGateway('phonepe', PhonepeGatewayService());
    registerGateway('paypal', PaypalGatewayService());
    registerGateway('stripe', StripeGatewayService());
    registerGateway('inapppurchase', InAppPurchaseGatewayService());
  }

  /// Register a new gateway service
  static void registerGateway(String name, PaymentGatewayService service) {
    _gateways[_normalize(name)] = service;
  }

  /// Unregister a gateway service
  static void unregisterGateway(String name) {
    _gateways.remove(_normalize(name));
  }

  /// Look up a gateway service by name (e.g. 'Cashfree', 'Razorpay', 'PhonePe', 'PayPal', 'Stripe', 'InAppPurchase')
  static PaymentGatewayService? getGateway(String? name) {
    _ensureInitialized();
    if (name == null || name.trim().isEmpty) return null;
    final normalized = _normalize(name);
    return _gateways[normalized];
  }

  /// List of registered gateway identifiers
  static List<String> get availableGateways {
    _ensureInitialized();
    return _gateways.keys.toList();
  }

  static String _normalize(String name) {
    return name.toLowerCase().replaceAll(RegExp(r'[\s_\-]'), '');
  }
}
