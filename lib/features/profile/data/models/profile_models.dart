import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

@freezed
abstract class MyProfileResponseModel with _$MyProfileResponseModel {
  const factory MyProfileResponseModel({
    int? code,
    String? status,
    String? message,
    ProfileData? data,
  }) = _MyProfileResponseModel;

  factory MyProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MyProfileResponseModelFromJson(json);
}

@freezed
abstract class OtherMemberProfileResponseModel with _$OtherMemberProfileResponseModel {
  const factory OtherMemberProfileResponseModel({
    int? code,
    String? status,
    String? message,
    ProfileData? data,
    @JsonKey(name: 'user_not_found_status') dynamic userNotFoundStatus,
    @JsonKey(name: 'user_not_found_title') String? userNotFoundTitle,
    @JsonKey(name: 'user_not_found_message') String? userNotFoundMessage,
    @JsonKey(name: 'remaining_contacts') dynamic remainingContacts,
    @JsonKey(name: 'has_viewed_contact') dynamic hasViewedContact,
    @JsonKey(name: 'view_profile_allowed') dynamic viewProfileAllowed,
  }) = _OtherMemberProfileResponseModel;

  factory OtherMemberProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OtherMemberProfileResponseModelFromJson(processOtherMemberProfileResponseModelJson(json));
}

