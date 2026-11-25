import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pro_matrimony/app_theme/app_theme.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/utils/utils.dart';

class PhonepeCheckoutScreen extends StatefulWidget {
  final double amount;
  final String merchantId;
  final String saltKey;
  final String saltIndex;
  final bool isTestMode;
  final String planName;
  final String customerId;
  final String customerPhone;
  final Function(String transactionId) onSuccess;
  final VoidCallback onCancel;
  final Function(String error) onError;

  const PhonepeCheckoutScreen({
    super.key,
    required this.amount,
    required this.merchantId,
    required this.saltKey,
    this.saltIndex = '1',
    required this.isTestMode,
    required this.planName,
    required this.customerId,
    required this.customerPhone,
    required this.onSuccess,
    required this.onCancel,
    required this.onError,
  });

  @override
  State<PhonepeCheckoutScreen> createState() => _PhonepeCheckoutScreenState();
}

class _PhonepeCheckoutScreenState extends State<PhonepeCheckoutScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _transactionId;

  static const String _redirectUrlPrefix = 'https://app.phonepe.return';

  String get _payEndpoint => widget.isTestMode
      ? 'https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/pay'
      : 'https://api.phonepe.com/apis/hermes/pg/v1/pay';

  @override
  void initState() {
    super.initState();
    _initPhonePePayment();
  }

  Future<void> _initPhonePePayment() async {
    try {
      final dio = Dio();
      final txnId = 'MT_${DateTime.now().millisecondsSinceEpoch}';
      _transactionId = txnId;

      final amountInPaise = (widget.amount * 100).round();
      final safePhone = widget.customerPhone.replaceAll(RegExp(r'\D'), '');
      final formattedPhone = safePhone.length >= 10
          ? safePhone.substring(safePhone.length - 10)
          : '9999999999';

      final payload = {
        'merchantId': widget.merchantId,
        'merchantTransactionId': txnId,
        'merchantUserId': widget.customerId.isNotEmpty ? widget.customerId : 'user_${DateTime.now().millisecondsSinceEpoch}',
        'amount': amountInPaise,
        'redirectUrl': '$_redirectUrlPrefix?txnId=$txnId',
        'redirectMode': 'REDIRECT',
        'callbackUrl': 'https://example.com/phonepe-callback',
        'mobileNumber': formattedPhone,
        'paymentInstrument': {
          'type': 'PAY_PAGE',
        },
      };

      final jsonPayload = jsonEncode(payload);
      final base64Payload = base64Encode(utf8.encode(jsonPayload));

      // Checksum: SHA256(base64Payload + "/pg/v1/pay" + saltKey) + "###" + saltIndex
      final stringToHash = '$base64Payload/pg/v1/pay${widget.saltKey}';
      final sha256Digest = sha256.convert(utf8.encode(stringToHash)).toString();
      final checksum = '$sha256Digest###${widget.saltIndex}';

      final response = await dio.post(
        _payEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-VERIFY': checksum,
          },
        ),
        data: jsonEncode({
          'request': base64Payload,
        }),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'];
        final redirectUrl = data?['instrumentResponse']?['redirectInfo']?['url'] as String?;

        if (redirectUrl == null || redirectUrl.isEmpty) {
          throw Exception('PhonePe redirect URL missing from response');
        }

        _loadWebView(redirectUrl);
      } else {
        throw Exception(response.data?['message'] ?? 'PhonePe pay request failed');
      }
    } catch (e) {
      widget.onError('PhonePe initiation error: $e');
      if (mounted) Navigator.pop(context);
    }
  }

  void _loadWebView(String redirectUrl) {
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
            if (request.url.startsWith(_redirectUrlPrefix)) {
              final uri = Uri.parse(request.url);
              final txnId = uri.queryParameters['txnId'] ?? _transactionId ?? 'MT_${DateTime.now().millisecondsSinceEpoch}';
              widget.onSuccess(txnId);
              Navigator.pop(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(redirectUrl));

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? premiumScreenBgDark : premiumScreenBgLight,
      appBar: AppBar(
        title: Text(
          'PhonePe Checkout',
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
