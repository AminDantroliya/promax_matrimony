import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/features/common/data/models/dropdown_models.dart';
import 'package:pro_matrimony/features/common/providers/dropdown_notifier.dart';
import '../../../../../config/providers/config_providers.dart';
import '../models/dynamic_form_models.dart';
import '../providers/dynamic_register_notifier.dart';
import 'fields/dynamic_ai_bio_field.dart';
import 'fields/dynamic_checkbox_field.dart';
import 'fields/dynamic_date_picker_field.dart';
import 'fields/dynamic_dropdown_field.dart';
import 'fields/dynamic_id_proof_field.dart';
import 'fields/dynamic_multi_dropdown_field.dart';
import 'fields/dynamic_phone_field.dart';
import 'fields/dynamic_photo_upload_grid.dart';
import 'fields/dynamic_range_slider_field.dart';
import 'fields/dynamic_segment_selector.dart';
import 'fields/dynamic_selfie_field.dart';
import 'fields/dynamic_text_field.dart';
import 'fields/dynamic_time_picker_field.dart';
import 'package:pro_matrimony/utils/sibling_dropdown_helper.dart';

class DynamicSectionRenderer extends ConsumerWidget {
  final FormSection section;

  const DynamicSectionRenderer({
    super.key,
    required this.section,
  });

