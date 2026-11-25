export "package:pro_matrimony/core/localization/language_provider.dart";
export "package:pro_matrimony/app_theme/theme_provider.dart";
export "package:pro_matrimony/app_theme/app_theme.dart";
export "package:pro_matrimony/widgets/app_text_helpers.dart";
export "package:pro_matrimony/widgets/app_tab_bar.dart";
export "package:pro_matrimony/utils/app_assets.dart";
export "package:pro_matrimony/config/providers/config_providers.dart";
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import '../app_theme/app_theme.dart';
import '../app_theme/size_config.dart';
import '../features/common/data/models/dropdown_models.dart';
import 'constants.dart';

String getUserAgent() {
  if (Platform.isAndroid) {
    return androidUserAgent;
  } else {
    return iosUserAgent;
  }
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

int showProtected() {
  var isShow = 0;
  return isShow;
}

bool isValidUrl(String url) {
  return Uri.parse(url).isAbsolute;
}

bool isNullFromBlankString(String? value) {
  if(value == null || value == "null" || value.isEmpty){
    return true;
  }else{
    return false;
  }
}

String getFormattedDate(String serverDate) {
  if (serverDate == "0000-00-00 00:00:00" || serverDate.isEmpty) {
    return "N/A";
  }

  try {
    final parsed = DateTime.tryParse(serverDate) ?? DateFormat("yyyy-MM-dd hh:mm:ss").parse(serverDate);
    final DateFormat formatter = DateFormat('dd MMM, yyyy hh:mm a');
    return formatter.format(parsed);
  } catch (_) {
    return "N/A";
  }
}

String getFormattedPlanDate(String serverDate) {
  if (serverDate == "0000-00-00" || serverDate.isEmpty) {
    return "N/A";
  }

  try {
    final parsed = DateTime.tryParse(serverDate) ?? DateFormat("yyyy-MM-dd").parse(serverDate);
    final DateFormat formatter = DateFormat('dd MMMM, yyyy');
    return formatter.format(parsed);
  } catch (_) {
    return "N/A";
  }
}

String getFormattedChatDate(String serverDate) {
  DateTime now = DateTime.now();
  DateTime date = DateTime.parse(serverDate);

  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime messageDate = DateTime(date.year, date.month, date.day);
  if (serverDate == "0000-00-00 00:00:00") {
    return "N/A";
  }

  if (messageDate == today) {
    return DateFormat('hh:mm a').format(date);
  } else {
    return DateFormat('dd MMM, yyyy hh:mm:ss a').format(date);
  }
}

String getDisplayString(dynamic name, {required String defaultValue}) {
  if (name != null && name != "") {
    return name.toString();
  }
  return defaultValue;
}

String getFormattedDateSavedSearch(String serverDate) {
  if (serverDate == "0000-00-00 00:00:00" || serverDate.isEmpty) {
    return "N/A";
  }

  try {
    final parsed = DateTime.tryParse(serverDate) ?? DateFormat("yyyy-MM-dd hh:mm:ss").parse(serverDate);
    final DateFormat formatter = DateFormat('EEE dd MMMM-yyyy');
    return formatter.format(parsed);
  } catch (_) {
    return "N/A";
  }
}

/// Formats a raw height string or value (e.g., "4-8 ft", "122cm - 4", "5-10 ft", "5ft 6in", "5'6\"", 56)
/// into a clean readable format such as `4'8" Height` (if appendHeight is true) or `4'8"`.
String formatDisplayHeight(dynamic rawHeight, {bool appendHeight = false}) {
  if (rawHeight == null) return "";
  String h = rawHeight.toString().trim();
  if (h.isEmpty || h == "null" || h == "N/A" || h == "0") return "";

  // Strip trailing "Height" or "height" to avoid duplication
  h = h.replaceAll(RegExp(r'\s*Height$', caseSensitive: false), '').trim();
  if (h.isEmpty) return "";

  int? feet;
  int? inches;

  // 1. Check for cm prefix with feet at the end, e.g. "122cm - 4", "153cm - 5", "183cm - 6", "214cm - 7"
  // Format: <cm>cm - <feet>
  final cmFeetMatch = RegExp(r'^\d+\s*cm\s*-\s*(\d+)(?:\s*ft)?$', caseSensitive: false).firstMatch(h);
  if (cmFeetMatch != null) {
    feet = int.tryParse(cmFeetMatch.group(1)!);
    inches = 0;
  }

  // 1b. Check for cm prefix with feet and inches, e.g. "122cm - 4-8 ft"
  if (feet == null) {
    final cmFeetInchMatch = RegExp(r'^\d+\s*cm\s*-\s*(\d+)\s*[-]\s*(\d+)\s*(?:ft)?$', caseSensitive: false).firstMatch(h);
    if (cmFeetInchMatch != null) {
      feet = int.tryParse(cmFeetInchMatch.group(1)!);
      inches = int.tryParse(cmFeetInchMatch.group(2)!);
    }
  }

  // 2. Check for hyphen feet-inch format, e.g. "4-8 ft", "5-6 ft", "5-10 ft", "4-8", "5-11 ft", "4 - 8"
  if (feet == null) {
    final hyphenMatch = RegExp(r'^(\d+)\s*[-]\s*(\d+)\s*(?:ft)?$', caseSensitive: false).firstMatch(h);
    if (hyphenMatch != null) {
      feet = int.tryParse(hyphenMatch.group(1)!);
      inches = int.tryParse(hyphenMatch.group(2)!);
    }
  }

  // 3. Check for "ft ... in" format, e.g. "5ft 6in", "5 ft 6 in", "5ft", "5 ft"
  if (feet == null) {
    final ftInMatch = RegExp(r'^(\d+)\s*ft(?:\s*(\d+)\s*(?:in)?)?$', caseSensitive: false).firstMatch(h);
    if (ftInMatch != null) {
      feet = int.tryParse(ftInMatch.group(1)!);
      inches = ftInMatch.group(2) != null ? int.tryParse(ftInMatch.group(2)!) : 0;
    }
  }

  // 4. Check for apostrophe / quotes format, e.g. "5'6\"", "5' 6\"", "5'6", "5'"
  if (feet == null) {
    final quoteMatch = RegExp(r'''^(\d+)\s*['’]\s*(\d+)?\s*(?:["”]|in)?$''').firstMatch(h);
    if (quoteMatch != null) {
      feet = int.tryParse(quoteMatch.group(1)!);
      inches = quoteMatch.group(2) != null ? int.tryParse(quoteMatch.group(2)!) : 0;
    }
  }

  // 5. Check for pure numbers:
  if (feet == null) {
    final numMatch = RegExp(r'^(\d+)(?:\s*cm)?$', caseSensitive: false).firstMatch(h);
    if (numMatch != null) {
      final val = int.tryParse(numMatch.group(1)!);
      if (val != null) {
        if (val >= 3 && val <= 8) {
          // Single digit feet (e.g. 4, 5, 6)
          feet = val;
          inches = 0;
        } else if (val >= 36 && val <= 96) {
          // Total inches or dropdown IDs (e.g. 48 = 4'0", 56 = 4'8", 68 = 5'8", 72 = 6'0")
          feet = val ~/ 12;
          inches = val % 12;
        } else if (val >= 100 && val <= 250) {
          // Centimeters (e.g. 165 cm)
          final totalInches = (val / 2.54).round();
          feet = totalInches ~/ 12;
          inches = totalInches % 12;
        }
      }
    }
  }

  // Normalize inches if >= 12
  if (feet != null && inches != null && inches >= 12) {
    feet = feet + (inches ~/ 12);
    inches = inches % 12;
  }

  // If we successfully resolved feet and inches:
  if (feet != null) {
    final inchVal = inches ?? 0;
    final formatted = "$feet'$inchVal\"";
    return appendHeight ? "$formatted Height" : formatted;
  }

  // Fallback: return h as is (or with " Height" if requested and not already present)
  return appendHeight ? "$h Height" : h;
}


// Form field Underline Border START
UnderlineInputBorder getFieldUnderlineInputBorder([ThemeData? theme]){
  return UnderlineInputBorder(
    borderSide: BorderSide(color: theme?.colorScheme.onSurface.withValues(alpha: 0.2) ?? Colors.black26),
  );
}

UnderlineInputBorder getFieldUnderlineInputFocusedBorder([ThemeData? theme]){
  return UnderlineInputBorder(
    borderSide: BorderSide(color: theme?.colorScheme.primary ?? Colors.black, width: 1),
  );
}

UnderlineInputBorder getFieldUnderlineInputErrorBorder([ThemeData? theme]){
  return UnderlineInputBorder(
    borderSide: BorderSide(color: theme?.colorScheme.error ?? Colors.red, width: 1),
  );
}
// Form field Underline Border END

// Form field Outline Border START
OutlineInputBorder getFieldOutlineInputBorder([ThemeData? theme]){
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: theme?.colorScheme.onSurface.withValues(alpha: 0.1) ?? Colors.transparent),
  );
}

