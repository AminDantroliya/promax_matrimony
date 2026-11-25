import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/features/auth/screens/register2/models/dynamic_form_models.dart';
import 'package:pro_matrimony/features/common/data/models/dropdown_models.dart';
import 'package:pro_matrimony/features/common/providers/dropdown_notifier.dart';
import 'package:pro_matrimony/features/profile/data/models/profile_models.dart';
import 'package:pro_matrimony/utils/sibling_dropdown_helper.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import '../models/dynamic_edit_section_config.dart';
import '../providers/dynamic_edit_profile_notifier.dart';
import '../widgets/dynamic_edit_form_fields.dart';

/// Single dynamic screen for all Edit Profile and Partner Preference sections
class DynamicEditProfileScreen extends ConsumerStatefulWidget {
  final String sectionKey;
  final ProfileData profileData;

  const DynamicEditProfileScreen({
    super.key,
    required this.sectionKey,
    required this.profileData,
  });

  @override
  ConsumerState<DynamicEditProfileScreen> createState() =>
      _DynamicEditProfileScreenState();
}

class _DynamicEditProfileScreenState
    extends ConsumerState<DynamicEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final DynamicEditSectionType _sectionType;

  @override
  void initState() {
    super.initState();
    _sectionType = DynamicEditSectionType.fromKey(widget.sectionKey);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dynamicEditProfileProvider.notifier).initialize(
            profileData: widget.profileData,
            sectionType: _sectionType,
          );
    });
  }

  List<DropdownOptionModel> _resolveDropdownOptions(
    FormFieldModel field,
    DropdownData? dropdownData,
    Map<String, List<DropdownOptionModel>> dependentOptions, {
    Map<String, dynamic>? formValues,
  }) {
    if (field.type == 'dependent_dropdown' || field.parentField != null) {
      final cached = dependentOptions[field.name];
      if (cached != null) return cached;
    }

    if (field.options != null && field.options!.isNotEmpty) {
      return field.options!
          .map((o) => DropdownOptionModel(id: o.id, val: o.label))
          .toList();
    }

    if (dropdownData == null) return const [];

    List<DropdownOptionModel> matchKey(String key) {
      final k = key.toLowerCase().replaceAll('_', '').replaceAll('-', '').trim();
      switch (k) {
        case 'profileby':
        case 'profilebylist':
        case 'profilecreatedfor':
        case 'profilecreatedforlist':
          return dropdownData.profileby ?? const [];

        case 'maritalstatus':
        case 'maritalstatuslist':
        case 'partmaritalstatus':
          return dropdownData.maritalStatus ?? const [];

        case 'totalchildren':
        case 'totalchildrenlist':
          return dropdownData.totalChildren ?? const [];

        case 'statuschildren':
        case 'statuschildrenlist':
          return dropdownData.statusChildren ?? const [];

        case 'mothertongue':
        case 'mothertonguelist':
        case 'partmothertongue':
          return dropdownData.mothertongueList ?? const [];

        case 'height':
        case 'heightlist':
        case 'partheight':
        case 'partheightto':
          return dropdownData.heightList ?? const [];

        case 'weight':
        case 'weightlist':
          return dropdownData.weightList ?? const [];

        case 'residence':
        case 'residencetype':
        case 'residencetypelist':
        case 'residencemasterlist':
          return dropdownData.residence ?? const [];

        case 'religion':
        case 'religionid':
        case 'religionlist':
        case 'partreligion':
          return dropdownData.religionList ?? const [];

        case 'manglik':
        case 'mangliklist':
        case 'partmanglik':
          return dropdownData.manglik ?? const [];

        case 'star':
        case 'starlist':
        case 'partstar':
          return dropdownData.starList ?? const [];

        case 'moongsign':
        case 'moongsignlist':
        case 'moonsign':
        case 'moonsignlist':
          return dropdownData.moonsignList ?? const [];

        case 'horoscope':
        case 'horoscopelist':
          return dropdownData.horoscope ?? const [];

        case 'country':
        case 'countryid':
        case 'countrylist':
        case 'nricountry':
        case 'partcountry':
          return dropdownData.countryList ?? const [];

        case 'state':
        case 'stateid':
        case 'statelist':
        case 'partstate':
          return dependentOptions['state_id'] ??
              dependentOptions['part_state'] ??
              dependentOptions['state'] ??
              const [];

        case 'city':
        case 'cityid':
        case 'citylist':
        case 'citymasterlist':
        case 'partcity':
          return dependentOptions['city'] ?? dropdownData.cityList ?? const [];

        case 'education':
        case 'educationid':
        case 'educationlevel':
        case 'educationlist':
        case 'educationmasterlist':
        case 'parteducation':
          return dropdownData.educationMasterList ?? const [];

        case 'occupation':
        case 'occupationid':
        case 'occupationlist':
        case 'partoccupation':
        case 'fatheroccupation':
        case 'motheroccupation':
          return dropdownData.occupationList ?? const [];

        case 'employedin':
        case 'employeein':
        case 'employeeinlist':
        case 'employedinlist':
          return dropdownData.employeeIn ?? const [];

        case 'designation':
        case 'designationlevel':
        case 'designationlist':
          return dropdownData.designation ?? const [];

        case 'income':
        case 'incomelist':
        case 'annualincome':
        case 'annualincomelist':
        case 'partincome':
        case 'partincomelist':
          return dropdownData.income ?? dropdownData.partIncome ?? const [];

        case 'diet':
        case 'eatinghabit':
        case 'eatinghabitlist':
        case 'dietlist':
          return dropdownData.diet ?? const [];

        case 'smoke':
        case 'smokinghabit':
        case 'smokinghabitlist':
        case 'smokelist':
          return dropdownData.smoke ?? const [];

        case 'drink':
        case 'drinkinghabit':
        case 'drinkinghabitlist':
        case 'drinklist':
          return dropdownData.drink ?? const [];

        case 'bodytype':
        case 'bodytypelist':
        case 'bodytypeid':
          return dropdownData.bodytype ?? const [];

        case 'bloodgroup':
        case 'bloodgroupid':
        case 'bloodgrouplist':
        case 'partbloodgroup':
          return dropdownData.bloodGroup ?? const [];

        case 'complexion':
        case 'complexionlist':
        case 'skintone':
        case 'skintonelist':
          return dropdownData.skinTone ?? const [];

        case 'familytype':
        case 'familytypelist':
          return dropdownData.familyType ?? const [];

        case 'familystatus':
        case 'familystatuslist':
          return dropdownData.familyStatus ?? const [];

        case 'noofbrother':
        case 'noofbrothers':
        case 'noofsister':
        case 'noofsisters':
        case 'noofbrosislist':
          return SiblingDropdownHelper.sortTotalSiblingOptions(
              dropdownData.noOfBrothers ?? const []);

        case 'noofmarriedbrother':
        case 'noofmarriedbrothers':
        case 'noofmarriedbrotherlist':
          final broVal =
              formValues?['no_of_brother'] ?? formValues?['no_of_brothers'];
          return SiblingDropdownHelper.filterAndSortMarriedOptions(
            options: dropdownData.noMarriBrother ?? const [],
            totalSiblingValue: broVal,
          );

        case 'noofmarriedsister':
        case 'noofmarriedsisters':
        case 'noofmarriedsisterlist':
          final sisVal =
              formValues?['no_of_sister'] ?? formValues?['no_of_sisters'];
          return SiblingDropdownHelper.filterAndSortMarriedOptions(
            options: dropdownData.noMarriSister ?? const [],
            totalSiblingValue: sisVal,
          );

        case 'documenttype':
        case 'documenttypelist':
        case 'idprooftype':
        case 'idprooftypelist':
          return dropdownData.documentType ?? const [];

        case 'gender':
        case 'genderlist':
          return const [
            DropdownOptionModel(id: 'Male', val: 'Male'),
            DropdownOptionModel(id: 'Female', val: 'Female'),
          ];

        default:
          return const [];
      }
    }

    if (field.dropdownSource != null && field.dropdownSource!.isNotEmpty) {
      final opts = matchKey(field.dropdownSource!);
      if (opts.isNotEmpty) return opts;
    }

    return matchKey(field.name);
  }

  Widget _buildFieldWidget(
    FormFieldModel field,
    DynamicEditProfileState editState,
    DropdownData? dropdownData,
    DynamicEditProfileNotifier notifier,
  ) {
    final currentValue = editState.formValues[field.name];

    switch (field.type) {
      case 'single_select_dropdown':
        final options = _resolveDropdownOptions(
          field,
          dropdownData,
          editState.dependentOptions,
          formValues: editState.formValues,
        );

        dynamic safeValue = currentValue;
        if (SiblingDropdownHelper.isMarriedSiblingField(field.name) ||
            field.dropdownSource == 'no_of_married_brother_list' ||
            field.dropdownSource == 'no_of_married_sister_list') {
          final isBrother = field.name.contains('brother') ||
              (field.dropdownSource?.contains('brother') ?? false);
          final parentKey = isBrother ? 'no_of_brother' : 'no_of_sister';
          final altParentKey = isBrother ? 'no_of_brothers' : 'no_of_sisters';
          final totalVal = editState.formValues[parentKey] ??
              editState.formValues[altParentKey];
          if (SiblingDropdownHelper.shouldResetMarriedSibling(
            currentMarriedValue: safeValue,
            newTotalSiblingValue: totalVal,
          )) {
            safeValue = null;
          }
        }

        final isPartnerPref = _sectionType == DynamicEditSectionType.partnerPreference ||
            field.name.toLowerCase().startsWith('part_') ||
            field.name.toLowerCase().startsWith('partner_');

        return DynamicEditSingleDropdown(
          key: ValueKey(field.name),
          field: field,
          items: options,
          selectedValue: safeValue,
          isPartnerPreference: isPartnerPref,
          onChanged: (val) => notifier.updateFieldValue(field.name, val),
        );

      case 'dependent_dropdown':
        final options = _resolveDropdownOptions(
          field,
          dropdownData,
          editState.dependentOptions,
          formValues: editState.formValues,
        );
        final isParentEmpty = field.parentField != null &&
            (editState.formValues[field.parentField] == null ||
                editState.formValues[field.parentField].toString().isEmpty);
        final isPartnerPref = _sectionType == DynamicEditSectionType.partnerPreference ||
            field.name.toLowerCase().startsWith('part_') ||
            field.name.toLowerCase().startsWith('partner_');

        return DynamicEditSingleDropdown(
          key: ValueKey(field.name),
          field: field,
          items: options,
          selectedValue: currentValue,
          isLoading: !isParentEmpty && options.isEmpty,
          isPartnerPreference: isPartnerPref,
          onChanged: (val) => notifier.updateFieldValue(field.name, val),
        );

      case 'multi_select_dropdown':
        final options = _resolveDropdownOptions(
          field,
          dropdownData,
          editState.dependentOptions,
          formValues: editState.formValues,
        );
        final isPartnerPref = _sectionType == DynamicEditSectionType.partnerPreference ||
            field.name.toLowerCase().startsWith('part_') ||
            field.name.toLowerCase().startsWith('partner_');

        return DynamicEditMultiDropdown(
          key: ValueKey(field.name),
          field: field,
          items: options,
          selectedValue: currentValue,
          isPartnerPreference: isPartnerPref,
          onChanged: (val) => notifier.updateFieldValue(field.name, val),
        );

      case 'phone_number':
      case 'phone':
        return DynamicEditPhoneField(
          key: ValueKey(field.name),
          field: field,
          initialValue: currentValue?.toString(),
          onChanged: (val) => notifier.updateFieldValue(field.name, val),
        );

      case 'time_picker':
        return DynamicEditTimePicker(
          key: ValueKey(field.name),
          field: field,
          initialValue: currentValue?.toString(),
          onChanged: (val) => notifier.updateFieldValue(field.name, val),
        );

      case 'range_slider':
        return DynamicEditRangeSlider(
          key: ValueKey(field.name),
          field: field,
          initialValue: currentValue is RangeValues ? currentValue : null,
          onChanged: (val) => notifier.updateFieldValue(field.name, val),
        );

      case 'textarea':
        return DynamicEditTextInput(
          key: ValueKey(field.name),
          field: field,
          initialValue: currentValue?.toString(),
          onChanged: (val) => notifier.updateFieldValue(field.name, val),
        );

      case 'number':
        return DynamicEditTextInput(
          key: ValueKey(field.name),
          field: field,
          initialValue: currentValue?.toString(),
          isNumber: true,
          onChanged: (val) => notifier.updateFieldValue(field.name, val),
        );

      default:
        return DynamicEditTextInput(
          key: ValueKey(field.name),
          field: field,
          initialValue: currentValue?.toString(),
          onChanged: (val) => notifier.updateFieldValue(field.name, val),
        );
    }
  }

  void _submit() {
    ref.read(dynamicEditProfileProvider.notifier).submit(
          context: context,
          sectionType: _sectionType,
          formKey: _formKey,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dropdownAsync = ref.watch(allDropdownsProvider);
    final editState = ref.watch(dynamicEditProfileProvider);
    final notifier = ref.read(dynamicEditProfileProvider.notifier);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppAppBar(
              title: editState.currentSection?.title.isNotEmpty == true
                  ? editState.currentSection!.title
                  : _sectionType.titleKey.tr,
              isShowActions: false,
            ),
            Expanded(
              child: dropdownAsync.when(
                data: (dropdownData) {
                  if (editState.isLoadingSchema) {
                    return const Center(child: AppLoadingWidget());
                  }

                  if (editState.errorMessage != null &&
                      editState.fields.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(editState.errorMessage!),
                          const Gap(12),
                          ElevatedButton(
                            onPressed: () => ref
                                .read(dynamicEditProfileProvider.notifier)
                                .initialize(
                                  profileData: widget.profileData,
                                  sectionType: _sectionType,
                                ),
                            child: Text('retry'.tr),
                          ),
                        ],
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: editState.autoValidate
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          ...editState.fields.map((field) {
                            if (field.showIf != null &&
                                !field.showIf!.isVisible(editState.formValues)) {
                              return const SizedBox.shrink();
                            }
                            return _buildFieldWidget(
                              field,
                              editState,
                              dropdownData,
                              notifier,
                            );
                          }),
                          const Gap(16),
                          if (editState.isSubmitting)
                            const Center(child: CircularProgressIndicator())
                          else
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: AppTheme.getButtonBorderRadius(context),
                                  ),
                                ),
                                child: Text(
                                  'btn_submit'.tr,
                                  style: AppFont.font(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
                loading: () => const Center(child: AppLoadingWidget()),
                error: (e, _) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${'failed_to_load_options'.tr}: $e"),
                      const Gap(12),
                      ElevatedButton(
                        onPressed: () => ref.invalidate(allDropdownsProvider),
                        child: Text('retry'.tr),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
