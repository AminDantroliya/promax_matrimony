import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart' as m_ui;
import 'package:pinput/pinput.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/features/auth/providers/register_notifier.dart';
import 'package:pro_matrimony/features/common/providers/dropdown_notifier.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_button.dart';
import 'package:pro_matrimony/widgets/app_single_select_dropdown.dart';
import 'package:pro_matrimony/widgets/app_text_field.dart';

class AadhaarVerificationScreen extends ConsumerStatefulWidget {
  const AadhaarVerificationScreen({super.key});

  @override
  ConsumerState<AadhaarVerificationScreen> createState() => _AadhaarVerificationScreenState();
}

class _AadhaarVerificationScreenState extends ConsumerState<AadhaarVerificationScreen> {
  final _aadharVerifyFormKey = GlobalKey<FormState>();
  final _panVerifyFormKey = GlobalKey<FormState>();
  final _voterIdVerifyFormKey = GlobalKey<FormState>();

  String selectedDocTypeId = "";

  // aadhaar card
  final aadharNumberController = TextEditingController();
  final aadharOtpController = TextEditingController();
  bool isAadhaarOtpSent = false;

  // PAN card
  final panNumberController = TextEditingController();
  final panNameController = TextEditingController();

  // Voter ID card
  final voterIdNumberController = TextEditingController();
  final voterIdNameController = TextEditingController();