OutlineInputBorder getFieldOutlineInputFocusedBorder([ThemeData? theme]){
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    gapPadding: 0,
    borderSide: BorderSide(color: theme?.colorScheme.primary ?? Colors.transparent, width: 1),
  );
}

OutlineInputBorder getFieldOutlineInputErrorBorder([ThemeData? theme]){
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: theme?.colorScheme.error ?? Colors.transparent, width: 1),
  );
}
// Form field Outline Border END

void showToast(String message) {
  toastification.showCustom(
    autoCloseDuration: const Duration(seconds: 4),
    alignment: Alignment.bottomCenter,
    animationDuration: const Duration(milliseconds: 400),
    builder: (context, holder) {
      final theme = Theme.of(context);
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.secondary, theme.primaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      message,
                      style: AppFont.font(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void showSuccessToast(BuildContext context, String message, {String? subtitle, IconData? icon}) {
  final theme = Theme.of(context);
  toastification.showCustom(
    context: context,
    autoCloseDuration: const Duration(seconds: 4),
    alignment: Alignment.bottomCenter,
    animationDuration: const Duration(milliseconds: 400),
    builder: (context, holder) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.secondary, theme.primaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        icon ?? Icons.favorite_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message,
                          style: AppFont.font(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: AppFont.font(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void showErrorToast(BuildContext context, String message, {String? subtitle}) {
  toastification.showCustom(
    context: context,
    autoCloseDuration: const Duration(seconds: 4),
    alignment: Alignment.bottomCenter,
    animationDuration: const Duration(milliseconds: 400),
    builder: (context, holder) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD32F2F).withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.error_outline_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message,
                          style: AppFont.font(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: AppFont.font(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void showLoading(BuildContext context, {bool? isDark}) {
  final dark = isDark ?? (Theme.of(context).brightness == Brightness.dark);
  Loader.show(context,
      isAppbarOverlay: true,
      isBottomBarOverlay: true,
      progressIndicator: Center(
        child: Container(
          height: getProportionateScreenWidth(100),
          width: getProportionateScreenWidth(100),
          padding: EdgeInsets.all(getProportionateScreenWidth(35)),
          decoration: BoxDecoration(
            color: dark ? Colors.grey.shade800 : Colors.white,
            borderRadius: BorderRadius.circular(getProportionateScreenWidth(10))
          ),
          child: const CircularProgressIndicator(
            color: appPrimaryColor,
          ),
        ),
      ),
      themeData: Theme.of(context).copyWith(),
      overlayColor: Colors.black54
  );
}

void hideLoading() {
  Loader.hide();
}

/// Wraps any async [action] in [showLoading] / [hideLoading] automatically.
///
/// The loader is guaranteed to be dismissed even if [action] throws, because
/// [hideLoading] is called in the `finally` block.
///
/// Example:
/// ```dart
/// final success = await withLoading(context, () =>
///     ref.read(actionRepositoryProvider).toggleShortlist(
///         memberId: member.id.toString(),
///         isCurrentlyShortlisted: isShortlisted));
/// ```
Future<T> withLoading<T>(
  BuildContext context,
  Future<T> Function() action,
) async {
  showLoading(context);
  try {
    return await action();
  } finally {
    hideLoading();
  }
}


String getCountryCode(String countryCode) {
  if (countryCode.isEmpty) return "US";
  String cleanCode = countryCode.trim();

  if (cleanCode.length == 2 && RegExp(r'^[A-Za-z]{2}$').hasMatch(cleanCode)) {
    return cleanCode.toUpperCase();
  }

  if (!cleanCode.startsWith('+') && RegExp(r'^\d+$').hasMatch(cleanCode)) {
    cleanCode = '+$cleanCode';
  }

  final List<CountryDetails> countriesList = CountryCodes.countryCodes();
  for (var country in countriesList) {
    if (country.dialCode == cleanCode || country.dialCode == cleanCode.replaceAll('+', '')) {
      return country.alpha2Code ?? "US";
    }
  }

  for (var c in countries) {
    if ('+${c.dialCode}' == cleanCode || c.dialCode == cleanCode.replaceAll('+', '')) {
      return c.code;
    }
  }

  return "US";
}

List<Country> getPrioritizedCountryList() {
  final priorityCodes = ['US', 'IN', 'CA', 'GB', 'AU', 'NZ'];
  final List<Country> priorityList = [];
  for (var code in priorityCodes) {
    try {
      final match = countries.firstWhere((c) => c.code == code);
      priorityList.add(match);
    } catch (_) {}
  }

  final List<Country> otherList = countries
      .where((c) => !priorityCodes.contains(c.code))
      .toList();

  otherList.sort((a, b) => a.name.compareTo(b.name));

  return [...priorityList, ...otherList];
}

List<Country> getCountryCodeList(List<DropdownOptionModel> myCountryNameList) {
  List<String> tempCountryName = [];
  for (var country in myCountryNameList) {
    tempCountryName.add(country.val.toString());
  }

  List<Country> countryCodes = [];
  for (var name in tempCountryName) {
    for (var country in countries) {
      if (country.name == name) {
        countryCodes.add(Country(
          code: country.code,
          name: country.name,
          flag: country.flag,
          dialCode: country.dialCode,
          nameTranslations: country.nameTranslations,
          minLength: country.minLength,
          maxLength: country.maxLength,
        ));
      }
    }
  }

  return countryCodes;
}

DropdownOptionModel getSelectedSingleItem(List<DropdownOptionModel> dropDownData, String selectedId) {
  DropdownOptionModel selectedModel = const DropdownOptionModel();
  final trimmedId = selectedId.trim();
  for (var element in dropDownData) {
    DropdownOptionModel dropdownItem = element;
    if (dropdownItem.id.toString() == trimmedId ||
        (dropdownItem.val != null && dropdownItem.val.toString() == trimmedId)) {
      selectedModel = dropdownItem;
    }
  }
  return selectedModel;
}

List<DropdownOptionModel> getSelectedMultipleItem(List<DropdownOptionModel> dropDownData, String selectedId) {
  List<DropdownOptionModel> selectedModel = [];
  var selectedTempIds = selectedId.split(",").map((e) => e.trim()).toList();
  for (var element in dropDownData) {
    DropdownOptionModel dropdownItem = element;
    if (selectedTempIds.contains(dropdownItem.id.toString()) ||
        (dropdownItem.val != null && selectedTempIds.contains(dropdownItem.val.toString()))) {
      selectedModel.add(dropdownItem);
    }
  }
  return selectedModel;
}

SystemUiOverlayStyle getThemeSystemUiOverlayStyle({bool isDark = false}) {
  return isDark
      ? const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFF0B0C12),
          systemNavigationBarIconBrightness: Brightness.light,
        )
      : const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        );
}

Color getThemeTextColor({bool isDark = false}) {
  return isDark ? Colors.white : Colors.black;
}

Color getThemeSubTextColor({bool isDark = false}) {
  return isDark ? Colors.white70 : Colors.black54;
}

Color getThemeBackgroundColor({bool isDark = false}) {
  return isDark ? appBackgroundColorDark : appBackgroundColor;
}

Future<String> getDeviceId() async {
  try {
    final token = await FirebaseMessaging.instance.getToken();
    return token ?? '';
  } catch (e) {
    debugPrint('Error getting Firebase Token: $e');
  }
  return '';
}

String getSelectedIdFromTab(dynamic profileData, String fieldKey, {bool isPartner = false}) {
  if (profileData == null) return "";
  final tabs = isPartner ? profileData.partnerPreferenceTab : profileData.myProfileTab;
  if (tabs != null) {
    for (final tab in tabs) {
      if (tab.sectionValue != null) {
        for (final field in tab.sectionValue!) {
          final fk = field.key?.toLowerCase() ?? "";
          final tk = fieldKey.toLowerCase();
          if ((fk == tk || fk.contains(tk) || tk.contains(fk)) && field.selectedIds != null) {
            return field.selectedIds!.toString();
          }
        }
      }
    }
  }
  return "";
}

bool _parseBool(dynamic value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is num) return value == 1;
  final s = value.toString().toLowerCase().trim();
  return s == "1" || s == "true" || s == "yes";
}

dynamic getFieldValue(dynamic model, String key) => _getField(model, key);

dynamic _getField(dynamic model, String key) {
  if (model == null) return null;
  if (model is Map) {
    if (model.containsKey(key) && model[key] != null) return model[key];
    if (key == 'matchPercent' || key == 'match_percent' || key == 'matchRatio' || key == 'match_ratio' || key == 'matchPercentage' || key == 'match_percentage') {
      return model['matchPercent'] ?? model['match_percent'] ?? model['matchRatio'] ?? model['match_ratio'] ?? model['match_percentage'];
    }
    return model[key];
  }
  try {
    switch (key) {
      case 'matriId': return model.matriId;
      case 'matri_id': return model.matriId;
      case 'memberId': return model.memberId;
      case 'member_id': return model.memberId ?? model.id;
      case 'id': return model.id ?? model.memberId;
      case 'receiverMatriId': return model.receiverMatriId ?? model.matriId;
      case 'receiver_matri_id': return model.receiverMatriId ?? model.matriId;
      case 'receiverMemberId': return model.receiverMemberId ?? model.memberId ?? model.id;
      case 'receiver_member_id': return model.receiverMemberId ?? model.memberId ?? model.id;
      case 'fullname': return model.fullname ?? model.firstName ?? model.profileTitle;
      case 'name': return model.fullname ?? model.firstName ?? model.profileTitle;
      case 'planStatus': return model.planStatus;
      case 'plan_status': return model.planStatus;
      case 'isPhotoProtected': return model.isPhotoProtected;
      case 'is_photo_protected': return model.is_photo_protected;
      case 'photoVisibility': return model.photoVisibility;
      case 'photo_visibility': return model.photo_visibility;
      case 'isShortlisted': return model.isShortlisted;
      case 'is_shortlisted': return model.is_shortlisted;
      case 'isInterested': return model.isInterested;
      case 'is_interested': return model.is_interested;
      case 'isInterest': return model.isInterest;
      case 'is_interest': return model.is_interest;
      case 'isBlock': return model.isBlock;
      case 'is_block': return model.isBlock;
      case 'isBlocked': return model.isBlocked;
      case 'is_blocked': return model.isBlocked;
      case 'isBlockedBy': return model.isBlockedBy;
      case 'is_blocked_by': return model.is_blocked_by;
      case 'blockedBy': return model.blockedBy;
      case 'blocked_by': return model.blocked_by;
      case 'isBlockedMe': return model.isBlockedMe;
      case 'is_blocked_me': return model.is_blocked_me;
      case 'blockedMe': return model.blockedMe;
      case 'blocked_me': return model.blocked_me;
      case 'isBlockedByUser': return model.isBlockedByUser;
      case 'is_blocked_by_user': return model.is_blocked_by_user;
      case 'userBlockedYou': return model.userBlockedYou;
      case 'user_blocked_you': return model.user_blocked_you;
      case 'isChatBlocked': return model.isChatBlocked;
      case 'is_chat_blocked': return model.isChatBlocked;
      case 'interestState': return model.interestState;
      case 'interest_state': return model.interestState;
      case 'interestStatus': return model.interestStatus;
      case 'interest_status': return model.interestStatus;
      case 'interestId': return model.interestId;
      case 'interest_id': return model.interestId;
      case 'totalReminderCount': return model.totalReminderCount;
      case 'total_reminder_count': return model.totalReminderCount;
      case 'pendingReminderCount': return model.pendingReminderCount;
      case 'pending_reminder_count': return model.pendingReminderCount;
      case 'canSendReminder': return model.canSendReminder;
      case 'can_send_reminder': return model.canSendReminder;
      case 'videoCallSetting': return model.videoCallSetting;
      case 'video_call_setting': return model.videoCallSetting;
      case 'voiceCallSetting': return model.voiceCallSetting;
      case 'voice_call_setting': return model.voiceCallSetting;
      case 'matchPercent':
      case 'match_percent':
      case 'matchRatio':
      case 'match_ratio':
      case 'matchPercentage':
      case 'match_percentage':
        try {
          return model.matchPercent;
        } catch (_) {
          try {
            return model.matchRatio;
          } catch (_) {
            try {
              return model.matchPercentage;
            } catch (_) {}
          }
        }
        return null;
    }
  } catch (_) {}
  return null;
}

bool checkIsPhotoProtected(dynamic model) {
  if (model == null) return false;
  final isProtected = _getField(model, 'isPhotoProtected') ?? _getField(model, 'is_photo_protected');
  if (isProtected != null) {
    return _parseBool(isProtected);
  }
  final visibility = _getField(model, 'photoVisibility') ?? _getField(model, 'photo_visibility');
  if (visibility != null) {
    final visStr = visibility.toString().trim();
    return visStr == '0' || visStr == '2';
  }
  return false;
}

bool checkIsShortlisted(dynamic model) {
  if (model == null) return false;
  final isShort = _getField(model, 'isShortlisted') ?? _getField(model, 'is_shortlisted');
  return _parseBool(isShort);
}

bool checkIsInterest(dynamic model) {
  if (model == null) return false;

  // 1. Check interestState / interest_state
  final state = _getField(model, 'interestState') ?? _getField(model, 'interest_state');
  if (state != null) {
    final stateStr = state.toString().toLowerCase().trim();
    if (stateStr != 'not_sent' && stateStr != 'none' && stateStr.isNotEmpty) {
      return true;
    }
  }

  // 2. Check interestStatus / interest_status
  final status = _getField(model, 'interestStatus') ?? _getField(model, 'interest_status');
  if (status != null) {
    final statusStr = status.toString().toLowerCase().trim();
    if (statusStr != 'not_sent' && statusStr != 'none' && statusStr != '0' && statusStr.isNotEmpty) {
      return true;
    }
  }

  // 3. Check interestId / interest_id
  final interestId = _getField(model, 'interestId') ?? _getField(model, 'interest_id');
  if (interestId != null) {
    final idStr = interestId.toString().trim();
    if (idStr.isNotEmpty && idStr != '0' && idStr != 'null') {
      return true;
    }
  }

  // 4. Check boolean & numeric flags
  final isInt = _getField(model, 'isInterested') ?? 
                _getField(model, 'is_interested') ?? 
                _getField(model, 'isInterest') ?? 
                _getField(model, 'is_interest') ??
                _getField(model, 'my_interest') ??
                _getField(model, 'interest');
  return _parseBool(isInt);
}

bool checkIsInterestAccepted(dynamic model) {
  if (model == null) return false;
  final status = (_getField(model, 'interestStatus') ?? _getField(model, 'interest_status'))?.toString().toLowerCase().trim() ?? '';
  final state = (_getField(model, 'interestState') ?? _getField(model, 'interest_state'))?.toString().toLowerCase().trim() ?? '';
  return status == 'accepted' || status == 'approved' || status == '1' || state == 'accepted' || state == 'approved';
}

bool checkIsInterestRejected(dynamic model) {
  if (model == null) return false;
  final status = (_getField(model, 'interestStatus') ?? _getField(model, 'interest_status'))?.toString().toLowerCase().trim() ?? '';
  final state = (_getField(model, 'interestState') ?? _getField(model, 'interest_state'))?.toString().toLowerCase().trim() ?? '';
  return status == 'rejected' || status == 'declined' || state == 'rejected' || state == 'declined';
}


bool checkIsBlocked(dynamic model) {
  if (model == null) return false;
  final isBlk = _getField(model, 'isBlock') ?? 
                _getField(model, 'is_block') ?? 
                _getField(model, 'isBlocked') ?? 
                _getField(model, 'is_blocked') ??
                _getField(model, 'isBlockedByMe') ??
                _getField(model, 'is_blocked_by_me') ??
                _getField(model, 'isChatBlocked') ??
                _getField(model, 'is_chat_blocked');
  if (isBlk != null) {
    return _parseBool(isBlk);
  }
  if (model is Map) {
    final b = model['is_block'] ?? model['is_blocked'] ?? model['is_chat_blocked'] ?? model['is_blocked_by_me'];
    if (b != null) return _parseBool(b);
  }
  return false;
}

bool checkIsBlockedByUser(dynamic model) {
  if (model == null) return false;
  final isBlkBy = _getField(model, 'isBlockedBy') ?? 
                  _getField(model, 'is_blocked_by') ?? 
                  _getField(model, 'blockedBy') ?? 
                  _getField(model, 'blocked_by') ?? 
                  _getField(model, 'isBlockedMe') ?? 
                  _getField(model, 'is_blocked_me') ?? 
                  _getField(model, 'blockedMe') ?? 
                  _getField(model, 'blocked_me') ?? 
                  _getField(model, 'isBlockedByUser') ?? 
                  _getField(model, 'is_blocked_by_user') ?? 
                  _getField(model, 'userBlockedYou') ?? 
                  _getField(model, 'user_blocked_you');
  if (isBlkBy != null) {
    return _parseBool(isBlkBy);
  }
  if (model is Map) {
    final b = model['is_blocked_by'] ?? model['blocked_by'] ?? model['is_blocked_me'] ?? model['blocked_me'] ?? model['is_blocked_by_user'] ?? model['user_blocked_you'];
    if (b != null) return _parseBool(b);
  }
  return false;
}

bool checkIsPaid(dynamic model) {
  if (model == null) return false;
  final status = _getField(model, 'planStatus') ?? _getField(model, 'plan_status');
  if (status != null) {
    final statusStr = status.toString().trim().toLowerCase();
    if (statusStr == 'paid') return true;
  }
  if (model is Map) {
    final statusMap = model['plan_status'] ?? model['planStatus'];
    if (statusMap != null) {
      return statusMap.toString().trim().toLowerCase() == 'paid';
    }
  }
  return false;
}



