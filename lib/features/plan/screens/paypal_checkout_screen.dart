import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:dio/dio.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/core/config/env_config.dart';

class PaypalCheckoutScreen extends ConsumerStatefulWidget {
  final double amount;
  final String currency;
  final String clientId;
  final String clientSecret;
  final Function(String transactionId) onSuccess;
  final VoidCallback onCancel;
  final Function(String error) onError;

  const PaypalCheckoutScreen({
    super.key,
    required this.amount,
    required this.currency,
    required this.clientId,
    required this.clientSecret,
    required this.onSuccess,
    required this.onCancel,
    required this.onError,
  });

  @override
  ConsumerState<PaypalCheckoutScreen> createState() => _PaypalCheckoutScreenState();
}

class _PaypalCheckoutScreenState extends ConsumerState<PaypalCheckoutScreen> {
  late final WebViewController _webViewController;
  bool _isLoading = true;
  String? _checkoutUrl;
  String? _accessToken;
  String? _orderId;

  final String _returnUrl = 'https://example.com/return';
  final String _cancelUrl = 'https://example.com/cancel';

  @override
  void initState() {
    super.initState();
    _initPaypalCheckout();
  }

  Future<void> _initPaypalCheckout() async {
    try {
      // 1. Fetch Access Token
      final token = await _getAccessToken();
      _accessToken = token;

      // 2. Create PayPal Order
      final order = await _createOrder(token);
      _orderId = order['id'];

      final links = order['links'] as List;
      final approveLink = links.firstWhere((link) => link['rel'] == 'approve');
      _checkoutUrl = approveLink['href'];

      // 3. Initialize WebViewController
      _webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (url) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (url) {
              setState(() {
                _isLoading = false;
              });
            },
            onNavigationRequest: (request) {
              if (request.url.startsWith(_returnUrl)) {
                _handleSuccess(request.url);
                return NavigationDecision.prevent;
              }
              if (request.url.startsWith(_cancelUrl)) {
                widget.onCancel();
                Navigator.pop(context);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(_checkoutUrl!));

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      widget.onError(e.toString());
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  Future<String> _getAccessToken() async {
    final dio = Dio();
    final effectiveClientId = widget.clientId.isNotEmpty ? widget.clientId : EnvConfig.paypalClientId;
    final effectiveClientSecret = widget.clientSecret.isNotEmpty ? widget.clientSecret : EnvConfig.paypalClientSecret;

    final basicAuth = 'Basic ${base64Encode(utf8.encode('$effectiveClientId:$effectiveClientSecret'))}';

    final response = await dio.post(
      '${EnvConfig.paypalBaseUrl}/v1/oauth2/token',
      data: 'grant_type=client_credentials',
      options: Options(
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data['access_token'];
    }
    throw Exception('Failed to retrieve PayPal access token');
  }

  Future<Map<String, dynamic>> _createOrder(String token) async {
    final dio = Dio();

    final double checkoutAmount = widget.currency.toUpperCase() == 'INR' || widget.currency == '₹'
        ? (widget.amount / 80.0)
        : widget.amount;

    final String finalAmountStr = checkoutAmount.toStringAsFixed(2);
    final String currencyCode = widget.currency.toUpperCase() == 'INR' || widget.currency == '₹' ? 'USD' : widget.currency;

    final response = await dio.post(
      '${EnvConfig.paypalBaseUrl}/v2/checkout/orders',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
      data: jsonEncode({
        'intent': 'CAPTURE',
        'purchase_units': [
          {
            'amount': {
              'currency_code': currencyCode,
              'value': finalAmountStr,
            }
          }
        ],
        'application_context': {
          'return_url': _returnUrl,
          'cancel_url': _cancelUrl,
        }
      }),
    );

    if (response.statusCode == 201) {
      return response.data;
    }
    throw Exception('Failed to create PayPal Order');
  }

  Future<void> _handleSuccess(String redirectUrl) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final token = Uri.parse(redirectUrl).queryParameters['token']; // Order ID in PayPal redirect

      final orderIdToCapture = token ?? _orderId;
      if (orderIdToCapture == null) {
        throw Exception('PayPal Order ID missing');
      }

      // Capture payment order
      final dio = Dio();
      final response = await dio.post(
        '${EnvConfig.paypalBaseUrl}/v2/checkout/orders/$orderIdToCapture/capture',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Retrieve transaction ID from capture payment response
        String transactionId = orderIdToCapture;
        try {
          final purchaseUnits = response.data['purchase_units'] as List;
          final payments = purchaseUnits[0]['payments'];
          final captures = payments['captures'] as List;
          transactionId = captures[0]['id'] ?? orderIdToCapture;
        } catch (_) {}

        widget.onSuccess(transactionId);
      } else {
        throw Exception('Failed to capture PayPal payment');
      }
    } catch (e) {
      widget.onError(e.toString());
    } finally {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? premiumScreenBgDark : premiumScreenBgLight,
      appBar: AppBar(
        title: Text(
          'paypal_checkout'.tr,
          style: AppFont.font(
            color: isDark ? Colors.white : premiumDarkText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 6.0, bottom: 6.0),
          child: GestureDetector(
            onTap: () {
              widget.onCancel();
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Theme.of(context).colorScheme.surface : Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: premiumShadowColor.withValues(alpha: isDark ? 0.25 : 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: isDark
                      ? Colors.white10
                      : Colors.black.withValues(alpha: 0.05),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white : Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          if (_checkoutUrl != null)
            WebViewWidget(controller: _webViewController),
          if (_isLoading)
            const Center(child: AppLoadingWidget()),
        ],
      ),
    );
  }
}
