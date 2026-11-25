import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_matrimony/widgets/search_figma_widgets.dart';
import 'package:pro_matrimony/utils/app_dialogs.dart';
import 'package:pro_matrimony/utils/utils.dart';

import '../providers/search_notifier.dart';
import 'search_result_screen.dart';

class IdSearchScreen extends ConsumerStatefulWidget {
  const IdSearchScreen({super.key});

  @override
  ConsumerState<IdSearchScreen> createState() => _IdSearchScreenState();
}

class _IdSearchScreenState extends ConsumerState<IdSearchScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextBoldStyle(
              'save_by_id'.tr,
              16,
              TextAlign.start,
              theme.colorScheme.onSurface,
            ),
            const Gap(6),
            customTextNormalStyle(
              'find_by_id_search'.tr,
              13,
              TextAlign.start,
              isDark ? const Color(0xFF8E90A6) : const Color(0xFF6E7085),
            ),
            const Gap(24),
            Form(
              key: _formKey,
              child: SearchIconTextField(
                labelText: 'find_by_id'.tr,
                controller: _idController,
                hint: 'find_by_id'.tr,
                validator: (v) =>
                    v?.trim().isEmpty ?? true ? 'empty_field_error'.tr : null,
              ),
            ),
            const Gap(24),
            // Action Buttons Row (Figma Side-by-side circular save + gradient search)
            Row(
              children: [
                GestureDetector(
                  onTap: () => _showSaveSearchDialog(context),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isDark ? darkSecondary : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.dividerColor, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.icSaveSearch,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
                const Gap(14),
                Expanded(
                  child: GestureDetector(
                    onTap: _performSearch,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: FigmaColors.primaryGradient(context),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          FigmaColors.buttonShadow(context),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'search_profile'.tr,
                        style: AppFont.font(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(searchCriteriaProvider.notifier)
          .updateCriteria(SearchCriteria(matriId: _idController.text.trim()));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SearchResultScreen()),
      );
    }
  }

  void _showSaveSearchDialog(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final name = await AppDialogs.showSaveSearch(
      context,
      pageName: "ID Search",
    );
    if (name != null) {
      final params = {
        "search_page_name": "ID Search",
        "search_name": name,
        "id_search": _idController.text.trim(),
      };
      final success = await ref
          .read(savedSearchProvider.notifier)
          .saveSearch(params);
      if (success) _performSearch();
    }
  }
}
