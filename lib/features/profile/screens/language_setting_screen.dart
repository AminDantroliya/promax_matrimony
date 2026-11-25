import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';

class LanguageSettingScreen extends ConsumerWidget {
  const LanguageSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeNotifier = ref.read(languageProvider.notifier);
    final currentLocale = ref.watch(languageProvider);
    final languages = localeNotifier.languages;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppAppBar(title: 'app_language'.tr, isShowActions: false),
            Padding(
              padding: EdgeInsets.fromLTRB(
                getProportionateScreenWidth(20),
                getProportionateScreenHeight(20),
                getProportionateScreenWidth(20),
                getProportionateScreenHeight(10),
              ),
              child: Text(
                'app_language'.tr,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(22),
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(14),
                  vertical: getProportionateScreenHeight(8),
                ),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final lang = languages[index];
                  final isSelected = lang.code == currentLocale.languageCode;
                  return Padding(
                    padding: EdgeInsets.only(bottom: getProportionateScreenHeight(8)),
                    child: InkWell(
                      onTap: () => localeNotifier.changeLanguage(lang.code, lang.country),
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(12),
                          vertical: getProportionateScreenHeight(12),
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.transparent : (Theme.of(context).colorScheme.surface),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? appPrimaryColor : Colors.transparent,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lang.name,
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(16),
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                      color: isSelected ? appPrimaryColor : Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                  if (lang.subtitle.isNotEmpty) ...[
                                    const Gap(4),
                                    Text(
                                      lang.subtitle,
                                      style: TextStyle(
                                        fontSize: getProportionateScreenWidth(13),
                                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? (isDark ? appPrimaryColor : Colors.grey.shade300)
                                    : (isDark ? Colors.white.withValues(alpha: 0.08) : Colors.white),
                                border: Border.all(
                                  color: isSelected
                                      ? appPrimaryColor
                                      : (isDark ? Colors.white30 : Colors.grey.shade300),
                                  width: isSelected ? 5 : 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
