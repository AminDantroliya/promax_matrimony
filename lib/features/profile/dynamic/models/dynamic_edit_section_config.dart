import 'package:flutter/material.dart';
import '../../../../features/auth/screens/register2/models/dynamic_form_models.dart';
import '../../../../utils/utils.dart';
import '../../data/models/profile_models.dart';

/// Enum representing the profile edit section being edited
enum DynamicEditSectionType {
  basicDetails,
  religiousInfo,
  locationDetails,
  educationDetails,
  physicalInfo,
  familyDetails,
  partnerPreference;

  static DynamicEditSectionType fromKey(String key) {
    final k = key.toLowerCase();
    if (k.contains('basic')) {
      return DynamicEditSectionType.basicDetails;
    } else if (k.contains('religion') || k.contains('religious')) {
      return DynamicEditSectionType.religiousInfo;
    } else if (k.contains('location') || k.contains('contact')) {
      return DynamicEditSectionType.locationDetails;
    } else if (k.contains('education') || k.contains('occupation')) {
      return DynamicEditSectionType.educationDetails;
    } else if (k.contains('physical') ||
        k.contains('lifestyle') ||
        k.contains('about')) {
      return DynamicEditSectionType.physicalInfo;
    } else if (k.contains('family')) {
      return DynamicEditSectionType.familyDetails;
    } else if (k.contains('partner') || k.contains('preference')) {
      return DynamicEditSectionType.partnerPreference;
    }
    return DynamicEditSectionType.basicDetails;
  }

  String get formType {
    switch (this) {
      case DynamicEditSectionType.basicDetails:
        return 'basic_details';
      case DynamicEditSectionType.religiousInfo:
        return 'religious_information';
      case DynamicEditSectionType.locationDetails:
        return 'location_details';
      case DynamicEditSectionType.educationDetails:
        return 'education_details';
      case DynamicEditSectionType.physicalInfo:
        return 'physical_information';
      case DynamicEditSectionType.familyDetails:
        return 'family_details';
      case DynamicEditSectionType.partnerPreference:
        return 'partner_preference';
    }
  }

  String get stepKey => formType;

  String get searchToken {
    switch (this) {
      case DynamicEditSectionType.basicDetails:
        return 'basic';
      case DynamicEditSectionType.religiousInfo:
        return 'relig';
      case DynamicEditSectionType.locationDetails:
        return 'locat';
      case DynamicEditSectionType.educationDetails:
        return 'educat';
      case DynamicEditSectionType.physicalInfo:
        return 'about';
      case DynamicEditSectionType.familyDetails:
        return 'family';
      case DynamicEditSectionType.partnerPreference:
        return 'partner';
    }
  }

  String get titleKey {
    switch (this) {
      case DynamicEditSectionType.basicDetails:
        return 'edit_basic_details';
      case DynamicEditSectionType.religiousInfo:
        return 'religious_information';
      case DynamicEditSectionType.locationDetails:
        return 'location_details';
      case DynamicEditSectionType.educationDetails:
        return 'education_details';
      case DynamicEditSectionType.physicalInfo:
        return 'about_me';
      case DynamicEditSectionType.familyDetails:
        return 'family_details';
      case DynamicEditSectionType.partnerPreference:
        return 'partner_preference';
    }
  }

  String get successKey {
    switch (this) {
      case DynamicEditSectionType.basicDetails:
        return 'profile_updated_success';
      case DynamicEditSectionType.religiousInfo:
        return 'religious_info_updated_success';
      case DynamicEditSectionType.locationDetails:
        return 'location_updated_success';
      case DynamicEditSectionType.educationDetails:
        return 'education_updated_success';
      case DynamicEditSectionType.physicalInfo:
        return 'lifestyle_updated_success';
      case DynamicEditSectionType.familyDetails:
        return 'profile_updated_success';
      case DynamicEditSectionType.partnerPreference:
        return 'partner_preferences_updated_success';
    }
  }

  /// Helper to parse initial value for fields from backend default_value or profile
  dynamic parseInitialValue(
    FormFieldModel field,
    ProfileData? profile,
  ) {
    // 1. Check field's default_value directly from API response
    final defVal = field.defaultValue;

    if (field.type == 'range_slider') {
      final isHeight = field.name.contains('height');
      final double min = field.minVal ?? (isHeight ? 48.0 : 18.0);
      final double max = field.maxVal ?? (isHeight ? 84.0 : 70.0);

      RangeValues safeRange(double start, double end) {
        final safeMin = min < max ? min : max;
        final safeMax = max > min ? max : min + 1.0;
        double s = start.clamp(safeMin, safeMax);
        double e = end.clamp(safeMin, safeMax);
        if (s > e) {
          final t = s;
          s = e;
          e = t;
        }
        return RangeValues(s, e);
      }

      if (defVal is List && defVal.length >= 2) {
        final start = double.tryParse(defVal[0].toString()) ?? min;
        final end = double.tryParse(defVal[1].toString()) ?? max;
        return safeRange(start, end);
      } else if (profile != null) {
        if (field.name.contains('age')) {
          final start = double.tryParse(profile.partFrmAge?.toString() ?? '') ??
              (field.defaultRange != null && field.defaultRange!.isNotEmpty
                  ? field.defaultRange![0]
                  : min);
          final end = double.tryParse(profile.partToAge?.toString() ?? '') ??
              (field.defaultRange != null && field.defaultRange!.length >= 2
                  ? field.defaultRange![1]
                  : max);
          return safeRange(start, end);
        } else if (isHeight) {
          final start = double.tryParse(profile.partHeight?.toString() ?? '') ??
              (field.defaultRange != null && field.defaultRange!.isNotEmpty
                  ? field.defaultRange![0]
                  : min);
          final end = double.tryParse(profile.partHeightTo?.toString() ?? '') ??
              (field.defaultRange != null && field.defaultRange!.length >= 2
                  ? field.defaultRange![1]
                  : max);
          return safeRange(start, end);
        }
      }

      if (field.defaultRange != null && field.defaultRange!.length >= 2) {
        return safeRange(field.defaultRange![0], field.defaultRange![1]);
      }

      return safeRange(min, max);
    }

    if (defVal != null && defVal.toString().trim().isNotEmpty) {
      return defVal.toString();
    }

    // 2. Extra fallback: extract from ProfileData if backend default_value is null/empty
    if (profile != null) {
      final isPartner = this == DynamicEditSectionType.partnerPreference;
      final tabVal = getSelectedIdFromTab(profile, field.name, isPartner: isPartner);
      if (tabVal.isNotEmpty) return tabVal;
    }

    return '';
  }
}
