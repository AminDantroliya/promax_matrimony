import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/glassmorphic_background.dart';
import 'package:pro_matrimony/services/firebase_phone_auth_service.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import '../providers/auth_notifier.dart';
import 'register2/providers/dynamic_register_notifier.dart';

class LoginWithOtpScreen extends ConsumerStatefulWidget {
  const LoginWithOtpScreen({super.key});

  @override
  ConsumerState<LoginWithOtpScreen> createState() => _LoginWithOtpScreenState();
}

class _LoginWithOtpScreenState extends ConsumerState<LoginWithOtpScreen> {
  final _loginWithOtpFormKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  String countryCode = "+91"; // Default
  String selectedFlag = "🇮🇳"; // Default
  late final List<Country> countryList;
  String? _mobileError;
  bool _isSendingOtp = false;

  @override
  void initState() {
    super.initState();
    final config = ref.read(appConfigProvider);
    countryCode = config.defaultCountryCode;
    selectedFlag = config.defaultCountryFlag;
    _initCountryList();
  }

  void _initCountryList() {
    final config = ref.read(appConfigProvider);
    final priorityCodes = [config.defaultCountryIso, 'IN', 'US', 'CA', 'GB', 'AU', 'NZ'];
    final List<Country> priorityList = [];
    for (var code in priorityCodes) {
      try {
        final match = countries.firstWhere(
          (c) => c.code.toUpperCase() == code.toUpperCase(),
        );
        if (!priorityList.any((c) => c.code == match.code)) {
          priorityList.add(match);
        }
      } catch (_) {}
    }
    final List<Country> otherList = countries
        .where((c) => !priorityCodes.any((pc) => pc.toUpperCase() == c.code.toUpperCase()))
        .toList();
    otherList.sort((a, b) => a.name.compareTo(b.name));
    countryList = [...priorityList, ...otherList];
  }

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  void _showCountryPicker(List<Country> countryList, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDarkMode ? const Color(0xFF161726) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return _CountryPickerSheet(
          countryList: countryList,
          isDarkMode: isDarkMode,
          onCountrySelected: (country) {
            setState(() {
              countryCode = "+${country.dialCode}";
              selectedFlag = country.flag;
            });
          },
        );
      },
    );
  }

  Future<void> _submitMobile() async {
    if (_loginWithOtpFormKey.currentState!.validate()) {
      hideKeyboard(context);
      setState(() => _isSendingOtp = true);

      final mobile = mobileController.text.trim();
      final result = await ref.read(authProvider.notifier).loginWithOtp(
            mobile,
            countryCode,
          );

      if (result != null && result['status'] == 'success') {
        final otpMethod = AppSessionService.getValue('otp_login_method') ?? 'firebase';

        if (otpMethod == 'firebase') {
          final fullPhoneNumber = '$countryCode$mobile';
          await FirebasePhoneAuthService.sendOtp(
            phoneNumber: fullPhoneNumber,
            onCodeSent: (verificationId, resendToken) {
              if (mounted) setState(() => _isSendingOtp = false);
              if (!mounted) return;
              context.push('/verify-otp', extra: {
                'mobile': mobile,
                'countryCode': countryCode,
                'verificationId': verificationId,
                'resendToken': resendToken,
              });
            },
            onVerificationCompleted: (credential) {
              if (mounted) setState(() => _isSendingOtp = false);
            },
            onVerificationFailed: (exception) {
              if (mounted) setState(() => _isSendingOtp = false);
              showToast(exception.message ?? 'Firebase Phone Verification Failed');
            },
            onCodeAutoRetrievalTimeout: (verificationId) {
              if (mounted) setState(() => _isSendingOtp = false);
            },
          );
        } else {
          if (mounted) setState(() => _isSendingOtp = false);
          if (!mounted) return;
          context.push('/verify-otp', extra: {
            'mobile': mobile,
            'countryCode': countryCode,
          });
        }
      } else {
        if (mounted) setState(() => _isSendingOtp = false);
        if (result != null) {
          showToast(result['message']?.toString() ?? 'Failed to send OTP');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final config = ref.watch(appConfigProvider);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: GlassmorphicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: _loginWithOtpFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Top Action Row (Back Button + Skip Text Link) ────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => context.pop(),
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF111827).withValues(
                                    alpha: isDarkMode ? 0.25 : 0.06,
                                  ),
                                  blurRadius: 24,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: Color(0xFFEA5575),
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        // TextButton(
                        //   onPressed: () => context.go('/home'),
                        //   style: TextButton.styleFrom(
                        //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        //   ),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       Text(
                        //         'Skip',
                        //         style: AppFont.font(
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.bold,
                        //           color: const Color(0xFF7342EB),
                        //         ),
                        //       ),
                        //       const Gap(2),
                        //       Text(
                        //         '›',
                        //         style: AppFont.font(
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.bold,
                        //           color: const Color(0xFF7342EB),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),

                    const Gap(16),

                    // ── Central branded heart logo nested circles ──────────────────
                    Center(
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              AppAssets.figmaSmallCircle,
                              width: 180,
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                            Image.asset(
                              AppAssets.splashLogoPng,
                              width: 130,
                              height: 130,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Gap(0),

                    // ── Headlines: Welcome Back ─────────────────────────────
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: AppFont.font(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : const Color(0xFF16182F),
                            height: 1.2,
                          ),
                          children: [
                            TextSpan(text: "${'welcome_back'.tr} "),
                            TextSpan(
                              text: 'back_word'.tr,
                              style: AppFont.font(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF7342EB),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Gap(8),

                    Center(
                      child: Text(
                        'login_with_phone_message'.tr,
                        textAlign: TextAlign.center,
                        style: AppFont.font(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode
                              ? Colors.white.withValues(alpha: 0.6)
                              : const Color(0xFF8A90A6),
                        ),
                      ),
                    ),

                    const Gap(36),

                    // ── Floating design: Mobile input label ─────────────────────────
                    Text(
                      'mobile'.tr.toUpperCase(),
                      style: AppFont.font(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: isDarkMode
                            ? Colors.white.withValues(alpha: 0.5)
                            : const Color(0xFF8A90A6),
                      ),
                    ),
                    const Gap(8),

                    // ── Country Code + Mobile Number Input Box ──────────────────────
                    Container(
                      constraints: const BoxConstraints(minHeight: 64),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: isDarkMode ? const Color(0xFF161726) : Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: _mobileError != null
                              ? Colors.red.shade600
                              : (isDarkMode
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : const Color(0xFFEBEDF5)),
                          width: _mobileError != null ? 1.5 : 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF101828).withValues(
                              alpha: isDarkMode ? 0.15 : 0.03,
                            ),
                            blurRadius: 18,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            // ── Left Country Code capsule picker ──
                            GestureDetector(
                              onTap: () => _showCountryPicker(countryList, isDarkMode),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? Colors.white.withValues(alpha: 0.06)
                                      : const Color(0xFFF1F3FB),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      selectedFlag,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const Gap(6),
                                    Text(
                                      countryCode,
                                      style: AppFont.font(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode ? Colors.white : const Color(0xFF16182F),
                                      ),
                                    ),
                                    const Gap(4),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 18,
                                      color: isDarkMode ? Colors.white70 : const Color(0xFF8A90A6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(12),

                            // ── Middle: Phone number text field ──
                            Expanded(
                              child: TextFormField(
                                controller: mobileController,
                                keyboardType: TextInputType.phone,
                                maxLength: 13,
                                style: AppFont.font(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white : const Color(0xFF16182F),
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'phone_number_hint'.tr,
                                  hintStyle: AppFont.font(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF8A90A6).withValues(alpha: 0.4),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                                  counterText: "",
                                  errorStyle: const TextStyle(fontSize: 0, height: 0),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    if (_mobileError != 'empty_phone_error'.tr) {
                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                        if (mounted) {
                                          setState(() => _mobileError = 'empty_phone_error'.tr);
                                        }
                                      });
                                    }
                                    return '';
                                  }
                                  if (_mobileError != null) {
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      if (mounted) {
                                        setState(() => _mobileError = null);
                                      }
                                    });
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (_mobileError != null) ...[
                      const Gap(6),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          _mobileError!,
                          style: AppFont.font(
                            color: Colors.red.shade600,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],

                    const Gap(16),

                    // ── Encrypted disclaimer text ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xFF22C55E),
                          size: 16,
                        ),
                        const Gap(6),
                        Text(
                          'number_encrypted_disclaimer'.tr,
                          style: AppFont.font(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? Colors.white54 : const Color(0xFF8A90A6),
                          ),
                        ),
                      ],
                    ),

                    const Gap(28),

                    if (_isSendingOtp || authState.maybeWhen(loading: () => true, orElse: () => false))
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(config.buttonRadius),
                          color: const Color(0xFFEA5575).withValues(alpha: 0.4),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(config.buttonRadius),
                          gradient: LinearGradient(
                            colors: [config.gradientStart, config.gradientEnd],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: config.primaryColor.withValues(alpha: 0.4),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _submitMobile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(config.buttonRadius),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppAssets.figmaSendMessage,
                                width: 18,
                                height: 18,
                                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                              ),
                              const Gap(8),
                              Text(
                                'generate_otp'.tr,
                                style: AppFont.font(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    const Gap(28),

                    // ── Continue with Divider ────────────────────────────────
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: isDarkMode
                                ? Colors.white.withValues(alpha: 0.08)
                                : const Color(0xFFE8ECEF),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or_continue_with_text'.tr,
                            style: AppFont.font(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode
                                  ? Colors.white.withValues(alpha: 0.4)
                                  : const Color(0xFF8A90A6),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: isDarkMode
                                ? Colors.white.withValues(alpha: 0.08)
                                : const Color(0xFFE8ECEF),
                          ),
                        ),
                      ],
                    ),

                    const Gap(24),

                    // ── Login with Email Toggle Button ──────────────────────────────
                    InkWell(
                      onTap: () => context.pop(),
                      borderRadius: BorderRadius.circular(28),
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white.withValues(alpha: 0.04) : Colors.white,
                          border: Border.all(
                            width: 1.5,
                            color: isDarkMode
                                ? Colors.white.withValues(alpha: 0.08)
                                : const Color(0xFFF1F5F9),
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: isDarkMode ? 0.15 : 0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.mail_outline_rounded,
                              size: 20,
                              color: Color(0xFF7342EB),
                            ),
                            const Gap(10),
                            Text(
                              'Login With Email',
                              style: AppFont.font(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode ? Colors.white : const Color(0xFF16182F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Gap(32),

                    // ── Register Link Footer ─────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'don_t_have_an_account'.tr,
                          style: AppFont.font(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? Colors.white.withValues(alpha: 0.6)
                                : const Color(0xFF8A90A6),
                          ),
                        ),
                        const Gap(4),
                        InkWell(
                          onTap: () {
                            ref
                                .read(dynamicRegisterProvider.notifier)
                                .resetRegistration();
                            context.push('/register');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: Text(
                              'register_word'.tr,
                              style: AppFont.font(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF7342EB),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CountryPickerSheet extends StatefulWidget {
  final List<Country> countryList;
  final bool isDarkMode;
  final ValueChanged<Country> onCountrySelected;

  const _CountryPickerSheet({
    required this.countryList,
    required this.isDarkMode,
    required this.onCountrySelected,
  });

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = widget.countryList.where((country) {
      final query = _searchQuery.toLowerCase();
      return country.name.toLowerCase().contains(query) ||
          country.dialCode.contains(query) ||
          country.code.toLowerCase().contains(query);
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.only(
        top: 20,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Country Code',
                style: AppFont.font(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.isDarkMode ? Colors.white : const Color(0xFF16182F),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close_rounded,
                  color: widget.isDarkMode ? Colors.white70 : const Color(0xFF8A90A6),
                ),
              ),
            ],
          ),
          const Gap(12),
          // Search Field
          Container(
            decoration: BoxDecoration(
              color: widget.isDarkMode ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF1F3FB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              controller: _searchController,
              style: AppFont.font(
                color: widget.isDarkMode ? Colors.white : const Color(0xFF16182F),
                fontWeight: FontWeight.w600,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search country...',
                hintStyle: AppFont.font(
                  color: widget.isDarkMode ? Colors.white38 : const Color(0xFF8A90A6),
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: widget.isDarkMode ? Colors.white54 : const Color(0xFF8A90A6),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear_rounded,
                          color: widget.isDarkMode ? Colors.white54 : const Color(0xFF8A90A6),
                          size: 20,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Text(
                      'No countries found',
                      style: AppFont.font(
                        color: widget.isDarkMode ? Colors.white54 : const Color(0xFF8A90A6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final country = filteredList[index];
                      return ListTile(
                        leading: Text(
                          country.flag,
                          style: const TextStyle(fontSize: 20),
                        ),
                        title: Text(
                          country.name,
                          style: AppFont.font(
                            fontWeight: FontWeight.w600,
                            color: widget.isDarkMode ? Colors.white : const Color(0xFF16182F),
                          ),
                        ),
                        trailing: Text(
                          '+${country.dialCode}',
                          style: AppFont.font(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF7342EB),
                          ),
                        ),
                        onTap: () {
                          widget.onCountrySelected(country);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
