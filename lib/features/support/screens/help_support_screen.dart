import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:pro_matrimony/features/common/providers/dropdown_notifier.dart';
import 'package:pro_matrimony/features/support/data/repositories/support_repository.dart';
import 'package:pro_matrimony/utils/constants.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_button.dart';
import 'package:pro_matrimony/widgets/app_phone_number_field.dart';
import 'package:pro_matrimony/widgets/app_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:pro_matrimony/features/profile/providers/profile_notifier.dart';
import 'package:pro_matrimony/features/support/screens/manager_chat_screen.dart';
import 'package:pro_matrimony/features/home/providers/dashboard_notifier.dart';

class HelpSupportScreen extends ConsumerStatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  ConsumerState<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends ConsumerState<HelpSupportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _reasonCtrl = TextEditingController();
  final _unescape = HtmlUnescape();
  String _countryCode = "+91";

  @override
  void initState() {
    super.initState();
    _countryCode = ref.read(appConfigProvider).defaultCountryCode;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _mobileCtrl.dispose();
    _subjectCtrl.dispose();
    _reasonCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_mobileCtrl.text.isEmpty) _mobileCtrl.text = '0';
    if (!_formKey.currentState!.validate()) return;
    hideKeyboard(context);
    showLoading(context);

    try {
      final params = {
        'name': _nameCtrl.text.trim(),
        'email': _emailCtrl.text.trim(),
        'country_code': _countryCode,
        'mobile_number': _mobileCtrl.text.trim(),
        'subject': _subjectCtrl.text.trim(),
        'message': _reasonCtrl.text.trim(),
      };
      final result = await ref
          .read(supportRepositoryProvider)
          .contactUs(params);
      hideLoading();
      final message = result['message']?.toString() ?? '';
      showToast(message.isNotEmpty ? message : 'Message sent successfully');
      _nameCtrl.clear();
      _emailCtrl.clear();
      _mobileCtrl.clear();
      _subjectCtrl.clear();
      _reasonCtrl.clear();
    } catch (e) {
      hideLoading();
      showToast(e.toString());
    }
  }

  Future<void> _launchPhone(String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri.parse('tel:$cleanPhone');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      try {
        await launchUrl(uri);
      } catch (e) {
        showToast('Could not launch dialer');
      }
    }
  }

  Future<void> _launchWhatsApp(String phone) async {
    final clean = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final uri = Uri.parse('https://wa.me/$clean');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (_) {
      try {
        await launchUrl(uri);
      } catch (e) {
        showToast('Could not open WhatsApp');
      }
    }
  }

  Future<void> _launchEmail(String email) async {
    final cleanEmail = email.trim();
    if (cleanEmail.isEmpty) return;
    final uri = Uri(
      scheme: 'mailto',
      path: cleanEmail,
    );
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (!launched) {
          await launchUrl(uri);
        }
      }
    } catch (_) {
      try {
        await launchUrl(uri);
      } catch (e) {
        showToast('Could not open email app');
      }
    }
  }

  Future<void> _launchMaps(String address) async {
    final clean = address
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    if (clean.isEmpty) return;

    final encoded = Uri.encodeComponent(clean);
    final googleMapsUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encoded');
    final geoUri = Uri.parse('geo:0,0?q=$encoded');

    try {
      if (await canLaunchUrl(geoUri)) {
        await launchUrl(geoUri, mode: LaunchMode.externalApplication);
        return;
      }
    } catch (_) {}

    try {
      if (await canLaunchUrl(googleMapsUri)) {
        await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
        return;
      }
    } catch (_) {}

    try {
      final launched = await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
      if (!launched) {
        await launchUrl(googleMapsUri, mode: LaunchMode.platformDefault);
      }
    } catch (_) {
      try {
        await launchUrl(googleMapsUri);
      } catch (e) {
        showToast('Could not open map');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final myProfile = ref.watch(myProfileProvider).value;
    final isPersonalized = myProfile?.userType?.toString() == "1";
    if (isPersonalized) {
      return const ManagerChatScreen();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dashboardAsync = ref.watch(dashboardProvider);
    final dropdowns = ref.watch(allDropdownsProvider);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F1017) : const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            AppAppBar(
              title: 'help_and_support'.tr,
              isShowActions: false,
            ),
            Expanded(
              child: dashboardAsync.when(
                data: (data) => _buildContent(
                  data?.siteSetting,
                  dropdowns.value?.countryList ?? [],
                  isDark,
                ),
                loading: () => _buildContent(
                  null,
                  dropdowns.value?.countryList ?? [],
                  isDark,
                ),
                error: (e, s) => _buildContent(
                  null,
                  dropdowns.value?.countryList ?? [],
                  isDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    Map<String, dynamic>? siteSetting,
    List<dynamic> countries,
    bool isDark,
  ) {
    final config = ref.watch(appConfigProvider);
    final phone = (siteSetting?['contact_no'] ?? config.supportPhone)?.toString() ?? '';
    final email = (siteSetting?['contact_email'] ?? config.supportEmail)?.toString() ?? '';
    final whatsapp = (siteSetting?['whatsapp'] ?? config.supportWhatsapp)?.toString() ?? '';
    final address = _unescape.convert(
      siteSetting?['full_address']?.toString() ?? '',
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Contact info cards (only if data available) ──
          if (phone.isNotEmpty ||
              email.isNotEmpty ||
              whatsapp.isNotEmpty ||
              (address.isNotEmpty && address != 'N/A')) ...[
            _sectionLabel(isDark, 'get_in_touch'.tr),
            const Gap(12),
            if (phone.isNotEmpty || email.isNotEmpty)
              Row(
                children: [
                  if (phone.isNotEmpty)
                    Expanded(
                      child: _contactCard(
                        svgPath: AppAssets.figmaVoiceCall,
                        label: 'phone_title'.tr,
                        value: phone,
                        isDark: isDark,
                        onTap: () => _launchPhone(phone),
                      ),
                    ),
                  if (phone.isNotEmpty && email.isNotEmpty) const Gap(12),
                  if (email.isNotEmpty)
                    Expanded(
                      child: _contactCard(
                        iconData: Icons.email_outlined,
                        label: 'email_title'.tr,
                        value: email,
                        isDark: isDark,
                        onTap: () => _launchEmail(email),
                      ),
                    ),
                ],
              ),
            if (whatsapp.isNotEmpty) ...[
              const Gap(12),
              _contactCard(
                svgPath: AppAssets.figmaChat,
                label: 'WhatsApp',
                value: whatsapp,
                isDark: isDark,
                onTap: () => _launchWhatsApp(whatsapp),
              ),
            ],
            if ((phone.isNotEmpty || email.isNotEmpty || whatsapp.isNotEmpty) &&
                address.isNotEmpty &&
                address != 'N/A')
              const Gap(12),
            if (address.isNotEmpty && address != 'N/A')
              _addressCard(address: address, isDark: isDark),
            const Gap(28),
          ],

          // ── Send message form ──
          _sectionLabel(
            isDark,
            'send_a_message'.tr,
          ),
          const Gap(12),
          Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  labelText: 'full_name'.tr,
                  controller: _nameCtrl,
                  validator: (v) => isNullFromBlankString(v)
                      ? 'empty_full_name_error'.tr
                      : null,
                ),
                const Gap(14),
                AppTextField(
                  labelText: 'email'.tr,
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (isNullFromBlankString(v)) return 'empty_email_error'.tr;
                    if (!emailValidatorRegExp.hasMatch(v!)) {
                      return 'invalid_email_error'.tr;
                    }
                    return null;
                  },
                ),
                const Gap(14),
                AppPhoneNumberField(
                  labelText: 'mobile'.tr,
                  controller: _mobileCtrl,
                  countryList: getPrioritizedCountryList(),
                  onCountryChanged: (country) =>
                      _countryCode = "+${country.dialCode}",
                  onChanged: (phone) => _countryCode = phone.countryCode,
                ),
                const Gap(14),
                AppTextField(
                  labelText: 'subject'.tr,
                  hint: 'enter_subject_hint'.tr,
                  controller: _subjectCtrl,
                  validator: (v) =>
                      isNullFromBlankString(v) ? 'empty_field_error'.tr : null,
                ),
                const Gap(14),
                AppTextField(
                  labelText: 'message'.tr,
                  hint: 'enter_message_details_hint'.tr,
                  controller: _reasonCtrl,
                  maxLine: 4,
                  validator: (v) =>
                      isNullFromBlankString(v) ? 'empty_field_error'.tr : null,
                ),
              ],
            ),
          ),
          const Gap(24),
          AppPrimaryButton(label: 'btn_submit'.tr, onPressed: _submit),
          const Gap(30),
        ],
      ),
    );
  }

  /// Section label with small line decoration
  Widget _sectionLabel(bool isDark, String title) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const Gap(8),
        Text(
          title,
          style: AppFont.font(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  /// Phone / Email clickable card
  Widget _contactCard({
    String? svgPath,
    IconData? iconData,
    required String label,
    required String value,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : const Color(0xFFE2E8F0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                  size: 22,
                  color: Theme.of(context).primaryColor,
                )
              else if (svgPath != null)
                SvgPicture.asset(
                  svgPath,
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              const Gap(10),
              Text(
                label.toUpperCase(),
                style: AppFont.font(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 0.6,
                ),
              ),
              const Gap(3),
              Text(
                value,
                style: AppFont.font(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Address clickable card (full width)
  Widget _addressCard({required String address, required bool isDark}) {
    // Strip HTML to get plain text for display and map search
    final plainAddress = address
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .trim();

    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => _launchMaps(plainAddress.isEmpty ? address : plainAddress),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : const Color(0xFFE2E8F0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                AppAssets.figmaLocation,
                width: 22,
                height: 22,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'address_title'.tr,
                      style: AppFont.font(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const Gap(3),
                    IgnorePointer(
                      child: HtmlWidget(
                        address,
                        textStyle: AppFont.font(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Icon(
                Icons.open_in_new_rounded,
                size: 16,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
