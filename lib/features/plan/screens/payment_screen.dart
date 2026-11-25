import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../utils/api_urls.dart';
import '../data/repositories/plan_repository.dart';
import '../../home/screens/home_screen.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final String paymentUrl;
  final String planId;
  final String memberId;
  final String couponCode;
  final String addOnIds;

  const PaymentScreen({
    super.key,
    required this.paymentUrl,
    required this.planId,
    required this.memberId,
    required this.couponCode,
    required this.addOnIds,
  });

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  late final WebViewController _controller;
  bool _isHandled = false;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _handleSuccess(String url) {
    if (_isHandled) return;
    _isHandled = true;
    final uri = Uri.parse(url);
    final transactionId = uri.queryParameters['transaction_id'] ?? 
                          uri.queryParameters['payment_id'] ?? 
                          "pay_SzWM0cvR232sad2";
    _assignPlan(transactionId);
  }

  void _handleFailure() {
    if (_isHandled) return;
    _isHandled = true;
    hideLoading();
    showToast('payment_failed_lbl'.tr);
    Navigator.pop(context);
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            showLoading(context);
            if (url.startsWith(paymentSuccess)) {
              _handleSuccess(url);
            }
            if (url.startsWith(paymentFailed)) {
              _handleFailure();
            }
          },
          onPageFinished: (String url) {
            hideLoading();
          },
          onWebResourceError: (WebResourceError error) {
            hideLoading();
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(paymentSuccess)) {
              _handleSuccess(request.url);
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith(paymentFailed)) {
              _handleFailure();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  Future<void> _assignPlan(String transactionId) async {
    showLoading(context);
    try {
      final params = {
        "plan_id": widget.planId,
        "member_id": widget.memberId,
        "coupon_code": widget.couponCode,
        "package_ids": widget.addOnIds,
        "transaction_id": transactionId,
      };

      final result = await ref.read(planRepositoryProvider).assignPlanNew(params);
      hideLoading();
      
      if (result['status'] == "success") {
        showToast('payment_success_msg'.tr);
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        }
      } else {
        showToast(result['message'] ?? 'failed_to_assign_plan'.tr);
      }
    } catch (e) {
      hideLoading();
      showToast('error_processing_payment'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('payment_lbl'.tr),
        backgroundColor: appPrimaryColor,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
