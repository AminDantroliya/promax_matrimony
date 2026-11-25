import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/app_theme.dart';
import 'package:pro_matrimony/core/localization/language_provider.dart';
import 'package:pro_matrimony/config/app_config.dart';
import 'package:pro_matrimony/config/providers/config_providers.dart';
import 'package:pro_matrimony/features/auth/screens/register2/models/dynamic_form_models.dart';
import 'package:pro_matrimony/features/common/data/models/dropdown_models.dart';
import 'package:pro_matrimony/features/common/providers/dropdown_notifier.dart';
import 'package:pro_matrimony/utils/app_assets.dart';
import 'package:pro_matrimony/widgets/app_input_field_style.dart';
import 'package:pro_matrimony/widgets/app_loading_widget.dart';
import 'package:pro_matrimony/widgets/search_figma_widgets.dart';
import '../providers/dynamic_search_notifier.dart';

class DynamicSearchRenderer extends ConsumerWidget {
  final String searchType;
  final String searchPageTitle;
  final bool isAiMatch;
  final Widget? headerWidget;

  const DynamicSearchRenderer({
    super.key,
    required this.searchType,
    required this.searchPageTitle,
    this.isAiMatch = false,
    this.headerWidget,
  });

  IconData _resolveFieldIcon(String fieldName) {
    final n = fieldName.toLowerCase().replaceAll('_', '').replaceAll('-', '');

    if (n.contains('marital')) return CupertinoIcons.heart;
    if (n.contains('mothertongue') || n.contains('language')) {
      return CupertinoIcons.waveform_circle;
    }
    if (n.contains('religion')) return CupertinoIcons.star;
    if (n.contains('caste') || n.contains('subcaste')) return CupertinoIcons.person_3;
    if (n.contains('country')) return CupertinoIcons.globe;
    if (n.contains('state')) return CupertinoIcons.map;
    if (n.contains('city')) return CupertinoIcons.location;
    if (n.contains('education')) return CupertinoIcons.book;
    if (n.contains('occupation')) return CupertinoIcons.briefcase;
    if (n.contains('employee')) return CupertinoIcons.building_2_fill;
    if (n.contains('designation')) {
      return CupertinoIcons.person_crop_circle_badge_checkmark;
    }
    if (n.contains('income')) return CupertinoIcons.money_dollar;
    if (n.contains('manglik')) return CupertinoIcons.flame;
    if (n.contains('star')) return CupertinoIcons.sparkles;
    if (n.contains('diet') || n.contains('eating')) return Icons.restaurant_outlined;
    if (n.contains('smoke')) return Icons.smoking_rooms_outlined;
    if (n.contains('drink')) return Icons.local_bar_outlined;
    if (n.contains('bodytype')) return Icons.accessibility_new_rounded;
    if (n.contains('skintone') || n.contains('complexion')) {
      return Icons.face_retouching_natural_rounded;
    }
    if (n.contains('blood')) return Icons.water_drop_outlined;
    if (n.contains('profileby')) return CupertinoIcons.person_crop_circle;
    if (n.contains('gender')) return CupertinoIcons.person_2;
    if (n.contains('horoscope')) return CupertinoIcons.moon_stars;

    return CupertinoIcons.line_horizontal_3_decrease_circle;
  }

  List<DropdownOptionModel> _resolveDropdownItems({
    required FormFieldModel field,
    required DropdownData? globalDropdowns,
    required Map<String, List<DropdownOptionModel>> dependentOptions,
  }) {
    // 1. Check cached dependent options first
    if (field.type == 'dependent_dropdown' || field.parentField != null) {
      final cached = dependentOptions[field.name];
      if (cached != null && cached.isNotEmpty) return cached;
    }

    // 2. Resolve from global dropdowns
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
        case 'eatinghabits':
          list = globalDropdowns.diet;
          break;
        case 'smoke':
        case 'smokelist':
        case 'smoking':
        case 'smokinghabit':
        case 'smokinghabitlist':
        case 'smokinghabits':
          list = globalDropdowns.smoke;
          break;
        case 'drink':
        case 'drinklist':
        case 'drinking':
        case 'drinkinghabit':
        case 'drinkinghabitlist':
        case 'drinkinghabits':
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
      }

