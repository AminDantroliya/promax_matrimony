import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_common_background.dart';
import '../../plan/data/repositories/plan_repository.dart';
import '../../plan/services/payment/payment_gateway_registry.dart';
import '../../plan/services/payment/payment_models.dart';
import '../../profile/providers/profile_notifier.dart';
import '../data/models/event_models.dart';
import '../data/repositories/event_repository.dart';
import '../providers/event_notifier.dart';

class EventConfirmationScreen extends ConsumerStatefulWidget {
  final EventItem event;
  final int quantity;

  const EventConfirmationScreen({
    super.key,
    required this.event,
    required this.quantity,
  });

  @override
  ConsumerState<EventConfirmationScreen> createState() =>
      _EventConfirmationScreenState();
}

class _EventConfirmationScreenState
    extends ConsumerState<EventConfirmationScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _mobileController;
  String _countryCode = '+91';
  String _selectedHearAboutUs = 'Friend / Family';
  bool _isSubmitting = false;

  final List<String> _hearAboutOptions = [
    'Friend / Family',
    'Social Media',
    'Google',
    'Advertisement',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _mobileController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _prefillUserData();
    });
  }

  void _prefillUserData() {
    final profile = ref.read(myProfileProvider).value;
    if (profile != null) {
      if (profile.fullname?.isNotEmpty == true) {
        _nameController.text = profile.fullname!;
      }
      if (profile.email?.isNotEmpty == true) {
        _emailController.text = profile.email!;
      }
      if (profile.mobile?.isNotEmpty == true) {
        final rawMob = profile.mobile!;
        if (rawMob.contains('-')) {
          final parts = rawMob.split('-');
          _countryCode = parts[0];
          _mobileController.text = parts[1];
        } else {
          _mobileController.text = rawMob;
        }
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  double get _unitPrice => widget.event.ticketPrice;
  int get _qty => widget.quantity > 0 ? widget.quantity : 1;
  double get _subTotal => _unitPrice * _qty;
  double get _totalPayment => _subTotal;

  String _formatAmount(double amount) {
    final curr = widget.event.currency ?? 'INR';
    final isWhole = amount == amount.roundToDouble();
    final amtStr =
        isWhole ? amount.toInt().toString() : amount.toStringAsFixed(2);
    return '$curr $amtStr';
  }

  Future<void> _handleProceed() async {
    if (!_formKey.currentState!.validate()) {
      showToast('please_fill_required_fields'.tr);
      return;
    }

    if (_totalPayment <= 0) {
      // Free Event Booking
      await _bookEvent(
        paymentMode: 'Free',
        transactionId: 'FREE_${DateTime.now().millisecondsSinceEpoch}',
      );
      return;
    }

    // Paid Event Booking Flow
    _initiatePayment();
  }

  Future<void> _initiatePayment() async {
    setState(() => _isSubmitting = true);

    try {
      // Fetch dynamic active payment methods from plan repository
      final planRes = await ref.read(planRepositoryProvider).getPlanList();
      final paymentMethods = planRes.data?.paymentMethods;

      setState(() => _isSubmitting = false);

      final gatewayName = paymentMethods?.paymentName?.trim();
      final gateway = PaymentGatewayRegistry.getGateway(gatewayName);

      if (gateway != null && mounted) {
        // Run configured gateway
        final profile = ref.read(myProfileProvider).value;
        final req = PaymentRequest(
          amount: _totalPayment,
          currency: widget.event.currency ?? 'INR',
          planName: widget.event.title,
          planId: widget.event.id.toString(),
          userProfile: profile,
          userEmail: _emailController.text.trim(),
          userPhone: '$_countryCode${_mobileController.text.trim()}',
          userName: _nameController.text.trim(),
          paymentMethods: paymentMethods,
          metadata: {
            'event_id': widget.event.id.toString(),
            'tickets': _qty.toString(),
          },
        );

        gateway.processPayment(
          context: context,
          request: req,
          onSuccess: (result) {
            _bookEvent(
              paymentMode: result.gatewayName,
              transactionId: result.transactionId,
            );
          },
          onError: (errMsg) {
            showToast(errMsg);
          },
          onCancel: () {
            showToast('Payment cancelled');
          },
        );
      } else {
        // Fallback / Sandbox Gateway Selector if no specific gateway configured in backend
        if (mounted) {
          _showPaymentGatewayModal();
        }
      }
    } catch (_) {
      setState(() => _isSubmitting = false);
      if (mounted) {
        _showPaymentGatewayModal();
      }
    }
  }

  void _showPaymentGatewayModal() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E2132) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'select_payment_mode'.tr,
              style: AppFont.font(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF16182F),
              ),
            ),
            const Gap(16),
            ListTile(
              leading: const Icon(Icons.payment_rounded, color: Color(0xFF0D9488)),
              title: Text('Razorpay / UPI / Cards',
                  style: AppFont.font(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(ctx);
                _bookEvent(
                  paymentMode: 'Razorpay',
                  transactionId: 'pay_${DateTime.now().millisecondsSinceEpoch}',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet_outlined,
                  color: Color(0xFF0D9488)),
              title: Text('Cashfree Payments',
                  style: AppFont.font(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(ctx);
                _bookEvent(
                  paymentMode: 'Cashfree',
                  transactionId: 'cf_${DateTime.now().millisecondsSinceEpoch}',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.paypal_rounded, color: Color(0xFF0079C1)),
              title: Text('PayPal',
                  style: AppFont.font(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(ctx);
                _bookEvent(
                  paymentMode: 'PayPal',
                  transactionId: 'pay_${DateTime.now().millisecondsSinceEpoch}',
                );
              },
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }

  Future<void> _bookEvent({
    required String paymentMode,
    required String transactionId,
  }) async {
    setState(() => _isSubmitting = true);

    try {
      final params = {
        'event_id': widget.event.id.toString(),
        'total_tickets': _qty.toString(),
        'payment_mode': paymentMode,
        'transaction_id': transactionId,
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'mobile': '$_countryCode-${_mobileController.text.trim()}',
        'hear_about_us': _selectedHearAboutUs,
      };

      final response =
          await ref.read(eventRepositoryProvider).bookEvent(params);

      setState(() => _isSubmitting = false);

      if (response.status && mounted) {
        // Refresh registered events and event list
        ref.read(registeredEventsProvider.notifier).fetchRegisteredEvents();
        ref.read(eventListProvider.notifier).fetchEvents(isRefresh: true);

        _showSuccessDialog();
      } else {
        showToast(response.message.isNotEmpty
            ? response.message
            : 'Booking failed. Please try again.');
      }
    } catch (e) {
      setState(() => _isSubmitting = false);
      showToast('Error booking event: $e');
    }
  }

  void _showSuccessDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E2132) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFE6FFFA),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF0D9488),
                size: 54,
              ),
            ),
            const Gap(16),
            Text(
              'booking_successful'.tr,
              style: AppFont.font(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF16182F),
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              'booking_success_msg'.tr,
              style: AppFont.font(
                fontSize: 13,
                color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx); // Close dialog
                  context.pushReplacement('/registered-events');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D9488),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'view_my_bookings'.tr,
                  style: AppFont.font(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const Gap(8),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.go('/events');
              },
              child: Text(
                'back_to_events'.tr,
                style: AppFont.font(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : const Color(0xFF4B5563),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : const Color(0xFF16182F);
    final subtitleColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final cardBg = isDark ? const Color(0xFF161828) : Colors.white;
    final cardBorder = isDark ? const Color(0xFF26293D) : const Color(0xFFE5E7EB);
    final summaryBg = isDark ? const Color(0xFF202336) : const Color(0xFFF5EFE6);
    const tealColor = Color(0xFF0D9488);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppCommonBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF222538) : const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: titleColor,
                        ),
                      ),
                    ),
                    const Gap(14),
                    Text(
                      'confirmation_details'.tr,
                      style: AppFont.font(
                        color: titleColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Confirmation Body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Top Summary Banner (Matching Image 4)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: summaryBg,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 12,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              _buildSummaryItem(
                                'event_name_lbl'.tr,
                                widget.event.title,
                                titleColor,
                                subtitleColor,
                              ),
                              _buildSummaryItem(
                                'tickets'.tr,
                                '$_qty',
                                titleColor,
                                subtitleColor,
                              ),
                              _buildSummaryItem(
                                'per_ticket_price'.tr,
                                _formatAmount(_unitPrice),
                                titleColor,
                                subtitleColor,
                              ),
                              _buildSummaryItem(
                                'sub_total'.tr,
                                _formatAmount(_subTotal),
                                titleColor,
                                subtitleColor,
                              ),
                              _buildSummaryItem(
                                'total_payment'.tr,
                                _formatAmount(_totalPayment),
                                tealColor,
                                subtitleColor,
                                isBold: true,
                              ),
                            ],
                          ),
                        ),
                        const Gap(18),

                        // 2. Confirmation Form Card (Matching Image 4)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: cardBorder, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: isDark ? Colors.black.withValues(alpha: 0.2) : const Color(0x06000000),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'confirmation_details'.tr,
                                style: AppFont.font(
                                  color: titleColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                'confirmation_details_subtitle'.tr,
                                style: AppFont.font(
                                  color: subtitleColor,
                                  fontSize: 12,
                                ),
                              ),
                              const Gap(18),

                              // Name Field
                              _buildFieldLabel('name_lbl'.tr, true, titleColor),
                              const Gap(6),
                              TextFormField(
                                controller: _nameController,
                                style: AppFont.font(color: titleColor, fontSize: 14),
                                decoration: _buildInputDecoration(
                                  hintText: 'enter_name'.tr,
                                  isDark: isDark,
                                ),
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return 'enter_name'.tr;
                                  }
                                  return null;
                                },
                              ),
                              const Gap(14),

                              // Email Field
                              _buildFieldLabel('email_lbl'.tr, true, titleColor),
                              const Gap(6),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: AppFont.font(color: titleColor, fontSize: 14),
                                decoration: _buildInputDecoration(
                                  hintText: 'enter_email'.tr,
                                  isDark: isDark,
                                ),
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return 'enter_email'.tr;
                                  }
                                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(val.trim())) {
                                    return 'invalid_email_address'.tr;
                                  }
                                  return null;
                                },
                              ),
                              const Gap(14),

                              // Mobile Number Field
                              _buildFieldLabel('mobile_lbl'.tr, true, titleColor),
                              const Gap(6),
                              Row(
                                children: [
                                  // Country Code Box
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF1E2132) : const Color(0xFFF9FAFB),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isDark ? const Color(0xFF32364E) : const Color(0xFFE5E7EB),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          _countryCode,
                                          style: AppFont.font(
                                            color: titleColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const Gap(4),
                                        Icon(Icons.keyboard_arrow_down, size: 16, color: subtitleColor),
                                      ],
                                    ),
                                  ),
                                  const Gap(8),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _mobileController,
                                      keyboardType: TextInputType.phone,
                                      style: AppFont.font(color: titleColor, fontSize: 14),
                                      decoration: _buildInputDecoration(
                                        hintText: 'enter_mobile'.tr,
                                        isDark: isDark,
                                        prefixIcon: Icon(Icons.phone_iphone_rounded, size: 18, color: subtitleColor),
                                      ),
                                      validator: (val) {
                                        if (val == null || val.trim().isEmpty) {
                                          return 'enter_mobile'.tr;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(14),

                              // Hear about us Dropdown
                              _buildFieldLabel('hear_about_us'.tr, true, titleColor),
                              const Gap(6),
                              DropdownButtonFormField<String>(
                                initialValue: _selectedHearAboutUs,
                                dropdownColor: cardBg,
                                style: AppFont.font(color: titleColor, fontSize: 14),
                                decoration: _buildInputDecoration(
                                  hintText: 'select_hear_about_us'.tr,
                                  isDark: isDark,
                                ),
                                icon: Icon(Icons.keyboard_arrow_down_rounded, color: subtitleColor),
                                items: _hearAboutOptions
                                    .map(
                                      (opt) => DropdownMenuItem(
                                        value: opt,
                                        child: Text(opt),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _selectedHearAboutUs = val;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const Gap(16),

                        // 3. Venue & Map Card
                        if (widget.event.venue != null && widget.event.venue!.trim().isNotEmpty) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: cardBorder, width: 1),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: tealColor.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.location_on_rounded, color: tealColor, size: 20),
                                ),
                                const Gap(12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'venue'.tr,
                                        style: AppFont.font(color: subtitleColor, fontSize: 12),
                                      ),
                                      const Gap(2),
                                      Text(
                                        widget.event.venue!.trim(),
                                        style: AppFont.font(
                                          color: titleColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (widget.event.mapAddress?.isNotEmpty == true)
                                  IconButton(
                                    onPressed: () {
                                      final uri = Uri.tryParse(widget.event.mapAddress!);
                                      if (uri != null) {
                                        launchUrl(uri, mode: LaunchMode.externalApplication);
                                      }
                                    },
                                    icon: const Icon(Icons.open_in_new_rounded, size: 18, color: tealColor),
                                  ),
                              ],
                            ),
                          ),
                          const Gap(20),
                        ],

                        // 4. Book Now / Proceed to Payment Button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _isSubmitting ? null : _handleProceed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: tealColor,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: tealColor.withValues(alpha: 0.6),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: _isSubmitting
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    _totalPayment > 0
                                        ? '${'book_now'.tr} • ${_formatAmount(_totalPayment)}'
                                        : 'book_now'.tr,
                                    style: AppFont.font(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const Gap(24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value,
    Color valColor,
    Color labelColor, {
    bool isBold = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFont.font(
            color: labelColor,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(3),
        Text(
          value,
          style: AppFont.font(
            color: valColor,
            fontSize: isBold ? 14 : 13,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label, bool isRequired, Color textColor) {
    return Row(
      children: [
        Text(
          label,
          style: AppFont.font(
            color: textColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isRequired) ...[
          const Gap(4),
          const Text(
            '*',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ],
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required bool isDark,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppFont.font(
        color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
        fontSize: 13,
      ),
      filled: true,
      fillColor: isDark ? const Color(0xFF1E2132) : const Color(0xFFF9FAFB),
      prefixIcon: prefixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? const Color(0xFF32364E) : const Color(0xFFE5E7EB),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? const Color(0xFF32364E) : const Color(0xFFE5E7EB),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF0D9488),
          width: 1.5,
        ),
      ),
      isDense: true,
    );
  }
}
