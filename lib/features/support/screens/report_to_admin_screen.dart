import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/features/common/data/models/dropdown_models.dart';
import 'package:pro_matrimony/features/common/providers/dropdown_notifier.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_button.dart';
import 'package:pro_matrimony/widgets/app_single_select_dropdown.dart';
import 'package:pro_matrimony/widgets/app_text_field.dart';

import '../data/repositories/support_repository.dart';

class ReportToAdminScreen extends ConsumerStatefulWidget {
  final String memberId;
  const ReportToAdminScreen({super.key, required this.memberId});

  @override
  ConsumerState<ReportToAdminScreen> createState() => _ReportToAdminScreenState();
}

class _ReportToAdminScreenState extends ConsumerState<ReportToAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reasonCtrl = TextEditingController();
  DropdownOptionModel? _selectedReportType;

  @override
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedReportType == null) {
      showToast('please_select_report_type'.tr);
      return;
    }
    hideKeyboard(context);
    showLoading(context);

    try {
      final params = {
        'report_member_id': widget.memberId,
        'report_type': _selectedReportType?.id ?? 1,
        'report_reason': _reasonCtrl.text.trim(),
      };
      final result = await ref.read(supportRepositoryProvider).reportToAdmin(params);
      final isSuccess = result['status'] == 'success' || result['code'] == 200;
      hideLoading();
      showToast(result['message']?.toString() ?? '');
      if (isSuccess && mounted) Navigator.pop(context);
    } catch (e) {
      hideLoading();
      showToast('something_went_wrong'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dropdownAsync = ref.watch(allDropdownsProvider);
    final reportTypes = dropdownAsync.value?.reportTypes ?? [];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppAppBar(title: 'report_title'.tr, isShowActions: false),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    customTextBoldStyle('describe_problem'.tr, 18, TextAlign.start, Theme.of(context).colorScheme.onSurface),
                    const Gap(6),
                    customTextNormalStyle('describe_problem_message'.tr, 14, TextAlign.start, Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
                    const Gap(30),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSingleSelectDropdown(
                            hintText: 'report_type'.tr,
                            items: reportTypes,
                            selectedItem: _selectedReportType,
                            onChanged: (val) {
                              setState(() {
                                _selectedReportType = val;
                              });
                            },
                            validator: (v) => v == null ? 'please_select_report_type'.tr : null,
                          ),
                          const Gap(20),
                          AppTextField(
                            labelText: 'feedback'.tr,
                            hint: '',
                            controller: _reasonCtrl,
                            maxLine: 4,
                            validator: (v) => isNullFromBlankString(v) ? 'empty_field_error'.tr : null,
                          ),
                        ],
                      ),
                    ),
                    const Gap(25),
                    AppPrimaryButton(label: 'btn_submit'.tr, onPressed: _submit),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