      if (list != null && list.isNotEmpty) {
        return list;
      }
    }

    // 3. Fallback to inline field options
    if (field.options != null && field.options!.isNotEmpty) {
      return field.options!
          .map((o) => DropdownOptionModel(id: o.id, val: o.label))
          .toList();
    }

    return [];
  }

  List<DropdownOptionModel> _castToOptionList(
    dynamic val,
    List<DropdownOptionModel> allItems,
  ) {
    if (val == null) return [];
    if (val is List<DropdownOptionModel>) return val;
    if (val is DropdownOptionModel) return [val];
    if (val is List) {
      final list = <DropdownOptionModel>[];
      for (final item in val) {
        if (item is DropdownOptionModel) {
          list.add(item);
        } else if (item != null) {
          final s = item.toString();
          final match = allItems.cast<DropdownOptionModel?>().firstWhere(
                (e) => e?.id?.toString() == s || e?.val?.toString() == s,
                orElse: () => null,
              );
          if (match != null) {
            list.add(match);
          } else {
            list.add(DropdownOptionModel(id: s, val: s));
          }
        }
      }
      return list;
    }
    final s = val.toString();
    if (s.contains(',')) {
      final parts = s.split(',').map((p) => p.trim()).where((p) => p.isNotEmpty);
      final list = <DropdownOptionModel>[];
      for (final part in parts) {
        final match = allItems.cast<DropdownOptionModel?>().firstWhere(
              (e) => e?.id?.toString() == part || e?.val?.toString() == part,
              orElse: () => null,
            );
        list.add(match ?? DropdownOptionModel(id: part, val: part));
      }
      return list;
    }
    final match = allItems.cast<DropdownOptionModel?>().firstWhere(
          (e) => e?.id?.toString() == s || e?.val?.toString() == s,
          orElse: () => null,
        );
    return [match ?? DropdownOptionModel(id: s, val: s)];
  }

  String _formatRangeLabel({
    required FormFieldModel field,
    required RangeValues range,
    required double min,
    required double max,
    required DropdownData? globalDropdowns,
  }) {
    if (field.name.contains('age')) {
      return "${range.start.round()} Year - ${range.end.round()} Year";
    }

    if (field.name.contains('height')) {
      final start = range.start.round();
      final end = range.end.round();
      if (max <= 100) {
        final sFt = start ~/ 12;
        final sIn = start % 12;
        final eFt = end ~/ 12;
        final eIn = end % 12;
        return "$sFt-$sIn ft - $eFt-$eIn ft";
      }
      return "$start cm - $end cm";
    }

    return "${range.start.round()} - ${range.end.round()}";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = searchType == 'quick_search'
        ? dynamicQuickSearchProvider
        : (searchType == 'ai_match_search' || isAiMatch
            ? dynamicAiMatchProvider
            : dynamicAdvancedSearchProvider);
    final searchState = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final globalDropdownsAsync = ref.watch(allDropdownsProvider);
    final globalDropdowns = globalDropdownsAsync.asData?.value;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final config = ref.watch(appConfigProvider);

    if (searchState.isLoadingSchema) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: const Center(child: AppLoadingWidget()),
      );
    }

    if (searchState.error != null && searchState.schema.sections.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'failed_to_load_options'.tr,
                style: AppFont.font(fontSize: 16),
              ),
              const Gap(12),
              ElevatedButton(
                onPressed: () => notifier.fetchSchema(),
                child: Text('retry'.tr),
              ),
            ],
          ),
        ),
      );
    }

    final fields = searchState.schema.sections
        .expand((sec) => sec.fields)
        .where((f) => f.showIf == null || f.showIf!.isVisible(searchState.formValues))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerWidget != null) ...[
          headerWidget!,
          const Gap(16),
        ],

        // For AI Match, if min_match_percentage is not in schema fields, render compatibility score card at top
        if ((isAiMatch || searchType == 'ai_match_search') &&
            !fields.any((f) =>
                f.name.contains('compatibility') ||
                f.name.contains('match_percentage') ||
                f.type == 'single_slider')) ...[
          _buildCompatibilityScoreCard(
            context: context,
            field: const FormFieldModel(
              name: 'min_match_percentage',
              label: 'Min Compatibility Score',
              type: 'single_slider',
            ),
            value: (searchState.formValues['min_match_percentage'] is num
                ? (searchState.formValues['min_match_percentage'] as num).toInt()
                : 60),
            onChanged: (val) => notifier.updateFieldValue('min_match_percentage', val),
            isDark: isDark,
            theme: theme,
          ),
          const Gap(16),
        ],

        for (final field in fields) ...[
          _buildField(
            context: context,
            field: field,
            searchState: searchState,
            notifier: notifier,
            globalDropdowns: globalDropdowns,
            theme: theme,
            isDark: isDark,
            config: config,
          ),
          const Gap(16),
        ],

        const Gap(8),

        // ── Action Buttons Row ──────────────────────────────────────────────
        if (isAiMatch || searchType == 'ai_match_search')
          Row(
            children: [
              // Reset Button
              GestureDetector(
                onTap: () => notifier.resetFilters(),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.12)
                          : const Color(0xFFE5E7EB),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.refresh_rounded,
                    color: isDark ? Colors.white70 : const Color(0xFF6B7280),
                    size: 22,
                  ),
                ),
              ),
              const Gap(14),
              Expanded(
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: FigmaColors.primaryGradient(context),
                    borderRadius: AppTheme.getButtonBorderRadius(context),
                    boxShadow: [
                      BoxShadow(
                        color: theme.primaryColor.withValues(alpha: 0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (notifier is DynamicAiMatchNotifier) {
                        notifier.executeAiMatchSearch(context);
                      } else {
                        notifier.performSearch(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppTheme.getButtonBorderRadius(context),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.figmaAiFilter,
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          'find_ai_matches'.tr,
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
              ),
            ],
          )
        else
          Row(
            children: [
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  onPressed: () => notifier.saveSearch(context, searchPageTitle),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: theme.primaryColor, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.getButtonBorderRadius(context),
                    ),
                  ),
                  child: Text(
                    'save_search'.tr,
                    style: AppFont.font(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                flex: 3,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: AppTheme.getButtonBorderRadius(context),
                    gradient: LinearGradient(
                      colors: [
                        theme.primaryColor,
                        theme.primaryColor.withValues(alpha: 0.85),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.primaryColor.withValues(alpha: 0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () => notifier.performSearch(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppTheme.getButtonBorderRadius(context),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        const Gap(8),
                        Text(
                          'search_now'.tr,
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
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildField({
    required BuildContext context,
    required FormFieldModel field,
    required DynamicSearchState searchState,
    required DynamicSearchBaseNotifier notifier,
    required DropdownData? globalDropdowns,
    required ThemeData theme,
    required bool isDark,
    required AppConfig? config,
  }) {
    final rawValue = searchState.formValues[field.name];

    if (field.name.contains('compatibility') ||
        field.name.contains('match_percentage') ||
        field.type == 'single_slider') {
      final currentVal = (rawValue is num
              ? rawValue.toInt()
              : int.tryParse(rawValue?.toString() ?? '')) ??
          60;
      return _buildCompatibilityScoreCard(
        context: context,
        field: field,
        value: currentVal,
        onChanged: (val) => notifier.updateFieldValue(field.name, val),
        isDark: isDark,
        theme: theme,
      );
    }

    switch (field.type) {
      case 'range_slider':
        final double min = field.minVal ??
            (field.name.contains('height') ? 48.0 : 18.0);
        final double max = (field.maxVal != null && field.maxVal! > min)
            ? field.maxVal!
            : (field.name.contains('height') ? 84.0 : 60.0);

        final RangeValues currentRange;
        if (rawValue is RangeValues) {
          final s = rawValue.start.clamp(min, max);
          final e = rawValue.end.clamp(min, max);
          currentRange = RangeValues(s <= e ? s : min, s <= e ? e : max);
        } else if (field.defaultRange != null && field.defaultRange!.length >= 2) {
          final s = field.defaultRange![0].clamp(min, max);
          final e = field.defaultRange![1].clamp(min, max);
          currentRange = RangeValues(s <= e ? s : min, s <= e ? e : max);
        } else {
          currentRange = RangeValues(min, max);
        }

        final displayVal = _formatRangeLabel(
          field: field,
          range: currentRange,
          min: min,
          max: max,
          globalDropdowns: globalDropdowns,
        );

        final divisions = (max - min).round().clamp(1, 500);

        return SearchRangeBar(
          title: field.label,
          displayValue: displayVal,
          values: currentRange,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: (v) => notifier.updateFieldValue(field.name, v),
        );

      case 'checkbox':
      case 'switch':
        final isChecked = rawValue == true ||
            rawValue?.toString().toLowerCase() == 'yes' ||
            rawValue?.toString() == '1';
        final isUnderlined = AppInputFieldStyle.resolveDesign(config) == 'underlined';

        return Container(
          padding: isUnderlined
              ? const EdgeInsets.symmetric(horizontal: 4, vertical: 12)
              : const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: AppInputFieldStyle.buildContainerDecoration(
            context: context,
            config: config,
            suppressUnderline: true,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withValues(alpha: isDark ? 0.2 : 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.photo_camera_outlined,
                      color: theme.primaryColor,
                      size: 20,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    field.label,
                    style: AppFont.font(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF16182F),
                    ),
                  ),
                ],
              ),
              CupertinoSwitch(
                value: isChecked,
                activeTrackColor: theme.primaryColor,
                onChanged: (val) => notifier.updateFieldValue(field.name, val),
              ),
            ],
          ),
        );

      case 'multi_select_dropdown':
      case 'single_select_dropdown':
      case 'dependent_dropdown':
      case 'segment_selector':
      case 'radio_group':
      default:
        final items = _resolveDropdownItems(
          field: field,
          globalDropdowns: globalDropdowns,
          dependentOptions: searchState.dependentOptions,
        );
        final selectedList = _castToOptionList(rawValue, items);
        final icon = _resolveFieldIcon(field.name);

        return SearchIconDropdown(
          labelText: field.label,
          icon: icon,
          items: items,
          selectedItems: selectedList,
          isShowSearch: items.length > 8,
          onChanged: (selectedOptions) {
            notifier.updateFieldValue(field.name, selectedOptions);

            // Cascade dependent options if needed (e.g. religion -> caste, country -> state -> city)
            final allSections = searchState.schema.sections;
            final allFields = allSections.expand((s) => s.fields).toList();

            for (final nextField in allFields) {
              if (nextField.parentField == field.name) {
                notifier.updateFieldValue(nextField.name, <DropdownOptionModel>[]);
                final parentIds = selectedOptions
                    .map((e) => e.id.toString())
                    .where((id) => id.isNotEmpty)
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
        );
    }
  }

  Widget _buildCompatibilityScoreCard({
    required BuildContext context,
    required FormFieldModel field,
    required int value,
    required ValueChanged<int> onChanged,
    required bool isDark,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF13141F) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : const Color(0xFFF0F0F5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : const Color(0xFFF3EEF7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.figmaCompatibilityScore,
                    width: 18,
                    height: 18,
                    colorFilter: ColorFilter.mode(
                      theme.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    field.label.isNotEmpty ? field.label : 'min_compatibility_score'.tr,
                    style: AppFont.font(
                      color: isDark ? Colors.white : const Color(0xFF16182F),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'compatibility_score_subtitle'.tr,
                    style: AppFont.font(
                      color: isDark ? Colors.white38 : const Color(0xFF8E90A6),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '$value%',
                style: AppFont.font(
                  color: theme.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const Gap(12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 5,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 9,
                elevation: 3,
              ),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
              activeTrackColor: theme.primaryColor,
              inactiveTrackColor: isDark
                  ? Colors.white10
                  : const Color(0xFFE5E7EB),
              thumbColor: Colors.white,
              overlayColor: theme.primaryColor.withValues(alpha: 0.12),
            ),
            child: Slider(
              value: value.toDouble().clamp(0, 100),
              min: 0,
              max: 100,
              divisions: 20,
              onChanged: (v) => onChanged(v.round()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0%',
                  style: AppFont.font(
                    color: isDark ? Colors.white30 : const Color(0xFF8E90A6),
                    fontSize: 11,
                  ),
                ),
                Text(
                  '50%',
                  style: AppFont.font(
                    color: isDark ? Colors.white30 : const Color(0xFF8E90A6),
                    fontSize: 11,
                  ),
                ),
                Text(
                  '100%',
                  style: AppFont.font(
                    color: isDark ? Colors.white30 : const Color(0xFF8E90A6),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