@freezed
abstract class ProfileData with _$ProfileData {
  const factory ProfileData({
    dynamic id,
    @JsonKey(name: 'user_type') dynamic userType,
    @JsonKey(name: 'matri_id') dynamic matriId,
    dynamic email,
    mobile,
    @JsonKey(name: 'first_name') dynamic firstName,
    @JsonKey(name: 'last_name') dynamic lastName,
    dynamic fullname,
    dynamic birthdate,
    dynamic gender,
    @JsonKey(name: 'country_id') dynamic countryId,
    @JsonKey(name: 'state_id') dynamic stateId,
    dynamic city,
    dynamic address,
    @JsonKey(name: 'marital_status') dynamic maritalStatus,
    @JsonKey(name: 'total_children') dynamic totalChildren,
    @JsonKey(name: 'status_children') dynamic statusChildren,
    dynamic religion,
    dynamic caste,
    dynamic subcaste,
    dynamic manglik,
    dynamic star,
    dynamic gothra,
    dynamic moonsign,
    @JsonKey(name: 'mother_tongue') dynamic motherTongue,
    dynamic height,
    dynamic weight,
    dynamic diet,
    dynamic smoke,
    dynamic drink,
    @JsonKey(name: 'body_type') dynamic bodyType,
    @JsonKey(name: 'skin_tone') dynamic skinTone,
    @JsonKey(name: 'education_level') dynamic educationLevel,
    @JsonKey(name: 'education_details') dynamic educationDetails,
    @JsonKey(name: 'employee_in') dynamic employeeIn,
    @JsonKey(name: 'employee_in_details') dynamic employeeInDetails,
    @JsonKey(name: 'occupation') dynamic occupation,
    @JsonKey(name: 'occupation_details') dynamic occupationDetails,
    @JsonKey(name: 'designation_level') dynamic designationLevel,
    dynamic income,
    @JsonKey(name: 'family_type') dynamic familyType,
    @JsonKey(name: 'family_status') dynamic familyStatus,
    @JsonKey(name: 'no_of_brother') dynamic noOfBrother,
    @JsonKey(name: 'no_of_sister') dynamic noOfSister,
    @JsonKey(name: 'no_of_married_brother') dynamic noOfMarriedBrother,
    @JsonKey(name: 'no_of_married_sister') dynamic noOfMarriedSister,
    @JsonKey(name: 'photo1') dynamic photo1,
    @JsonKey(name: 'photo1_status') dynamic photo1Status,
    @JsonKey(name: 'photo2') dynamic photo2,
    @JsonKey(name: 'photo2_status') dynamic photo2Status,
    @JsonKey(name: 'photo3') dynamic photo3,
    @JsonKey(name: 'photo3_status') dynamic photo3Status,
    @JsonKey(name: 'photo4') dynamic photo4,
    @JsonKey(name: 'photo4_status') dynamic photo4Status,
    @JsonKey(name: 'plan_name') dynamic planName,
    @JsonKey(name: 'plan_status') dynamic planStatus,
    @JsonKey(name: 'country_name') dynamic countryName,
    @JsonKey(name: 'state_name') dynamic stateName,
    @JsonKey(name: 'city_name') dynamic cityName,
    @JsonKey(name: 'religion_name') dynamic religionName,
    @JsonKey(name: 'caste_name') dynamic casteName,
    @JsonKey(name: 'occupation_name') dynamic occupationName,
    @JsonKey(name: 'education_name') dynamic educationName,
    @JsonKey(name: 'interest_state') String? interestState,
    @JsonKey(name: 'interest_status') String? interestStatus,
    @JsonKey(name: 'interest_id') dynamic interestId,
    @JsonKey(name: 'total_reminder_count') int? totalReminderCount,
    @JsonKey(name: 'pending_reminder_count') int? pendingReminderCount,
    @JsonKey(name: 'can_send_reminder') bool? canSendReminder,
    @JsonKey(name: 'is_shortlisted') dynamic isShortlisted,
    @JsonKey(name: 'is_block') dynamic isBlock,
    @JsonKey(name: 'profile_title') dynamic profileTitle,
    @JsonKey(name: 'myprofilTab') List<TabData>? myProfileTab,
    @JsonKey(name: 'partnerPreferenceTab') List<TabData>? partnerPreferenceTab,
    @JsonKey(name: 'id_proof_front') dynamic idProofFront,
    @JsonKey(name: 'id_proof_back') dynamic idProofBack,
    @JsonKey(name: 'id_proof_status') dynamic idProofStatus,
    @JsonKey(name: 'id_proof_type') dynamic idProofType,
    @JsonKey(name: 'horoscope_file') dynamic horoscopeFile,
    @JsonKey(name: 'horoscope_status') dynamic horoscopeStatus,
    @JsonKey(name: 'profile_image') dynamic profileImage,
    @JsonKey(name: 'is_photo_protected') dynamic isPhotoProtected,
    @JsonKey(name: 'is_photo_request_sent') dynamic isPhotoRequestSent,
    @JsonKey(name: 'father_name') dynamic fatherName,
    @JsonKey(name: 'father_occupation') dynamic fatherOccupation,
    @JsonKey(name: 'father_mobile_number') dynamic fatherMobileNumber,
    @JsonKey(name: 'father_present') dynamic fatherPresent,
    @JsonKey(name: 'mother_name') dynamic motherName,
    @JsonKey(name: 'mother_occupation') dynamic motherOccupation,
    @JsonKey(name: 'mother_mobile_number') dynamic motherMobileNumber,
    @JsonKey(name: 'mother_present') dynamic motherPresent,
    @JsonKey(name: 'family_details') dynamic familyDetails,
    @JsonKey(name: 'residence_type') dynamic residenceType,
    @JsonKey(name: 'alternate_number') dynamic alternateNumber,
    @JsonKey(name: 'nri_country') dynamic nriCountry,
    @JsonKey(name: 'part_religion') dynamic partReligion,
    @JsonKey(name: 'part_caste') dynamic partCaste,
    @JsonKey(name: 'part_country') dynamic partCountry,
    @JsonKey(name: 'part_state') dynamic partState,
    @JsonKey(name: 'part_income') dynamic partIncome,
    @JsonKey(name: 'part_marital_status') dynamic partMaritalStatus,
    @JsonKey(name: 'part_education') dynamic partEducation,
    @JsonKey(name: 'part_occupation') dynamic partOccupation,
    @JsonKey(name: 'part_mothertongue') dynamic partMothertongue,
    @JsonKey(name: 'part_manglik') dynamic partManglik,
    @JsonKey(name: 'part_frm_age') dynamic partFrmAge,
    @JsonKey(name: 'part_to_age') dynamic partToAge,
    @JsonKey(name: 'part_height') dynamic partHeight,
    @JsonKey(name: 'part_height_to') dynamic partHeightTo,
    @JsonKey(name: 'profile_text') dynamic profileText,
    @JsonKey(name: 'sub_title') dynamic subTitle,
    dynamic age,
    @JsonKey(name: 'height_str') dynamic heightStr,
    @JsonKey(name: 'matchPercent') dynamic matchPercent,
    @JsonKey(name: 'completed_profile') dynamic completedProfile,
    @JsonKey(name: 'mobile_verify_status') dynamic mobileVerifyStatus,
    @JsonKey(name: 'cpass_status') dynamic cpassStatus,
    @JsonKey(name: 'profileby') dynamic profileBy,
    dynamic horoscope,
    dynamic birthplace,
    dynamic birthtime,
    @JsonKey(name: 'video_call_setting') dynamic videoCallSetting,
    @JsonKey(name: 'voice_call_setting') dynamic voiceCallSetting,
    dynamic pincode,
    @JsonKey(name: 'residence_type_other') dynamic residenceTypeOther,
    @JsonKey(name: 'photo_visibility') dynamic photoVisibility,
    @JsonKey(name: 'contact_visibility') dynamic contactVisibility,
    @JsonKey(name: 'brother_details_arr') List<dynamic>? brotherDetailsArr,
    @JsonKey(name: 'sister_details_arr') List<dynamic>? sisterDetailsArr,
    @JsonKey(name: 'paternal_family') List<dynamic>? paternalFamily,
    @JsonKey(name: 'maternal_family') List<dynamic>? maternalFamily,
    @JsonKey(name: 'download_biodata') dynamic downloadBiodata,
    @JsonKey(name: 'view_profile_allowed') dynamic viewProfileAllowed,
  }) = _ProfileData;

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(processProfileDataJson(json));
}

