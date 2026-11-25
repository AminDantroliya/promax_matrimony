import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_ui/material_ui.dart' as m_ui;
import 'package:pinput/pinput.dart';
import 'package:pro_matrimony/utils/application_data.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_button.dart';
import 'package:pro_matrimony/widgets/app_single_select_dropdown.dart';
import 'package:pro_matrimony/widgets/app_text_field.dart';

import '../providers/verification_notifier.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key});

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedDocType = "";
  
  final _aadhaarController = TextEditingController();
  final _otpController = TextEditingController();
  final _panNameController = TextEditingController();
  final _panNumberController = TextEditingController();
  final _voterNameController = TextEditingController();
  final _voterNumberController = TextEditingController();

  @override
  void dispose() {
    _aadhaarController.dispose();
    _otpController.dispose();
    _panNameController.dispose();
    _panNumberController.dispose();
    _voterNameController.dispose();
    _voterNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(verificationProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final docTypes = ApplicationData().getDropdownResponseModel?.data?.documentType ?? [];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: customTextBoldStyle('id_proof_screen_title'.tr, 18, TextAlign.center, Theme.of(context).colorScheme.onSurface),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              customTextBoldStyle('id_proof_message'.tr, 20, TextAlign.center, Theme.of(context).colorScheme.onSurface),
              const Gap(10),
              customTextNormalStyle('id_proof_sub_message'.tr, 14, TextAlign.center, Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
              const Gap(30),
              AppSingleSelectDropdown(
                hintText: 'document_type'.tr,
                items: docTypes,
                onChanged: (v) {
                  setState(() {
                    _selectedDocType = v?.id.toString() ?? "";
                  });
                },
              ),
              const Gap(30),
              if (_selectedDocType == "Aadhaar Card") _buildAadhaarForm(state, isDark),
              if (_selectedDocType == "PAN Card") _buildPanForm(state),
              if (_selectedDocType == "Voter Id") _buildVoterIdForm(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAadhaarForm(dynamic state, bool isDark) {
    return Column(
      children: [
        AppTextField(
          labelText: 'aadhaar_number'.tr,
          controller: _aadhaarController,
          keyboardType: TextInputType.number,
          maxLength: 12,
          validator: (v) => (v == null || v.length < 12) ? 'invalid_aadhaar_number_error'.tr : null,
        ),
        const Gap(20),
        if (state.isOtpSent) ...[
          Localizations.override(
            context: context,
            delegates: const [
              m_ui.DefaultMaterialLocalizations.delegate,
            ],
            child: m_ui.Material(
              type: m_ui.MaterialType.transparency,
              child: Pinput(
                length: 6,
                controller: _otpController,
                onCompleted: (pin) => _handleAadhaarVerify(),
              ),
            ),
          ),
          const Gap(20),
          AppPrimaryButton(label: 'btn_verify_otp'.tr, onPressed: _handleAadhaarVerify),
        ] else
          AppPrimaryButton(label: 'generate_otp'.tr, onPressed: _handleAadhaarGenerate),
      ],
    );
  }

  Widget _buildPanForm(dynamic state) {
    return Column(
      children: [
        AppTextField(
          labelText: 'pan_name'.tr,
          controller: _panNameController,
          validator: (v) => (v == null || v.isEmpty) ? 'empty_name_error'.tr : null,
        ),
        const Gap(15),
        AppTextField(
          labelText: 'pan_number'.tr,
          controller: _panNumberController,
          maxLength: 10,
          validator: (v) => (v == null || v.length < 10) ? 'invalid_pan_number_error'.tr : null,
        ),
        const Gap(20),
        AppPrimaryButton(label: 'btn_verify_pan'.tr, onPressed: _handlePanVerify),
      ],
    );
  }

  Widget _buildVoterIdForm(dynamic state) {
    return Column(
      children: [
        AppTextField(
          labelText: 'voter_id_name'.tr,
          controller: _voterNameController,
          validator: (v) => (v == null || v.isEmpty) ? 'empty_name_error'.tr : null,
        ),
        const Gap(15),
        AppTextField(
          labelText: 'voter_id_number'.tr,
          controller: _voterNumberController,
          validator: (v) => (v == null || v.isEmpty) ? 'empty_voter_id_number_error'.tr : null,
        ),
        const Gap(20),
        AppPrimaryButton(label: 'btn_verify_voter_id'.tr, onPressed: _handleVoterVerify),
      ],
    );
  }

  void _handleAadhaarGenerate() async {
    if (_formKey.currentState!.validate()) {
      showLoading(context);
      final success = await ref.read(verificationProvider.notifier).generateAadhaarOtp(_aadhaarController.text);
      hideLoading();
      if (!success) {
        final err = ref.read(verificationProvider).error;
        showToast(err.toString());
      }
    }
  }

  void _handleAadhaarVerify() async {
    showLoading(context);
    final success = await ref.read(verificationProvider.notifier).verifyAadhaarOtp(_aadhaarController.text, _otpController.text);
    hideLoading();
    if (!mounted) return;
    if (success) {
      Navigator.pop(context);
      showToast('verification_successful'.tr);
    }
  }

  void _handlePanVerify() async {
    if (_formKey.currentState!.validate()) {
      showLoading(context);
      final success = await ref.read(verificationProvider.notifier).verifyPan(_panNameController.text, _panNumberController.text);
      hideLoading();
      if (!mounted) return;
      if (success) Navigator.pop(context);
    }
  }

  void _handleVoterVerify() async {
    if (_formKey.currentState!.validate()) {
      showLoading(context);
      final success = await ref.read(verificationProvider.notifier).verifyVoterId(_voterNameController.text, _voterNumberController.text);
      hideLoading();
      if (!mounted) return;
      if (success) Navigator.pop(context);
    }
  }
}