  List<DropdownOptionModel> _resolveDropdownItems({
    required FormFieldModel field,
    required DropdownData? globalDropdowns,
    required Map<String, List<DropdownOptionModel>> dependentOptions,
  }) {
    // 1. If it's a dependent dropdown, check cached dependent options first
    if (field.type == 'dependent_dropdown' || field.parentField != null) {
      final cached = dependentOptions[field.name];
      if (cached != null && cached.isNotEmpty) return cached;
    }

    // 2. Try resolving from global dropdowns (match by source or field name)
    if (globalDropdowns != null) {
      final source = (field.dropdownSource ?? field.name)
          .toLowerCase()
          .replaceAll('_', '')
          .replaceAll('-', '')
          .trim();

      List<DropdownOptionModel>? list;

      switch (source) {
        // Profile Created For
        case 'profileby':
        case 'profilebylist':
        case 'profilecreatedfor':
        case 'profilecreatedforlist':
          list = globalDropdowns.profileby;
          break;

        // Marital Status
        case 'maritalstatus':
        case 'maritalstatuslist':
        case 'partmaritalstatus':
          list = globalDropdowns.maritalStatus;
          break;

        // Children
        case 'totalchildren':
        case 'totalchildrenlist':
          list = globalDropdowns.totalChildren;
          break;
        case 'statuschildren':
        case 'statuschildrenlist':
          list = globalDropdowns.statusChildren;
          break;

        // Mother Tongue
        case 'mothertongue':
        case 'mothertonguelist':
        case 'partmothertongue':
          list = globalDropdowns.mothertongueList;
          break;

        // Height & Weight
        case 'height':
        case 'heightlist':
        case 'partheight':
        case 'partheightto':
          list = globalDropdowns.heightList;
          break;
        case 'weight':
        case 'weightlist':
          list = globalDropdowns.weightList;
          break;

        // Religion & Astrology
        case 'religion':
        case 'religionid':
        case 'religionlist':
        case 'partreligion':
          list = globalDropdowns.religionList;
          break;
        case 'manglik':
        case 'mangliklist':
        case 'partmanglik':
          list = globalDropdowns.manglik;
          break;
        case 'star':
        case 'starlist':
        case 'partstar':
          list = globalDropdowns.starList;
          break;
        case 'moongsign':
        case 'moongsignlist':
        case 'moonsign':
        case 'moonsignlist':
          list = globalDropdowns.moonsignList;
          break;
        case 'horoscope':
        case 'horoscopelist':
          list = globalDropdowns.horoscope;
          break;

        // Location
        case 'country':
        case 'countryid':
        case 'countrylist':
        case 'partcountry':
        case 'nricountry':
          list = globalDropdowns.countryList;
          break;
        case 'city':
        case 'citylist':
        case 'citymasterlist':
        case 'partcity':
          list = globalDropdowns.cityList ?? globalDropdowns.cityMasterList;
          break;
        case 'residence':
        case 'residencetype':
        case 'residencelist':
        case 'residencemasterlist':
        case 'residencetypelist':
          list = globalDropdowns.residence;
          break;

        // Education & Profession
        case 'education':
        case 'educationlevel':
        case 'educationlist':
        case 'educationmasterlist':
        case 'parteducation':
          list = globalDropdowns.educationMasterList;
          break;
        case 'employeein':
        case 'employeeinlist':
        case 'employedin':
        case 'employedinlist':
          list = globalDropdowns.employeeIn;
          break;
        case 'occupation':
        case 'occupationlist':
        case 'partoccupation':
        case 'fatheroccupation':
        case 'motheroccupation':
        case 'brotheroccupation':
        case 'sisteroccupation':
          list = globalDropdowns.occupationList;
          break;
        case 'designation':
        case 'designationlevel':
        case 'designationlist':
          list = globalDropdowns.designation;
          break;
        case 'income':
        case 'incomelist':
        case 'partincome':
        case 'partincomelist':
        case 'annualincome':
        case 'annualincomelist':
          list = globalDropdowns.income ?? globalDropdowns.partIncome;
          break;

        // Habits & Lifestyle
        case 'diet':
        case 'dietlist':
        case 'eatinghabit':
        case 'eatinghabitlist':
          list = globalDropdowns.diet;
          break;
        case 'smoke':
        case 'smokelist':
        case 'smokinghabit':
        case 'smokinghabitlist':
          list = globalDropdowns.smoke;
          break;
        case 'drink':
        case 'drinklist':
        case 'drinkinghabit':
        case 'drinkinghabitlist':
          list = globalDropdowns.drink;
          break;

        // Family
        case 'familytype':
        case 'familytypelist':
          list = globalDropdowns.familyType;
          break;
        case 'familystatus':
        case 'familystatuslist':
          list = globalDropdowns.familyStatus;
          break;
        case 'siblingcount':
        case 'siblingcountlist':
        case 'noofbrosis':
        case 'noofbrosislist':
        case 'noofbrother':
        case 'noofsister':
          list = globalDropdowns.noOfBrothers;
          break;
        case 'noofmarriedbrother':
        case 'noofmarriedbrotherlist':
          list = globalDropdowns.noMarriBrother;
          break;
        case 'noofmarriedsister':
        case 'noofmarriedsisterlist':
          list = globalDropdowns.noMarriSister;
          break;

        // Physical & ID
        case 'idprooftype':
        case 'idprooftypelist':
        case 'documenttype':
        case 'documenttypelist':
          list = globalDropdowns.documentType;
          break;
        case 'bodytype':
        case 'bodytypelist':
          list = globalDropdowns.bodytype;
          break;
        case 'bloodgroup':
        case 'bloodgroupid':
        case 'bloodgrouplist':
        case 'partbloodgroup':
          list = globalDropdowns.bloodGroup;
          break;
        case 'complexion':
        case 'complexionlist':
        case 'skintone':
        case 'skintonelist':
          list = globalDropdowns.skinTone;
          break;
        case 'countrycode':
          list = globalDropdowns.countryCode;
          break;
        case 'agerang':
        case 'ageranglist':
        case 'agerange':
        case 'agerangelist':
          list = globalDropdowns.ageRang;
          break;
        case 'gender':
        case 'genderlist':
          list = const [
            DropdownOptionModel(id: 'Male', val: 'Male'),
            DropdownOptionModel(id: 'Female', val: 'Female'),
          ];
          break;
      }

      if (list != null && list.isNotEmpty) {
        return list;
      }
    }

    // 3. Fallback to inline field options if defined
    if (field.options != null && field.options!.isNotEmpty) {
      return field.options!
          .map((o) => DropdownOptionModel(id: o.id, val: o.label))
          .toList();
    }

    return [];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(dynamicRegisterProvider);
    final notifier = ref.read(dynamicRegisterProvider.notifier);
    final globalDropdownsAsync = ref.watch(allDropdownsProvider);
    final globalDropdowns = globalDropdownsAsync.asData?.value;

    final List<Widget> widgets = [];
    final List<FormFieldModel> pendingPhotos = [];

    void flushPendingPhotos() {
      if (pendingPhotos.isNotEmpty) {
        final maxPhotos = ref.watch(maxPhotosAllowedProvider);
        final photosToRender = List<FormFieldModel>.from(pendingPhotos.take(maxPhotos));
        pendingPhotos.clear();
        widgets.add(
          DynamicPhotoUploadGrid(
            fields: photosToRender,
            formValues: registerState.formValues,
            onPhotoChanged: (fieldName, file) {
              notifier.updateFieldValue(fieldName, file);
            },
          ),
        );
      }
    }

    final enableSelfie = ref.watch(featureProvider('enableSelfieVerification'));
    final enableIdentity = ref.watch(featureProvider('enableIdentityVerification'));
    final enableAiBio = ref.watch(featureProvider('enableAiBioGenerator'));

    for (final field in section.fields) {
      // Check conditional visibility
      if (field.showIf != null && !field.showIf!.isVisible(registerState.formValues)) {
        continue;
      }

      // Feature flag gating: Hide selfie field if disabled by admin
      if (field.type == 'selfie_capture' && !enableSelfie) {
        continue;
      }

      // Feature flag gating: Hide ID proof fields if disabled by admin
      if (field.name.startsWith('id_proof') && !enableIdentity) {
        continue;
      }

      if (field.type == 'photo_upload') {
        pendingPhotos.add(field);
        continue;
      }

      flushPendingPhotos();

      final currentValue = registerState.formValues[field.name];

      switch (field.type) {
        case 'text':
        case 'email':
        case 'password':
        case 'number':
        case 'textarea':
          if (field.hasAiGenerate && enableAiBio) {
            widgets.add(
              DynamicAiBioField(
                field: field,
                initialValue: currentValue?.toString(),
                onChanged: (val) => notifier.updateFieldValue(field.name, val),
              ),
            );
          } else {
            widgets.add(
              DynamicTextField(
                field: field,
                initialValue: currentValue?.toString(),
                allFormValues: registerState.formValues,
                onChanged: (val) => notifier.updateFieldValue(field.name, val),
              ),
            );
          }
          break;

        case 'phone_number':
          widgets.add(
            DynamicPhoneField(
              field: field,
              initialValue: currentValue?.toString(),
              onCountryCodeChanged: (code) => notifier.setCountryCode(code),
              onChanged: (val) => notifier.updateFieldValue(field.name, val),
            ),
          );
          break;

        case 'single_select_dropdown':
        case 'dependent_dropdown':
          var items = _resolveDropdownItems(
            field: field,
            globalDropdowns: globalDropdowns,
            dependentOptions: registerState.dependentOptions,
          );

          if (SiblingDropdownHelper.isMarriedSiblingField(field.name) ||
              field.dropdownSource == 'no_of_married_brother_list' ||
              field.dropdownSource == 'no_of_married_sister_list') {
            final isBrother = field.name.contains('brother') ||
                (field.dropdownSource?.contains('brother') ?? false);
            final parentKey = isBrother ? 'no_of_brother' : 'no_of_sister';
            final altParentKey = isBrother ? 'no_of_brothers' : 'no_of_sisters';
            final totalValue = registerState.formValues[parentKey] ??
                registerState.formValues[altParentKey];
            items = SiblingDropdownHelper.filterAndSortMarriedOptions(
              options: items,
              totalSiblingValue: totalValue,
            );
          } else if (SiblingDropdownHelper.isTotalSiblingField(field.name) ||
              field.dropdownSource == 'no_of_bro_sis_list' ||
              field.dropdownSource == 'siblingCountList') {
            items = SiblingDropdownHelper.sortTotalSiblingOptions(items);
          }

          final DropdownOptionModel? selected = currentValue is DropdownOptionModel
              ? currentValue
              : (currentValue != null
                  ? items.cast<DropdownOptionModel?>().firstWhere(
                        (e) => e?.id.toString() == currentValue.toString() || e?.val == currentValue.toString(),
                        orElse: () => null,
                      )
                  : null);

          final validSelected = (selected != null &&
                  items.any((e) =>
                      (e.id != null && e.id.toString() == selected.id?.toString()) ||
                      (e.val != null && e.val.toString() == selected.val?.toString())))
              ? selected
              : null;

          final isPartnerPref = section.stepKey == 'partner_preferences' ||
              section.title.toLowerCase().contains('partner') ||
              field.name.toLowerCase().startsWith('part_') ||
              field.name.toLowerCase().startsWith('partner_') ||
              field.label.toLowerCase().contains('partner');

          widgets.add(
            DynamicDropdownField(
              field: field,
              items: items,
              selectedItem: validSelected,
              isLoading: globalDropdownsAsync.isLoading,
              isPartnerPreference: isPartnerPref,
              onChanged: (opt) {
                notifier.updateFieldValue(field.name, opt);
                // Cascade dependent options if needed
                for (final nextField in section.fields) {
                  if (nextField.parentField == field.name) {
                    notifier.updateFieldValue(nextField.name, null);
                    if (opt != null && opt.id != null && opt.id != 'DOES_NOT_MATTER') {
                      notifier.fetchDependentDropdown(
                        fieldName: nextField.name,
                        parentId: opt.id.toString(),
                        apiEndpoint: nextField.dependencyApi,
                        paramKey: nextField.dependencyParam,
                      );
                    }
                  }
                }
              },
            ),
          );
          break;

        case 'multi_select_dropdown':
          final items = _resolveDropdownItems(
            field: field,
            globalDropdowns: globalDropdowns,
            dependentOptions: registerState.dependentOptions,
          );
          final List<DropdownOptionModel> selectedList = currentValue is List<DropdownOptionModel>
              ? currentValue
              : (currentValue is List
                  ? currentValue.whereType<DropdownOptionModel>().toList()
                  : <DropdownOptionModel>[]);

          final isPartnerPrefMulti = section.stepKey == 'partner_preferences' ||
              section.title.toLowerCase().contains('partner') ||
              field.name.toLowerCase().startsWith('part_') ||
              field.name.toLowerCase().startsWith('partner_') ||
              field.label.toLowerCase().contains('partner');

          widgets.add(
            DynamicMultiDropdownField(
              field: field,
              items: items,
              selectedItems: selectedList,
              isLoading: globalDropdownsAsync.isLoading,
              isPartnerPreference: isPartnerPrefMulti,
              onChanged: (list) {
                notifier.updateFieldValue(field.name, list);
                // Cascade dependent options if needed (e.g. part_religion -> part_caste)
                for (final nextField in section.fields) {
                  if (nextField.parentField == field.name) {
                    notifier.updateFieldValue(nextField.name, <DropdownOptionModel>[]);
                    final parentIds = list
                        .map((e) => e.id.toString())
                        .where((id) => id.isNotEmpty && id != 'DOES_NOT_MATTER')
                        .join(',');
                    if (parentIds.isNotEmpty) {
                      notifier.fetchDependentDropdown(
                        fieldName: nextField.name,
                        parentId: parentIds,
                        apiEndpoint: nextField.dependencyApi,
                        paramKey: nextField.dependencyParam,
                      );
                    }
                  }
                }
              },
            ),
          );
          break;

        case 'segment_selector':
        case 'radio_group':
          final items = _resolveDropdownItems(
            field: field,
            globalDropdowns: globalDropdowns,
            dependentOptions: registerState.dependentOptions,
          );
          widgets.add(
            DynamicSegmentSelector(
              field: field,
              items: items,
              selectedValue: currentValue?.toString(),
              onChanged: (val) {
                notifier.updateFieldValue(field.name, val);
                for (final nextField in section.fields) {
                  if (nextField.parentField == field.name) {
                    notifier.updateFieldValue(nextField.name, null);
                    if (val.isNotEmpty) {
                      notifier.fetchDependentDropdown(
                        fieldName: nextField.name,
                        parentId: val,
                        apiEndpoint: nextField.dependencyApi,
                        paramKey: nextField.dependencyParam,
                      );
                    }
                  }
                }
              },
            ),
          );
          break;

        case 'date_picker':
          widgets.add(
            DynamicDatePickerField(
              field: field,
              initialValue: currentValue?.toString(),
              allFormValues: registerState.formValues,
              onChanged: (val) => notifier.updateFieldValue(field.name, val),
            ),
          );
          break;

        case 'time_picker':
          widgets.add(
            DynamicTimePickerField(
              field: field,
              initialValue: currentValue?.toString(),
              onChanged: (val) => notifier.updateFieldValue(field.name, val),
            ),
          );
          break;

        case 'range_slider':
          widgets.add(
            DynamicRangeSliderField(
              field: field,
              initialValue: currentValue is RangeValues ? currentValue : null,
              onChanged: (range) => notifier.updateFieldValue(field.name, range),
            ),
          );
          break;

        case 'checkbox':
          widgets.add(
            DynamicCheckboxField(
              field: field,
              initialValue: currentValue is bool ? currentValue : null,
              onChanged: (val) => notifier.updateFieldValue(field.name, val),
            ),
          );
          break;

        case 'selfie_capture':
          widgets.add(
            DynamicSelfieField(
              field: field,
              initialFile: currentValue is File ? currentValue : null,
              onChanged: (file) => notifier.updateFieldValue(field.name, file),
            ),
          );
          break;

        case 'file_upload':
          widgets.add(
            DynamicIdProofField(
              field: field,
              initialFile: currentValue is File ? currentValue : null,
              onChanged: (file) => notifier.updateFieldValue(field.name, file),
            ),
          );
          break;

        default:
          widgets.add(
            DynamicTextField(
              field: field,
              initialValue: currentValue?.toString(),
              allFormValues: registerState.formValues,
              onChanged: (val) => notifier.updateFieldValue(field.name, val),
            ),
          );
          break;
      }
    }

    flushPendingPhotos();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
