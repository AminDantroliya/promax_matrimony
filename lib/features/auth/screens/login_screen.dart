import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/utils.dart';
import '../providers/auth_notifier.dart';
import '../../../../widgets/app_common_background.dart';
import '../../../../core/routing/router_provider.dart';
import '../../../../services/app_session_service.dart';
import '../../../../services/firebase_phone_auth_service.dart';
import '../../../../widgets/app_input_field_style.dart';
import '../widgets/country_picker_sheet.dart';
import 'register2/providers/dynamic_register_notifier.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileController = TextEditingController();

  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final mobileFocusNode = FocusNode();

  bool _passwordVisible = true;
  String? usernameError;
  String? passwordError;

  int _selectedTabIndex = 0; // 0 for Email, 1 for Phone
  String countryCode = "+91";
  String selectedFlag = "🇮🇳";
  late final List<Country> countryList;
  String? _mobileError;
  bool _isSendingOtp = false;

  @override
  void initState() {
    super.initState();
    final config = ref.read(appConfigProvider);
    countryCode = config.defaultCountryCode;
    selectedFlag = config.defaultCountryFlag;
    usernameController.addListener(_onUsernameChanged);
    passwordController.addListener(_onPasswordChanged);
    usernameFocusNode.addListener(_onFocusChanged);
    passwordFocusNode.addListener(_onFocusChanged);
    mobileFocusNode.addListener(_onFocusChanged);
    _initCountryList();
  }

  void _onFocusChanged() {
    if (mounted) setState(() {});
  }

  void _initCountryList() {
    final config = ref.read(appConfigProvider);
    final priorityCodes = [
      config.defaultCountryIso,
      'IN',
      'US',
      'CA',
      'GB',
      'AU',
      'NZ',
    ];
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
        .where(
          (c) => !priorityCodes.any(
            (pc) => pc.toUpperCase() == c.code.toUpperCase(),
          ),
        )
        .toList();
    otherList.sort((a, b) => a.name.compareTo(b.name));
    countryList = [...priorityList, ...otherList];
  }

  void _onUsernameChanged() {
    if (usernameError != null) {
      setState(() {
        usernameError = null;
      });
    }
  }

  void _onPasswordChanged() {
    if (passwordError != null) {
      setState(() {
        passwordError = null;
      });
    }
  }

  @override
  void dispose() {
    usernameController.removeListener(_onUsernameChanged);
    passwordController.removeListener(_onPasswordChanged);
    usernameFocusNode.removeListener(_onFocusChanged);
    passwordFocusNode.removeListener(_onFocusChanged);
    mobileFocusNode.removeListener(_onFocusChanged);
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    mobileFocusNode.dispose();
    usernameController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  void _showCountryPicker(bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDarkMode ? const Color(0xFF161726) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return CountryPickerSheet(
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
    final mobile = mobileController.text.trim();
    if (mobile.isEmpty) {
      setState(() => _mobileError = 'please_enter_mobile_number'.tr);
      return;
    }
    setState(() {
      _mobileError = null;
      _isSendingOtp = true;
    });

    hideKeyboard(context);
    final result = await ref
        .read(authProvider.notifier)
        .loginWithOtp(mobile, countryCode);

    if (result != null && result['status'] == 'success') {
      final otpMethod =
          AppSessionService.getValue('otp_login_method') ?? 'firebase';

      if (otpMethod == 'firebase') {
        final fullPhoneNumber = '$countryCode$mobile';
        await FirebasePhoneAuthService.sendOtp(
          phoneNumber: fullPhoneNumber,
          onCodeSent: (verificationId, resendToken) {
            if (mounted) setState(() => _isSendingOtp = false);
            if (!mounted) return;
            context.push(
              '/verify-otp',
              extra: {
                'mobile': mobile,
                'countryCode': countryCode,
                'verificationId': verificationId,
                'resendToken': resendToken,
              },
            );
          },
          onVerificationCompleted: (credential) {
            if (mounted) setState(() => _isSendingOtp = false);
          },
          onVerificationFailed: (exception) {
            if (mounted) setState(() => _isSendingOtp = false);
            showToast(exception.message ?? 'firebase_verification_failed'.tr);
          },
          onCodeAutoRetrievalTimeout: (verificationId) {
            if (mounted) setState(() => _isSendingOtp = false);
          },
        );
      } else {
        if (mounted) setState(() => _isSendingOtp = false);
        if (!mounted) return;
        context.push(
          '/verify-otp',
          extra: {
            'mobile': mobile,
            'countryCode': countryCode,
          },
        );
      }
    } else {
      if (mounted) setState(() => _isSendingOtp = false);
      if (result != null) {
        showToast(result['message']?.toString() ?? 'failed_to_send_otp'.tr);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final config = ref.watch(appConfigProvider);
    final enablePassword = ref.watch(featureProvider('enablePasswordLogin'));
    final enableOtp = ref.watch(featureProvider('enableOtpLogin'));
    final hasBothTabs = enablePassword && enableOtp;
    final int effectiveTabIndex;
    if (!enablePassword && enableOtp) {
      effectiveTabIndex = 1;
    } else if (enablePassword && !enableOtp) {
      effectiveTabIndex = 0;
    } else {
      effectiveTabIndex = _selectedTabIndex;
    }

    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        data: (response) {
          if (response?.status == "success") {
            final registerStepStr = AppSessionService.getValue('registerStep');
            final step = int.tryParse(registerStepStr?.toString() ?? '9') ?? 9;
            context.go(getRouteForRegisterStep(step));
          }
        },
        error: (error, stack) {
          final msg = error.toString().replaceFirst('Exception: ', '');
          showToast(msg);
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: AppAuthBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Top Header Section (Dark Purple) ─────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sign in badge pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.favorite_rounded,
                            color: config.primaryColor,
                            size: 12,
                          ),
                          const Gap(6),
                          Text(
                            effectiveTabIndex == 0
                                ? 'sign_in_with_email_caps'.tr
                                : 'sign_in_with_phone_caps'.tr,
                            style: AppFont.font(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: config.secondaryColor,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Gap(12),

                    // Title: Sign in to continue
                    RichText(
                      text: TextSpan(
                        style: AppFont.font(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.2,
                        ),
                        children: [
                          TextSpan(text: 'sign_in_to'.tr),
                          TextSpan(
                            text: 'continue_lbl'.tr,
                            style: AppFont.font(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: config.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Gap(6),

                    Text(
                      'login_subtitle'.tr,
                      style: AppFont.font(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),

                    const Gap(16),
                  ],
                ),
              ),

              // ── Bottom Panel Section (Light Cream Panel) ──────────────────
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color(0xFF161726)
                        : config.scaffoldBgColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    ),
                    boxShadow: [
                      const BoxShadow(
                        color: Color(0x1F000000),
                        blurRadius: 30,
                        offset: Offset(0, -10),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 28,
                    ),
                    child: Column(
                      children: [
                        // Tab Selector: Email vs Phone (only shown when both login options are enabled)
                        if (hasBothTabs) ...[
                          Container(
                            height: 52,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1EBE7),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Row(
                              children: [
                                // Tab 0: Email
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => _selectedTabIndex = 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: effectiveTabIndex == 0
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(22),
                                        boxShadow: effectiveTabIndex == 0
                                            ? [
                                          BoxShadow(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.06),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ]
                                            : null,
                                      ),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.email_outlined,
                                            size: 18,
                                            color: effectiveTabIndex == 0
                                                ? const Color(0xFF16182F)
                                                : const Color(0xFF8A90A6),
                                          ),
                                          const Gap(8),
                                          Flexible(
                                            child: Text(
                                              'email_matri_id_tab'.tr,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  AppFont.font(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        effectiveTabIndex == 0
                                                        ? const Color(
                                                            0xFF16182F,
                                                          )
                                                        : const Color(
                                                            0xFF8A90A6,
                                                          ),
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Tab 1: Phone
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => _selectedTabIndex = 1),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: effectiveTabIndex == 1
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(22),
                                        boxShadow: effectiveTabIndex == 1
                                            ? [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.06),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ]
                                            : null,
                                      ),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.smartphone_rounded,
                                            size: 18,
                                            color: effectiveTabIndex == 1
                                                ? const Color(0xFF16182F)
                                                : const Color(0xFF8A90A6),
                                          ),
                                          const Gap(8),
                                          Text(
                                            'phone_lbl'.tr,
                                            style: AppFont.font(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: effectiveTabIndex == 1
                                                  ? const Color(0xFF16182F)
                                                  : const Color(0xFF8A90A6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(24),
                        ],

                        // Tab Content
                        if (effectiveTabIndex == 0) ...[
                          // EMAIL FORM
                          Form(
                            key: _loginFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'email_address_caps'.tr,
                                  style: AppFont.font(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                    color: isDarkMode
                                        ? const Color(0xFF9AA0B8)
                                        : const Color(0xFF8A90A6),
                                  ),
                                ),
                                const Gap(8),
                                Container(
                                  decoration:
                                      AppInputFieldStyle.buildContainerDecoration(
                                        context: context,
                                        config: config,
                                        isFocused: usernameFocusNode.hasFocus,
                                        hasError: usernameError != null,
                                      ),
                                  child: TextFormField(
                                    controller: usernameController,
                                    focusNode: usernameFocusNode,
                                    cursorColor: config.primaryColor,
                                    style: AppFont.font(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: isDarkMode
                                          ? Colors.white
                                          : const Color(0xFF16182F),
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 18,
                                          ),
                                      hintText: 'email_hint'.tr,
                                      hintStyle: AppFont.font(
                                        fontSize: 15,
                                        color: isDarkMode
                                            ? Colors.white.withValues(alpha: 0.35)
                                            : const Color(
                                              0xFF8A90A6,
                                            ).withValues(alpha: 0.6),
                                      ),
                                    ),
                                  ),
                                ),
                                if (usernameError != null) ...[
                                  const Gap(6),
                                  Text(
                                    usernameError!,
                                    style: AppFont.font(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],

                                const Gap(16),

                                Text(
                                  'password_caps'.tr,
                                  style: AppFont.font(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                    color: isDarkMode
                                        ? const Color(0xFF9AA0B8)
                                        : const Color(0xFF8A90A6),
                                  ),
                                ),
                                const Gap(8),
                                Container(
                                  decoration:
                                      AppInputFieldStyle.buildContainerDecoration(
                                        context: context,
                                        config: config,
                                        isFocused: passwordFocusNode.hasFocus,
                                        hasError: passwordError != null,
                                      ),
                                  child: TextFormField(
                                    controller: passwordController,
                                    focusNode: passwordFocusNode,
                                    obscureText: _passwordVisible,
                                    cursorColor: config.primaryColor,
                                    style: AppFont.font(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: isDarkMode
                                          ? Colors.white
                                          : const Color(0xFF16182F),
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                        20,
                                        18,
                                        0,
                                        18,
                                      ),
                                      hintText: 'password_hint'.tr,
                                      hintStyle: AppFont.font(
                                        fontSize: 15,
                                        color: isDarkMode
                                            ? Colors.white.withValues(alpha: 0.35)
                                            : const Color(
                                              0xFF8A90A6,
                                            ).withValues(alpha: 0.6),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          size: 20,
                                          color: isDarkMode
                                              ? Colors.white70
                                              : const Color(0xFF8A90A6),
                                        ),
                                        onPressed: () => setState(
                                          () => _passwordVisible =
                                              !_passwordVisible,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (passwordError != null) ...[
                                  const Gap(6),
                                  Text(
                                    passwordError!,
                                    style: AppFont.font(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],

                                const Gap(12),

                                // Forgot Password Link
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () =>
                                        context.push('/forgot-password'),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(0, 24),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'forgot_question'.tr,
                                      style: AppFont.font(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFEA5575),
                                      ),
                                    ),
                                  ),
                                ),

                                const Gap(24),

                                // Sign In Securely Button
                                authState.maybeWhen(
                                  loading: () => Container(
                                    width: double.infinity,
                                    height: 58,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(config.buttonRadius),
                                      color: config.primaryColor.withValues(
                                        alpha: 0.4,
                                      ),
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  orElse: () => Container(
                                    width: double.infinity,
                                    height: 58,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          config.gradientStart,
                                          config.gradientEnd,
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(config.buttonRadius),
                                      boxShadow: [
                                        BoxShadow(
                                          color: config.primaryColor.withValues(
                                            alpha: 0.4,
                                          ),
                                          blurRadius: 16,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(config.buttonRadius),
                                        onTap: () {
                                          final passwordText =
                                              passwordController.text;
                                          setState(() {
                                            usernameError =
                                                isNullFromBlankString(
                                                  usernameController.text,
                                                )
                                                ? 'empty_username_error'.tr
                                                : null;
                                            if (isNullFromBlankString(
                                              passwordText,
                                            )) {
                                              passwordError =
                                                  'empty_password_error'.tr;
                                            } else if (passwordText.length <
                                                6) {
                                              passwordError =
                                                  'password_length_error'.tr;
                                            } else {
                                              passwordError = null;
                                            }
                                          });

                                          if (usernameError == null &&
                                              passwordError == null) {
                                            hideKeyboard(context);
                                            ref
                                                .read(authProvider.notifier)
                                                .login(
                                                  usernameController.text
                                                      .trim(),
                                                  passwordController.text
                                                      .trim(),
                                                );
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'sign_in_securely'.tr,
                                                textAlign: TextAlign.center,
                                                style:
                                                    AppFont.font(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              margin: const EdgeInsets.only(
                                                right: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withValues(
                                                  alpha: 0.25,
                                                ),
                                                borderRadius: BorderRadius.circular(
                                                  config.isButtonSquare
                                                      ? 4.0
                                                      : (config.isButtonRounded ? 8.0 : 20.0),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.arrow_forward_rounded,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          // PHONE FORM
                          Form(
                            key: _phoneFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'mobile_number_caps'.tr,
                                  style: AppFont.font(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                    color: isDarkMode
                                        ? const Color(0xFF9AA0B8)
                                        : const Color(0xFF8A90A6),
                                  ),
                                ),
                                const Gap(8),
                                Container(
                                  decoration:
                                      AppInputFieldStyle.buildContainerDecoration(
                                        context: context,
                                        config: config,
                                        isFocused: mobileFocusNode.hasFocus,
                                        hasError: _mobileError != null,
                                      ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            _showCountryPicker(isDarkMode),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                            AppInputFieldStyle.getBorderRadius(
                                              config,
                                            ).topLeft.x,
                                          ),
                                          bottomLeft: Radius.circular(
                                            AppInputFieldStyle.getBorderRadius(
                                              config,
                                            ).bottomLeft.x,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 16,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                selectedFlag,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const Gap(6),
                                              Text(
                                                countryCode,
                                                style:
                                                    AppFont.font(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: isDarkMode
                                                          ? Colors.white
                                                          : const Color(
                                                            0xFF16182F,
                                                          ),
                                                    ),
                                              ),
                                              const Gap(4),
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: isDarkMode
                                                    ? Colors.white70
                                                    : const Color(0xFF8A90A6),
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 24,
                                        width: 1,
                                        color: isDarkMode
                                            ? Colors.white24
                                            : const Color(0xFFE2E8F0),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: mobileController,
                                          focusNode: mobileFocusNode,
                                          keyboardType: TextInputType.phone,
                                          cursorColor: config.primaryColor,
                                          onChanged: (_) {
                                            if (_mobileError != null) {
                                              setState(
                                                () => _mobileError = null,
                                              );
                                            }
                                          },
                                          style: AppFont.font(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: isDarkMode
                                                ? Colors.white
                                                : const Color(0xFF16182F),
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 14,
                                                  vertical: 18,
                                                ),
                                            hintText: 'mobile_number_hint'.tr,
                                            hintStyle:
                                                AppFont.font(
                                                  fontSize: 15,
                                                  color: isDarkMode
                                                      ? Colors.white.withValues(alpha: 0.35)
                                                      : const Color(
                                                        0xFF8A90A6,
                                                      ).withValues(alpha: 0.6),
                                                ),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 14),
                                        child: Icon(
                                          Icons.check_circle_rounded,
                                          color: Color(0xFF2E7D32),
                                          size: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (_mobileError != null) ...[
                                  const Gap(6),
                                  Text(
                                    _mobileError!,
                                    style: AppFont.font(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],

                                const Gap(16),

                                // Encrypted badge
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEDF7ED),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: const Color(0xFFA5D6A7),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.verified_user_rounded,
                                        color: Color(0xFF2E7D32),
                                        size: 16,
                                      ),
                                      const Gap(8),
                                      Text(
                                        'encrypted_notice'.tr,
                                        style: AppFont.font(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF1B5E20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Gap(24),

                                // Send Verification Code Button
                                _isSendingOtp
                                    ? Container(
                                        width: double.infinity,
                                        height: 58,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            85,
                                          ),
                                          color: config.primaryColor.withValues(
                                            alpha: 0.4,
                                          ),
                                        ),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: double.infinity,
                                        height: 58,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              config.gradientStart,
                                              config.gradientEnd,
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            85,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: config.primaryColor
                                                  .withValues(alpha: 0.4),
                                              blurRadius: 16,
                                              offset: const Offset(0, 6),
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(
                                              85,
                                            ),
                                            onTap: _submitMobile,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'send_verification_code'.tr,
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        AppFont.font(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  margin: const EdgeInsets.only(
                                                    right: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withValues(
                                                          alpha: 0.25,
                                                        ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.send_rounded,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],

                        const Gap(24),

                        // OR Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: isDarkMode
                                    ? Colors.white12
                                    : const Color(0xFFE2E8F0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              child: Text(
                                'or'.tr,
                                style: AppFont.font(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? Colors.white54
                                      : const Color(0xFF8A90A6),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: isDarkMode
                                    ? Colors.white12
                                    : const Color(0xFFE2E8F0),
                              ),
                            ),
                          ],
                        ),

                        const Gap(24),

                        // Create Account Footer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'new_here_q'.tr,
                              style: AppFont.font(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ref
                                    .read(dynamicRegisterProvider.notifier)
                                    .resetRegistration();
                                context.push('/register');
                              },
                              child: Text(
                                'create_account'.tr,
                                style: AppFont.font(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: config.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
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
}