Map<String, dynamic> processProfileDataJson(Map<String, dynamic> json) {
  final Map<String, dynamic> processedJson = Map<String, dynamic>.from(json);

  if (processedJson['about_me_description'] != null) {
    processedJson['profile_text'] = processedJson['about_me_description'];
  }

  if (processedJson['interest_id'] == null ||
      processedJson['interest_id'].toString().isEmpty ||
      processedJson['interest_id'].toString() == '0' ||
      processedJson['interest_id'].toString() == 'null') {
    processedJson['interest_id'] = processedJson['interest_request_id'] ??
        processedJson['express_interest_id'] ??
        processedJson['ei_id'] ??
        (json['actions'] is Map
            ? (json['actions']['interest_id'] ??
                json['actions']['interest_request_id'] ??
                json['actions']['id'])
            : null);
  }

  List<dynamic> extractFamilyArray(dynamic fieldData) {
    if (fieldData == null) return [];
    dynamic dataToDecode = fieldData;
    if (fieldData is Map) {
      dataToDecode = fieldData['value'] ?? fieldData['selected_ids'];
    }
    if (dataToDecode == null) return [];

    if (dataToDecode is String) {
      final trimmed = dataToDecode.trim();
      if (trimmed.startsWith('[') || trimmed.startsWith('{')) {
        try {
          final decoded = jsonDecode(trimmed);
          if (decoded is List) return decoded;
          if (decoded is Map) return [decoded];
        } catch (_) {}
      }
      return [];
    } else if (dataToDecode is List) {
      return dataToDecode;
    }
    return [];
  }

  dynamic brotherField;
  dynamic sisterField;
  dynamic paternalField;
  dynamic maternalField;

  void findFamilyFieldsInList(List fields) {
    for (final f in fields) {
      if (f is Map) {
        final key = f['key']?.toString();
        if (key == 'brother_details') brotherField = f;
        if (key == 'sister_details') sisterField = f;
        if (key == 'paternal_family') paternalField = f;
        if (key == 'maternal_family') maternalField = f;
      }
    }
  }

  if (json['myProfileTab'] is List) {
    for (final tab in json['myProfileTab']) {
      if (tab is Map && tab['fields'] is List) {
        findFamilyFieldsInList(tab['fields']);
      }
    }
  }
  if (json['myprofilTab'] is List) {
    for (final tab in json['myprofilTab']) {
      if (tab is Map && tab['fields'] is List) {
        findFamilyFieldsInList(tab['fields']);
      } else if (tab is Map && tab['sectionValue'] is List) {
        findFamilyFieldsInList(tab['sectionValue']);
      }
    }
  }

  processedJson['brother_details_arr'] = extractFamilyArray(brotherField ?? json['brother_details']);
  processedJson['sister_details_arr'] = extractFamilyArray(sisterField ?? json['sister_details']);
  processedJson['paternal_family'] = extractFamilyArray(paternalField ?? json['paternal_family']);
  processedJson['maternal_family'] = extractFamilyArray(maternalField ?? json['maternal_family']);

  // Extract clean string display value for a field (handles List, Map, and primitive types)
  dynamic extractFieldDisplayValue(dynamic rawVal) {
    if (rawVal == null) return null;
    if (rawVal is List) {
      final items = rawVal
          .map((e) => e is Map
              ? (e['name'] ?? e['title'] ?? e['value'] ?? e.toString())
              : e.toString())
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty && e != 'null' && e != 'N/A')
          .toList();
      return items.isEmpty ? null : items.join(', ');
    }
    if (rawVal is Map) {
      final v = rawVal['name'] ?? rawVal['title'] ?? rawVal['value'];
      return v?.toString().trim();
    }
    final s = rawVal.toString().trim();
    if (s.isEmpty || s == 'null' || s == 'N/A') return null;
    return s;
  }

  // Update root fields from dynamic tab fields so human-readable 'value' is used instead of 'selected_ids'
  void mapTabFieldsToProcessedJson(dynamic tabList) {
    if (tabList is! List) return;
    for (final tab in tabList) {
      if (tab is Map) {
        final fields = tab['fields'] ?? tab['sectionValue'];
        if (fields is List) {
          for (final f in fields) {
            if (f is Map) {
              final key = f['key']?.toString().trim();
              final val = extractFieldDisplayValue(f['value']);
              if (key != null && key.isNotEmpty && val != null) {
                processedJson[key] = val;
                if (key.contains('_')) {
                  final parts = key.split('_');
                  final camel = parts.first +
                      parts
                          .skip(1)
                          .map((w) => w.isEmpty
                              ? ''
                              : w[0].toUpperCase() + w.substring(1))
                          .join();
                  processedJson[camel] = val;
                }
              }
            }
          }
        }
      }
    }
  }

  mapTabFieldsToProcessedJson(json['myProfileTab']);
  mapTabFieldsToProcessedJson(json['myprofilTab']);
  mapTabFieldsToProcessedJson(json['partnerPreferenceTab']);

  if (json['actions'] is Map<String, dynamic>) {
    final actions = json['actions'] as Map<String, dynamic>;
    actions.forEach((key, value) {
      processedJson[key] = value;
    });
  }

  if (json['myProfileTab'] is List) {
    processedJson['myprofilTab'] = (json['myProfileTab'] as List).map((tab) {
      final tabMap = Map<String, dynamic>.from(tab);
      tabMap['sectionTitle'] = tab['label'];
      tabMap['sectionId'] = tab['section_key'];
      if (tab['fields'] is List) {
        tabMap['sectionValue'] = (tab['fields'] as List).map((f) {
          if (f is Map) {
            final fMap = Map<String, dynamic>.from(f);
            final displayVal = extractFieldDisplayValue(fMap['value']);
            if (displayVal != null) {
              fMap['value'] = displayVal.toString();
            }
            return fMap;
          }
          return f;
        }).toList();
      }
      return tabMap;
    }).toList();
  }

  if (json['partnerPreferenceTab'] is Map) {
    final tab = json['partnerPreferenceTab'] as Map<String, dynamic>;
    final tabMap = <String, dynamic>{
      'sectionTitle': tab['label'],
      'sectionId': tab['section_key'],
      if (tab['fields'] is List)
        'sectionValue': (tab['fields'] as List).map((f) {
          if (f is Map) {
            final fMap = Map<String, dynamic>.from(f);
            final displayVal = extractFieldDisplayValue(fMap['value']);
            if (displayVal != null) {
              fMap['value'] = displayVal.toString();
            }
            return fMap;
          }
          return f;
        }).toList()
      else
        'sectionValue': tab['fields'],
    };
    processedJson['partnerPreferenceTab'] = [tabMap];
  } else if (json['partnerPreferenceTab'] is List) {
    processedJson['partnerPreferenceTab'] = (json['partnerPreferenceTab'] as List).map((tab) {
      final tabMap = Map<String, dynamic>.from(tab);
      tabMap['sectionTitle'] = tab['label'];
      tabMap['sectionId'] = tab['section_key'];
      if (tab['fields'] is List) {
        tabMap['sectionValue'] = (tab['fields'] as List).map((f) {
          if (f is Map) {
            final fMap = Map<String, dynamic>.from(f);
            final displayVal = extractFieldDisplayValue(fMap['value']);
            if (displayVal != null) {
              fMap['value'] = displayVal.toString();
            }
            return fMap;
          }
          return f;
        }).toList();
      }
      return tabMap;
    }).toList();
  }

  return processedJson;
}

