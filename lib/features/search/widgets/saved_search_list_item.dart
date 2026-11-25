import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_matrimony/utils/app_dialogs.dart';
import 'package:pro_matrimony/utils/utils.dart';

import '../../../features/search/data/models/search_models.dart';
import '../providers/search_notifier.dart';
import '../screens/search_result_screen.dart';

class SavedSearchListItem extends ConsumerStatefulWidget {
  final SavedSearchFilter model;
  const SavedSearchListItem({super.key, required this.model});

  @override
  ConsumerState<SavedSearchListItem> createState() => _SavedSearchListItemState();
}

class _SavedSearchListItemState extends ConsumerState<SavedSearchListItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF13141F) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          width: 1,
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : const Color(0xFFE8E8F0),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AnimatedCrossFade(
                firstChild: InkWell(
                  onTap: () => setState(() => _isExpanded = true),
                  child: _buildHeader(context, ref, isDark, isExpanded: false),
                ),
                secondChild: Column(
                  children: [
                    InkWell(
                      onTap: () => setState(() => _isExpanded = false),
                      child: _buildHeader(context, ref, isDark, isExpanded: true),
                    ),
                    const Gap(16),
                    _buildDetails(context, isDark),
                    const Gap(20),
                    _buildActionButtons(context, ref, isDark),
                  ],
                ),
                crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref, bool isDark, {required bool isExpanded}) {
    final model = widget.model;

    // Resolve SVG icon based on search page type
    String typeIconSvg = AppAssets.figmaSearchOutline;
    if (model.searchPageName == "Advance Search") {
      typeIconSvg = AppAssets.figmaSearchOutline;
    } else if (model.searchPageName == "ID Search") {
      typeIconSvg = AppAssets.figmaAadhaar;
    }

    return Row(
      children: [
        // Left Squircle Icon Container
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            gradient: isExpanded
                ? FigmaColors.primaryGradient(context)
                : null,
            color: isExpanded
                ? null
                : (isDark ? const Color(0xFF22163B) : const Color(0xFFF3EEF7)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: SvgPicture.asset(
              typeIconSvg,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                isExpanded ? Colors.white : Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const Gap(12),

        // Text details (Title and Date)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.searchName ?? model.searchPageName ?? 'my_saved_search'.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppFont.font(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const Gap(4),
              Row(
                children: [
                  SvgPicture.asset(
                    typeIconSvg,
                    width: 12,
                    height: 12,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                      BlendMode.srcIn,
                    ),
                  ),
                  const Gap(4),
                  Expanded(
                    child: Text(
                      "${getFormattedDateSavedSearch(model.createdAt?.toString() ?? "N/A")}${model.searchName != null ? " • ${model.searchPageName ?? ""}" : ""}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.font(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Gap(8),

        // Delete Button
        InkWell(
          onTap: () => _deleteRecord(context, ref),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF3F1A1D) : const Color(0xFFFFF1F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.icDelete,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFEF4444),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetails(BuildContext context, bool isDark) {
    final model = widget.model;
    final List<Map<String, dynamic>> details = [];

    // Helper to find a value by key in displayValues
    String? findDisplayVal(String key) {
      if (model.displayValues == null) return null;
      try {
        final item = model.displayValues!.firstWhere((e) => e["key"] == key);
        return item["value"]?.toString();
      } catch (_) {
        return null;
      }
    }

    if (model.displayValues != null && model.displayValues!.isNotEmpty) {
      // 1. AGE
      String? ageVal = findDisplayVal("part_age");
      if (ageVal == null || ageVal.trim().isEmpty || ageVal.trim() == "," || ageVal.trim() == ",,") {
        final fromAge = model.fromAgeStr ?? model.fromAge;
        final toAge = model.toAgeStr ?? model.toAge;
        if (fromAge != null && toAge != null) {
          ageVal = "$fromAge - $toAge Years";
        }
      }
      if (ageVal != null && ageVal.trim().isNotEmpty && ageVal != "null") {
        details.add({
          "label": 'age_caps'.tr,
          "value": ageVal,
          "svgPath": AppAssets.figmaPeople,
        });
      }

      // 2. EDUCATION
      String? eduVal = findDisplayVal("education_level") ?? findDisplayVal("education") ?? model.educationStr?.toString();
      if (eduVal != null && eduVal.trim().isNotEmpty && eduVal != "N/A" && eduVal != "null") {
        details.add({
          "label": 'education_caps'.tr,
          // "value": eduVal.split(',').first.trim(),
          "value": eduVal,
          "svgPath": AppAssets.figmaEducation,
        });
      }

      // 3. PLACE
      String? countryVal = findDisplayVal("country") ?? model.countryStr?.toString();
      String? stateVal = findDisplayVal("state") ?? model.stateStr?.toString();
      String? c = countryVal?.split(',').firstOrNull?.trim();
      String? s = stateVal?.split(',').firstOrNull?.trim();
      String? place = [if (s != null && s.isNotEmpty && s != "N/A") s, if (c != null && c.isNotEmpty && c != "N/A") c].join(", ");
      if (place.trim().isNotEmpty) {
        details.add({
          "label": 'place_caps'.tr,
          "value": place,
          "svgPath": AppAssets.figmaLocation,
        });
      }

      // 4. INCOME
      String? incVal = findDisplayVal("income") ?? model.incomeStr?.toString();
      if (incVal != null && incVal.trim().isNotEmpty && incVal != "N/A" && incVal != "null") {
        details.add({
          "label": 'income_caps'.tr,
          // "value": incVal.split(',').first.trim(),
          "value": incVal,
          "svgPath": AppAssets.figmaPassbook,
        });
      }

      // 5. RELIGION
      String? relVal = findDisplayVal("religion") ?? model.religionStr?.toString();
      if (relVal != null && relVal.trim().isNotEmpty && relVal != "N/A" && relVal != "null") {
        details.add({
          "label": 'religion_caps'.tr,
          // "value": relVal.split(',').first.trim(),
          "value": relVal,
          "svgPath": AppAssets.figmaReligion,
        });
      }

      // 6. CITY
      String? cityVal = findDisplayVal("city") ?? model.cityStr?.toString();
      String? ct = cityVal?.split(',').firstOrNull?.trim();
      String? cityState = [if (ct != null && ct.isNotEmpty && ct != "N/A") ct, if (s != null && s.isNotEmpty && s != "N/A") s].join(", ");
      if (cityState.trim().isNotEmpty) {
        details.add({
          "label": 'city_caps'.tr,
          "value": cityState,
          "svgPath": AppAssets.figmaHome,
        });
      }

      // If details is empty, fallback to parsing displayValues generally
      if (details.isEmpty) {
        for (final dv in model.displayValues!) {
          final key = dv["key"]?.toString();
          final label = dv["label"]?.toString();
          final value = dv["value"]?.toString();
          if (value == null || value.trim().isEmpty || value.trim() == "," || value.trim() == ",,") {
            continue;
          }
          String labelUpper = label?.toUpperCase() ?? "";
          String svgPath = AppAssets.figmaPeople;
          if (key == "marital_status") {
            labelUpper = 'marital_status_caps'.tr;
            svgPath = AppAssets.figmaSendInterest;
          } else if (key == "with_photo") {
            labelUpper = 'with_photo_caps'.tr;
            svgPath = AppAssets.figmaCamera;
          } else if (key == "mother_tongue") {
            labelUpper = 'mother_tongue_caps'.tr;
            svgPath = AppAssets.icLanguage;
          }
          details.add({
            "label": labelUpper,
            // "value": value.split(',').first.trim(),
            "value": value,
            "svgPath": svgPath,
          });
        }
      }
    } else {
      // Complete Fallback for older searches
      if (model.searchPageName == "ID Search") {
        details.add({
          "label": 'find_by_id_caps'.tr,
          "value": model.idSearch?.toString() ?? "N/A",
          "svgPath": AppAssets.figmaAadhaar,
        });
      } else {
        final fromAge = model.fromAgeStr ?? model.fromAge;
        final toAge = model.toAgeStr ?? model.toAge;
        if (fromAge != null && toAge != null) {
          details.add({
            "label": 'age_caps'.tr,
            "value": "$fromAge - $toAge Years",
            "svgPath": AppAssets.figmaPeople,
          });
        }
        final fromHeight = model.fromHeightStr;
        final toHeight = model.toHeightStr;
        if (fromHeight != null && toHeight != null) {
          details.add({
            "label": 'height_caps'.tr,
            "value": "$fromHeight - $toHeight",
            "svgPath": AppAssets.figmaGym,
          });
        }
        if (model.maritalStatus != null && model.maritalStatus.toString().isNotEmpty && model.maritalStatus.toString() != "N/A") {
          details.add({
            "label": 'marital_status_caps'.tr,
            // "value": model.maritalStatus.toString().split(',').first.trim(),
            "value": model.maritalStatus,
            "svgPath": AppAssets.figmaSendInterest,
          });
        }
        if (model.religionStr != null && model.religionStr.toString().isNotEmpty && model.religionStr.toString() != "N/A") {
          details.add({
            "label": 'religion_caps'.tr,
            // "value": model.religionStr.toString().split(',').first.trim(),
            "value": model.religionStr,
            "svgPath": AppAssets.figmaReligion,
          });
        }
        final place = [
          if (model.cityStr != null && model.cityStr.toString() != "N/A") model.cityStr.toString().split(',').first.trim(),
          if (model.countryStr != null && model.countryStr.toString() != "N/A") model.countryStr.toString().split(',').first.trim(),
        ].join(", ");
        if (place.isNotEmpty) {
          details.add({
            "label": 'place_caps'.tr,
            "value": place,
            "svgPath": AppAssets.figmaLocation,
          });
        }
        if (model.educationStr != null && model.educationStr.toString().isNotEmpty && model.educationStr.toString() != "N/A") {
          details.add({
            "label": 'education_caps'.tr,
            // "value": model.educationStr.toString().split(',').first.trim(),
            "value": model.educationStr,
            "svgPath": AppAssets.figmaEducation,
          });
        }
      }
    }

    if (details.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: details.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.3,
      ),
      itemBuilder: (context, index) {
        final item = details[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C1D2A) : const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: isDark ? Colors.white.withValues(alpha: 0.03) : const Color(0xFFF0F0F5),
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                item["svgPath"] as String,
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF7342EB),
                  BlendMode.srcIn,
                ),
              ),
              const Gap(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item["label"] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.font(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: const Color(0xFF8D94AB),
                      ),
                    ),
                    const Gap(2),
                    Text(
                      item["value"] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.font(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, bool isDark) {
    return InkWell(
      onTap: () => _searchNow(context, ref),
      borderRadius: AppTheme.getButtonBorderRadius(context),
      child: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: FigmaColors.primaryGradient(context),
          borderRadius: AppTheme.getButtonBorderRadius(context),
          boxShadow: [
            FigmaColors.buttonShadow(context),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.figmaSearchOutline,
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            const Gap(6),
            Text(
              'btn_view_results'.tr,
              style: AppFont.font(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searchNow(BuildContext context, WidgetRef ref) {
    final model = widget.model;
    final Map<String, dynamic> params = {};
    if (model.searchPageName == "ID Search") {
      params["matri_id"] = model.idSearch?.toString() ?? "";
    } else {
      params["from_age"] = model.fromAge?.toString() ?? "";
      params["to_age"] = model.toAge?.toString() ?? "";
      params["from_height"] = model.fromHeight?.toString() ?? "";
      params["to_height"] = model.toHeight?.toString() ?? "";
      params["marital_status"] = model.maritalStatus?.toString() ?? "";
      params["religion"] = model.religion?.toString() ?? "";
      params["caste"] = model.caste?.toString() ?? "";
      params["country_id"] = model.country?.toString() ?? "";
      params["state_id"] = model.state?.toString() ?? "";
      params["photo_search"] = model.withPhoto?.toString() ?? "";
      
      if (model.searchPageName == "Advance Search") {
        params["education_level"] = model.educationLevel?.toString() ?? "";
        params["occupation"] = model.occupation?.toString() ?? "";
        params["income"] = model.income?.toString() ?? "";
        params["mother_tongue"] = model.motherTongue?.toString() ?? "";
      }
    }
    
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => SearchResultScreen(initialParams: params),
    ));
  }

  Future<void> _deleteRecord(BuildContext context, WidgetRef ref) async {
    final model = widget.model;
    final confirm = await AppDialogs.confirm(
      context,
      title: 'delete'.tr,
      message: 'delete_confirm_msg'.tr,
      confirmLabel: 'delete'.tr,
    );

    if (confirm == true) {
      if (!context.mounted) return;
      showLoading(context);
      final success = await ref.read(savedSearchProvider.notifier).deleteSavedSearch(model.id.toString());
      hideLoading();
      if (!success) {
        showToast('failed_delete_saved_search'.tr);
      }
    }
  }
}