  @override
  void dispose() {
    aadharNumberController.dispose();
    aadharOtpController.dispose();
    panNumberController.dispose();
    panNameController.dispose();
    voterIdNumberController.dispose();
    voterIdNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final dropdownsAsync = ref.watch(allDropdownsProvider);
    final registerState = ref.watch(registerProvider);

    const borderColor = Colors.black38;

    final defaultPinTheme = PinTheme(
      width: getProportionateScreenWidth(45),
      height: getProportionateScreenWidth(45),
      textStyle: TextStyle(
        fontSize: getProportionateScreenWidth(22),
        color: isDarkMode ? Colors.white : const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),
        border: Border.all(color: isDarkMode ? Colors.white24 : borderColor),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(8)),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: isDarkMode ? Colors.white12 : Colors.grey.shade200),
              borderRadius: BorderRadius.circular(getProportionateScreenWidth(50)),
            ),
            child: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: getProportionateScreenWidth(18),
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: customTextBoldStyle(
          'id_proof_screen_title'.tr,
          getProportionateScreenWidth(16),
          TextAlign.center,
          Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: SafeArea(
        child: dropdownsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("${'failed_to_load_options'.tr}: $err")),
          data: (dropdownData) {
            final docTypeList = dropdownData?.documentType ?? [];
            return Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(getProportionateScreenWidth(20)),
                    customTextBoldStyle(
                      'id_proof_message'.tr,
                      getProportionateScreenWidth(20),
                      TextAlign.center,
                      Theme.of(context).colorScheme.onSurface,
                    ),
                    customTextNormalStyle(
                      'id_proof_sub_message'.tr,
                      getProportionateScreenWidth(14),
                      TextAlign.center,
                      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    Gap(getProportionateScreenWidth(30)),
                    AppSingleSelectDropdown(
                      hintText: 'document_type'.tr,
                      items: docTypeList,
                      onChanged: (v) {
                        setState(() {
                          selectedDocTypeId = v!.val.toString();
                          aadharNumberController.clear();
                          aadharOtpController.clear();
                          isAadhaarOtpSent = false;
                          panNumberController.clear();
                          panNameController.clear();
                          voterIdNumberController.clear();
                          voterIdNameController.clear();
                        });
                      },
                    ),
                    Gap(getProportionateScreenWidth(30)),
                    if (selectedDocTypeId == "Aadhaar Card") _aadhaarForm(defaultPinTheme, registerState),
                    if (selectedDocTypeId == "PAN Card") _panForm(registerState),
                    if (selectedDocTypeId == "Voter Id") _voterIdForm(registerState),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _aadhaarForm(PinTheme defaultPinTheme, RegisterState state) {
    return Form(
      key: _aadharVerifyFormKey,
      child: Column(
        children: [
          AppTextField(
            labelText: 'aadhaar_number'.tr,
            controller: aadharNumberController,
            keyboardType: TextInputType.number,
            maxLength: 12,
            validator: (value) {
              if (isNullFromBlankString(value)) return 'empty_aadhaar_number_error'.tr;
              if (value!.length < 12) return 'invalid_aadhaar_number_error'.tr;
              return null;
            },
          ),
          Gap(getProportionateScreenWidth(20)),
          if (isAadhaarOtpSent)
            Localizations.override(
              context: context,
              delegates: const [
                m_ui.DefaultMaterialLocalizations.delegate,
              ],
              child: m_ui.Material(
                type: m_ui.MaterialType.transparency,
                child: Pinput(
                  length: 6,
                  controller: aadharOtpController,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) =>
                      SizedBox(width: getProportionateScreenWidth(5)),
                  validator: (value) {
                    if (value!.isEmpty) return 'empty_field_error'.tr;
                    if (value.length != 6) return 'invalid_otp_error'.tr;
                    return null;
                  },
                  onCompleted: (pin) => _verifyAadhaarOtp(),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: appPrimaryColor),
                    ),
                  ),
                ),
              ),
            ),
          Gap(getProportionateScreenWidth(20)),
          if (state.isLoading)
            const CircularProgressIndicator()
          else
            AppPrimaryButton(label: isAadhaarOtpSent ? 'btn_verify_otp'.tr : 'generate_otp'.tr, onPressed: isAadhaarOtpSent ? _verifyAadhaarOtp : _generateAadhaarOtp,
            ),
        ],
      ),
    );
  }

  Widget _panForm(RegisterState state) {
    return Form(
      key: _panVerifyFormKey,
      child: Column(
        children: [
          AppTextField(
            labelText: 'pan_name'.tr,
            controller: panNameController,
            validator: (value) => isNullFromBlankString(value) ? 'empty_name_error'.tr : null,
          ),
          Gap(getProportionateScreenWidth(15)),
          AppTextField(
            labelText: 'pan_number'.tr,
            controller: panNumberController,
            maxLength: 10,
            validator: (value) {
              if (isNullFromBlankString(value)) return 'empty_pan_number_error'.tr;
              if (value!.length < 10) return 'invalid_pan_number_error'.tr;
              return null;
            },
          ),
          Gap(getProportionateScreenWidth(20)),
          if (state.isLoading)
            const CircularProgressIndicator()
          else
            AppPrimaryButton(label: 'btn_verify_pan'.tr, onPressed: _verifyPan,
            ),
        ],
      ),
    );
  }

  Widget _voterIdForm(RegisterState state) {
    return Form(
      key: _voterIdVerifyFormKey,
      child: Column(
        children: [
          AppTextField(
            labelText: 'voter_id_name'.tr,
            controller: voterIdNameController,
            validator: (value) => isNullFromBlankString(value) ? 'empty_name_error'.tr : null,
          ),
          Gap(getProportionateScreenWidth(15)),
          AppTextField(
            labelText: 'voter_id_number'.tr,
            controller: voterIdNumberController,
            validator: (value) => isNullFromBlankString(value) ? 'empty_voter_id_number_error'.tr : null,
          ),
          Gap(getProportionateScreenWidth(20)),
          if (state.isLoading)
            const CircularProgressIndicator()
          else
            AppPrimaryButton(label: 'btn_verify_voter_id'.tr, onPressed: _verifyVoterId,
            ),
        ],
      ),
    );
  }

  void _generateAadhaarOtp() async {
    if (!_aadharVerifyFormKey.currentState!.validate()) return;
    hideKeyboard(context);
    final params = {"aadhar_number": aadharNumberController.text.trim()};
    final success = await ref.read(registerProvider.notifier).generateAadhaarOtp(params);
    if (success) setState(() => isAadhaarOtpSent = true);
  }

  void _verifyAadhaarOtp() async {
    if (!_aadharVerifyFormKey.currentState!.validate()) return;
    hideKeyboard(context);
    final params = {
      "reference_id": ref.read(registerProvider).referenceId,
      "aadhar_number": aadharNumberController.text.trim(),
      "otp": aadharOtpController.text.trim(),
    };
    final success = await ref.read(registerProvider.notifier).verifyAadhaarOtp(params);
    if (!mounted) return;
    if (success) context.pop();
  }

  void _verifyPan() async {
    if (!_panVerifyFormKey.currentState!.validate()) return;
    hideKeyboard(context);
    final params = {
      "pan_name": panNameController.text.trim(),
      "pan_number": panNumberController.text.trim(),
    };
    final success = await ref.read(registerProvider.notifier).verifyPan(params);
    if (!mounted) return;
    if (success) context.pop();
  }

  void _verifyVoterId() async {
    if (!_voterIdVerifyFormKey.currentState!.validate()) return;
    hideKeyboard(context);
    final params = {
      "voter_id_name": voterIdNameController.text.trim(),
      "voter_id_number": voterIdNumberController.text.trim(),
    };
    final success = await ref.read(registerProvider.notifier).verifyVoterId(params);
    if (!mounted) return;
    if (success) context.pop();
  }
}