Map<String, dynamic> processOtherMemberProfileResponseModelJson(Map<String, dynamic> json) {
  final Map<String, dynamic> processedJson = Map<String, dynamic>.from(json);

  // Normalize remaining contacts keys
  if (json.containsKey('remainingContacts')) {
    processedJson['remaining_contacts'] = json['remainingContacts'];
  } else if (json['data'] is Map) {
    final dataMap = json['data'] as Map;
    if (dataMap.containsKey('remainingContacts')) {
      processedJson['remaining_contacts'] = dataMap['remainingContacts'];
    } else if (dataMap.containsKey('remaining_contacts')) {
      processedJson['remaining_contacts'] = dataMap['remaining_contacts'];
    }
  }

  // Normalize has viewed contact keys
  if (json.containsKey('hasViewedContact')) {
    processedJson['has_viewed_contact'] = json['hasViewedContact'];
  } else if (json['data'] is Map) {
    final dataMap = json['data'] as Map;
    if (dataMap.containsKey('hasViewedContact')) {
      processedJson['has_viewed_contact'] = dataMap['hasViewedContact'];
    } else if (dataMap.containsKey('has_viewed_contact')) {
      processedJson['has_viewed_contact'] = dataMap['has_viewed_contact'];
    }
  }

  // Normalize view profile allowed keys
  if (json.containsKey('viewProfileAllowed')) {
    processedJson['view_profile_allowed'] = json['viewProfileAllowed'];
  } else if (json.containsKey('view_profile_allowed')) {
    processedJson['view_profile_allowed'] = json['view_profile_allowed'];
  } else if (json['data'] is Map) {
    final dataMap = json['data'] as Map;
    if (dataMap.containsKey('viewProfileAllowed')) {
      processedJson['view_profile_allowed'] = dataMap['viewProfileAllowed'];
    } else if (dataMap.containsKey('view_profile_allowed')) {
      processedJson['view_profile_allowed'] = dataMap['view_profile_allowed'];
    }
  }

  // Ensure is_photo_protected and photo_visibility are preserved
  if (processedJson['data'] is Map) {
    final dataMap = Map<String, dynamic>.from(processedJson['data'] as Map);
    for (final k in ['is_photo_protected', 'isPhotoProtected', 'photo_visibility', 'photoVisibility']) {
      if (!dataMap.containsKey(k) && json.containsKey(k)) {
        dataMap[k] = json[k];
      }
    }
    processedJson['data'] = dataMap;
  }

  return processedJson;
}


@freezed
abstract class TabData with _$TabData {
  const factory TabData({
    String? sectionTitle,
    String? sectionId,
    List<SectionValue>? sectionValue,
  }) = _TabData;

  factory TabData.fromJson(Map<String, dynamic> json) =>
      _$TabDataFromJson(json);
}

@freezed
abstract class SectionValue with _$SectionValue {
  const factory SectionValue({
    String? key,
    String? label,
    String? value,
    @JsonKey(name: 'selected_ids') dynamic selectedIds,
  }) = _SectionValue;

  factory SectionValue.fromJson(Map<String, dynamic> json) =>
      _$SectionValueFromJson(json);
}
