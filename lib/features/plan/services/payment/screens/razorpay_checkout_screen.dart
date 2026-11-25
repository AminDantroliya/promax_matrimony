import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pro_matrimony/app_theme/app_theme.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import 'package:url_launcher/url_launcher.dart';

class RazorpayCheckoutScreen extends StatefulWidget {
  final double amount;
  final String currency;
  final String keyId;
  final String planName;
  final String userName;
  final String userEmail;
  final String userPhone;
  final Function(String paymentId) onSuccess;
  final VoidCallback onCancel;
  final Function(String error) onError;

  const RazorpayCheckoutScreen({
    super.key,
    required this.amount,
    required this.currency,
    required this.keyId,
    required this.planName,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.onSuccess,
    required this.onCancel,
    required this.onError,
  });

  @override
  State<RazorpayCheckoutScreen> createState() => _RazorpayCheckoutScreenState();
}

class _RazorpayCheckoutScreenState extends State<RazorpayCheckoutScreen> with WidgetsBindingObserver{
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasLaunchedUpi = false;
  bool _showCancelBanner = false;

  static const String _successUrl = 'https://app.razorpay.success';
  static const String _cancelUrl = 'https://app.razorpay.cancel';
  static const String _failedUrl = 'https://app.razorpay.failed';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initWebView();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _hasLaunchedUpi) {
      if (mounted) {
        setState(() => _showCancelBanner = true);
      }
    }
  }

  void _initWebView() {
    final int amountInPaise = (widget.amount * 100).round();
    final String currencyCode = widget.currency.toUpperCase() == '₹' ? 'INR' : widget.currency.toUpperCase();

    final htmlContent = '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
  <style>
    html, body {
      margin: 0;
      padding: 0;
      width: 100%;
      height: 100%;
      background: #fdfdfd;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      overflow-x: hidden;
      color: #333;
    }
    iframe[src*="razorpay"],
    .razorpay-checkout-frame {
      position: fixed !important;
      top: 0 !important;
      left: 0 !important;
      width: 100vw !important;
      height: 100vh !important;
      max-width: 100% !important;
      max-height: 100% !important;
      border: none !important;
      margin: 0 !important;
      padding: 0 !important;
      z-index: 999999 !important;
    }
    .loader {
      width: 40px;
      height: 40px;
      border: 3px solid #eee;
      border-top-color: #6750A4;
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
  <div id="loader-box" style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100vh;">
    <div class="loader"></div>
    <p>Connecting to Razorpay...</p>
  </div>
  <script>
    var options = {
      "key": "${widget.keyId}",
      "amount": $amountInPaise,
      "currency": "$currencyCode",
      "name": "Pro Max Matrimony",
      "description": "${widget.planName}",
      "prefill": {
        "name": "${widget.userName}",
        "email": "${widget.userEmail}",
        "contact": "${widget.userPhone}"
      },
      "theme": {
        "color": "#7C4DFF"
      },
      "config": {
        "display": {
          "blocks": {
            "all": {
              "name": "All Payment Options",
              "instruments": [
                { "method": "upi" },
                { "method": "card" },
                { "method": "netbanking" },
                { "method": "wallet" }
              ]
            }
          },
          "sequence": [
            "block.all"
          ],
          "preferences": {
            "show_default_blocks": false
          }
        }
      },
      "handler": function (response){
        window.location.href = "$_successUrl?payment_id=" + encodeURIComponent(response.razorpay_payment_id);
      },
      "retry": {
        "enabled": false
      },
      "modal": {
        "confirm_close": false,
        "backdropclose": true,
        "escape": true,
        "ondismiss": function(){
          window.location.href = "$_cancelUrl";
        }
      }
    };
    var rzp = new Razorpay(options);
    rzp.on('payment.failed', function (response){
      var desc = response.error ? response.error.description : 'Payment failed';
      window.location.href = "$_failedUrl?error=" + encodeURIComponent(desc);
    });
    window.onload = function() {
      rzp.open();
      var box = document.getElementById('loader-box');
      if (box) {
        box.style.display = 'none';
      }
    };
  </script>
</body>
</html>
''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent("Mozilla/5.0 (Linux; Android 13; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36")
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            if (_isLoading && mounted) {
              setState(() => _isLoading = false);
            }
          },
          onNavigationRequest: (request) {
            final url = request.url;

            if (url.startsWith(_successUrl)) {
              final uri = Uri.parse(url);
              final paymentId = uri.queryParameters['payment_id'] ?? 'rzp_${DateTime.now().millisecondsSinceEpoch}';
              widget.onSuccess(paymentId);
              Navigator.pop(context);
              return NavigationDecision.prevent;
            }
            if (url.startsWith(_cancelUrl)) {
              widget.onCancel();
              Navigator.pop(context);
              return NavigationDecision.prevent;
            }
            if (url.startsWith(_failedUrl)) {
              final uri = Uri.parse(url);
              final error = uri.queryParameters['error'] ?? 'Payment failed';
              widget.onError(error);
              Navigator.pop(context);
              return NavigationDecision.prevent;
            }

            // Handle UPI and native app deep links (upi://, phonepe://, paytmmp://, tez://, intent://)
            if (!url.startsWith('http://') && !url.startsWith('https://')) {
              _launchExternalUpiUrl(url);
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

  Future<void> _launchExternalUpiUrl(String url) async {
    try {
      _hasLaunchedUpi = true;
      String targetUrl = url;
      // Convert Android intent:// URLs to direct UPI URI
      // e.g.: intent://pay?pa=...#Intent;scheme=upi;package=com.phonepe.app;end -> upi://pay?...
      if (targetUrl.startsWith('intent://')) {
        final schemeMatch = RegExp(r'scheme=([^;]+)').firstMatch(targetUrl);
        final scheme = schemeMatch?.group(1) ?? 'upi';
        final cleanBody = targetUrl.replaceFirst('intent://', '').split('#Intent;').first;
        targetUrl = '$scheme://$cleanBody';
      }

      final uri = Uri.parse(targetUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      printLog('UPI External Launch Error: $e');
    }
  }

  void _handleCancel() {
    widget.onCancel();
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          _handleCancel();
        },
        child: Scaffold(
      backgroundColor: isDark ? premiumScreenBgDark : premiumScreenBgLight,
      appBar: AppBar(
        title: Text(
          'Razorpay Checkout',
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
            onTap: _handleCancel,
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
    )  );
  }
}
