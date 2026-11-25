import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pro_matrimony/app_theme/app_theme.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/utils/utils.dart';

class StripeCheckoutScreen extends StatefulWidget {
  final double amount;
  final String currency;
  final String secretKey;
  final String publishableKey;
  final String planName;
  final String customerEmail;
  final String customerId;
  final Function(String sessionId) onSuccess;
  final VoidCallback onCancel;
  final Function(String error) onError;

  const StripeCheckoutScreen({
    super.key,
    required this.amount,
    required this.currency,
    required this.secretKey,
    required this.publishableKey,
    required this.planName,
    required this.customerEmail,
    required this.customerId,
    required this.onSuccess,
    required this.onCancel,
    required this.onError,
  });

  @override
  State<StripeCheckoutScreen> createState() => _StripeCheckoutScreenState();
}

class _StripeCheckoutScreenState extends State<StripeCheckoutScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _checkoutUrl;
  String? _sessionId;

  static const String _successUrl = 'https://app.stripe.success';
  static const String _cancelUrl = 'https://app.stripe.cancel';

  @override
  void initState() {
    super.initState();
    _initStripeSession();
  }

  Future<void> _initStripeSession() async {
    try {
      final dio = Dio();
      final String currencyCode = (widget.currency.toUpperCase() == '₹' || widget.currency.toUpperCase() == 'INR')
          ? 'inr'
          : widget.currency.toLowerCase();

      final int unitAmount = (widget.amount * 100).round();

      final response = await dio.post(
        'https://api.stripe.com/v1/checkout/sessions',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${widget.secretKey}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {
          'payment_method_types[0]': 'card',
          'mode': 'payment',
          'customer_email': widget.customerEmail.isNotEmpty ? widget.customerEmail : 'user@example.com',
          'client_reference_id': widget.customerId.isNotEmpty ? widget.customerId : 'user',
          'line_items[0][price_data][currency]': currencyCode,
          'line_items[0][price_data][unit_amount]': unitAmount.toString(),
          'line_items[0][price_data][product_data][name]': 'Pro Max Matrimony - ${widget.planName}',
          'success_url': '$_successUrl?session_id={CHECKOUT_SESSION_ID}',
          'cancel_url': _cancelUrl,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final url = response.data['url'] as String?;
        final id = response.data['id'] as String?;

        if (url == null || url.isEmpty) {
          throw Exception('Stripe checkout URL missing from response');
        }

        _checkoutUrl = url;
        _sessionId = id;
        _setupWebView(url);
      } else {
        throw Exception(response.data?['error']?['message'] ?? 'Failed to create Stripe session');
      }
    } catch (e) {
      widget.onError('Stripe initialization error: $e');
      if (mounted) Navigator.pop(context);
    }
  }

  void _setupWebView(String url) {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (u) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (u) {
            setState(() => _isLoading = false);
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith(_successUrl)) {
              final uri = Uri.parse(request.url);
              final sessionId = uri.queryParameters['session_id'] ?? _sessionId ?? 'cs_${DateTime.now().millisecondsSinceEpoch}';
              widget.onSuccess(sessionId);
              Navigator.pop(context);
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
      ..loadRequest(Uri.parse(url));

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? premiumScreenBgDark : premiumScreenBgLight,
      appBar: AppBar(
        title: Text(
          'Stripe Checkout',
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
          if (_checkoutUrl != null)
            WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: AppLoadingWidget()),
        ],
      ),
    );
  }
}
