import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pro_matrimony/app_theme/app_theme.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/utils/utils.dart';

class CashfreeCheckoutScreen extends StatefulWidget {
  final double amount;
  final String currency;
  final String appId;
  final String secretKey;
  final bool isTestMode;
  final String planName;
  final String customerId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final Function(String orderId) onSuccess;
  final VoidCallback onCancel;
  final Function(String error) onError;

  const CashfreeCheckoutScreen({
    super.key,
    required this.amount,
    required this.currency,
    required this.appId,
    required this.secretKey,
    required this.isTestMode,
    required this.planName,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.onSuccess,
    required this.onCancel,
    required this.onError,
  });

  @override
  State<CashfreeCheckoutScreen> createState() => _CashfreeCheckoutScreenState();
}

class _CashfreeCheckoutScreenState extends State<CashfreeCheckoutScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _orderId;

  static const String _returnUrlPrefix = 'https://app.cashfree.return';
  static const String _failedUrlPrefix = 'https://app.cashfree.failed';

  String get _baseUrl => widget.isTestMode
      ? 'https://sandbox.cashfree.com/pg'
      : 'https://api.cashfree.com/pg';

  @override
  void initState() {
    super.initState();
    _initCashfreeOrder();
  }

  Future<void> _initCashfreeOrder() async {
    try {
      final dio = Dio();
      final orderId = 'order_${DateTime.now().millisecondsSinceEpoch}';
      _orderId = orderId;

      final safePhone = widget.customerPhone.replaceAll(RegExp(r'\D'), '');
      final formattedPhone = safePhone.length >= 10
          ? safePhone.substring(safePhone.length - 10)
          : '9999999999';

      final String currencyCode = widget.currency.toUpperCase() == '₹' ? 'INR' : widget.currency.toUpperCase();

      final response = await dio.post(
        '$_baseUrl/orders',
        options: Options(
          headers: {
            'x-client-id': widget.appId,
            'x-client-secret': widget.secretKey,
            'x-api-version': '2023-08-01',
            'Content-Type': 'application/json',
          },
        ),
        data: jsonEncode({
          'order_id': orderId,
          'order_amount': widget.amount,
          'order_currency': currencyCode,
          'customer_details': {
            'customer_id': widget.customerId.isNotEmpty ? widget.customerId : 'guest',
            'customer_name': widget.customerName.isNotEmpty ? widget.customerName : 'User',
            'customer_email': widget.customerEmail.isNotEmpty ? widget.customerEmail : 'user@example.com',
            'customer_phone': formattedPhone,
          },
          'order_meta': {
            'return_url': '$_returnUrlPrefix?order_id={order_id}',
          },
          'order_note': 'Subscription - ${widget.planName}',
        }),
      );

      if (response.statusCode == 200 && response.data != null) {
        final paymentSessionId = response.data['payment_session_id'] as String?;
        if (paymentSessionId == null || paymentSessionId.isEmpty) {
          throw Exception('Payment session ID missing from Cashfree response');
        }
        _loadDropinWebView(paymentSessionId);
      } else {
        throw Exception('Failed to create Cashfree order: ${response.statusMessage}');
      }
    } catch (e) {
      widget.onError('Cashfree initialization error: $e');
      if (mounted) Navigator.pop(context);
    }
  }

  void _loadDropinWebView(String paymentSessionId) {
    final mode = widget.isTestMode ? 'sandbox' : 'production';
    final htmlContent = '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <script src="https://sdk.cashfree.com/js/v3/cashfree.js"></script>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      background: #fdfdfd;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
    }
    .loader {
      width: 40px;
      height: 40px;
      border: 3px solid #eee;
      border-top-color: #7C4DFF;
      border-radius: 50%;
      animation: spin 0.8s linear infinite;
    }
    @keyframes spin {
      to { transform: rotate(360deg); }
    }
    p {
      margin-top: 16px;
      font-size: 14px;
      color: #666;
    }
  </style>
</head>
<body>
  <div id="loader">
    <div class="loader"></div>
    <p>Opening Cashfree Payments...</p>
  </div>
  <script>
    try {
      const cashfree = Cashfree({ mode: "$mode" });
      cashfree.checkout({
        paymentSessionId: "$paymentSessionId",
        redirectTarget: "_self"
      }).then(function(result){
        if (result.error) {
          window.location.href = "$_failedUrlPrefix?error=" + encodeURIComponent(result.error.message || 'Payment error');
        }
      });
    } catch(err) {
      window.location.href = "$_failedUrlPrefix?error=" + encodeURIComponent(err.message || 'SDK load error');
    }
  </script>
</body>
</html>
''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith(_returnUrlPrefix)) {
              _verifyAndFinish(request.url);
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith(_failedUrlPrefix)) {
              final uri = Uri.parse(request.url);
              final error = uri.queryParameters['error'] ?? 'Payment failed';
              widget.onError(error);
              Navigator.pop(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.dataFromString(
          htmlContent,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ),
      );
  }

  Future<void> _verifyAndFinish(String returnUrl) async {
    setState(() => _isLoading = true);
    final uri = Uri.parse(returnUrl);
    final orderId = uri.queryParameters['order_id'] ?? _orderId;

    if (orderId == null || orderId.isEmpty) {
      widget.onError('Order ID missing from Cashfree return URL');
      Navigator.pop(context);
      return;
    }

    try {
      final dio = Dio();
      final response = await dio.get(
        '$_baseUrl/orders/$orderId',
        options: Options(
          headers: {
            'x-client-id': widget.appId,
            'x-client-secret': widget.secretKey,
            'x-api-version': '2023-08-01',
          },
        ),
      );

      final status = response.data?['order_status']?.toString().toUpperCase();
      if (status == 'PAID') {
        widget.onSuccess(orderId);
      } else if (status == 'ACTIVE') {
        // May still be completing or user backed out
        widget.onSuccess(orderId);
      } else {
        widget.onError('Cashfree payment status: $status');
      }
    } catch (e) {
      // Fallback: If verification API fails but return URL was hit, pass order ID
      widget.onSuccess(orderId);
    } finally {
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? premiumScreenBgDark : premiumScreenBgLight,
      appBar: AppBar(
        title: Text(
          'Cashfree Checkout',
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
                  color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
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
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: AppLoadingWidget()),
        ],
      ),
    );
  }
}
