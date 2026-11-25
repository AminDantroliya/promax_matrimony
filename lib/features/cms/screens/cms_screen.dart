import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/app_app_bar.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/app_no_records_widget.dart';

import '../data/models/cms_models.dart';
import '../providers/cms_notifier.dart';

class CMSScreen extends ConsumerWidget {
  final String slug;
  final String title;
  const CMSScreen({super.key, required this.slug, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cmsAsync = ref.watch(cMSProvider(slug));
    final unescape = HtmlUnescape();

    return AnnotatedRegion(
      value: getThemeSystemUiOverlayStyle(isDark: isDarkMode),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              cmsAsync.when(
                data: (data) => AppAppBar(
                  title: (data?.pageTitle?.isNotEmpty ?? false) ? data!.pageTitle! : title.tr,
                  isShowActions: false,
                ),
                loading: () => AppAppBar(title: title.tr, isShowActions: false),
                error: (err, stack) => AppAppBar(title: title.tr, isShowActions: false),
              ),
              Expanded(
                child: cmsAsync.when(
                  data: (data) {
                    if (data == null) return const AppNoRecordsWidget();

                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(getProportionateScreenWidth(
                            slug == "about-us" || slug == "About Us" ? 10 : 15)),
                        child: slug == "about-us" || slug == "About Us"
                            ? _buildAboutUs(context, data, isDarkMode, unescape)
                            : _buildDefaultCMS(context, data, isDarkMode, unescape),
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text("${'error_occurred'.tr}: $err")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutUs(
      BuildContext context, CmsData data, bool isDark, HtmlUnescape unescape) {
    final subTitle = (data.aboutUsSubTitle?.isNotEmpty ?? false)
        ? data.aboutUsSubTitle!
        : (data.pageSubTitle ?? "");
    final htmlContent = (data.aboutUsDesc?.isNotEmpty ?? false)
        ? data.aboutUsDesc!
        : (data.pageContent ?? "");
    final hasImage = data.aboutUsImage?.isNotEmpty ?? false;
    final hasBullets = (data.aboutUsBrowSec1?.isNotEmpty ?? false) ||
        (data.aboutUsBrowSec2?.isNotEmpty ?? false) ||
        (data.aboutUsBrowSec3?.isNotEmpty ?? false);
    final hasHeaderCard = subTitle.isNotEmpty || hasImage || hasBullets;

    return Column(
      children: [
        if (hasHeaderCard) ...[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (subTitle.isNotEmpty)
                        customTextNormalStyle(
                          subTitle,
                          getProportionateScreenWidth(15),
                          TextAlign.start,
                          Theme.of(context).colorScheme.onSurface,
                        ),
                      if (hasBullets) ...[
                        if (subTitle.isNotEmpty)
                          Gap(getProportionateScreenWidth(15)),
                        _buildBulletPoint(
                            context, data.aboutUsBrowSec1, isDark),
                        if (data.aboutUsBrowSec2?.isNotEmpty ?? false)
                          Gap(getProportionateScreenWidth(5)),
                        _buildBulletPoint(
                            context, data.aboutUsBrowSec2, isDark),
                        if (data.aboutUsBrowSec3?.isNotEmpty ?? false)
                          Gap(getProportionateScreenWidth(5)),
                        _buildBulletPoint(
                            context, data.aboutUsBrowSec3, isDark),
                      ],
                    ],
                  ),
                ),
                if (hasImage) ...[
                  Gap(getProportionateScreenWidth(10)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(10)),
                    child: getImageWidget(
                      url: data.aboutUsImage!,
                      boxFit: BoxFit.fill,
                      imageWidth: 120,
                      imageHeight: 150,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Gap(getProportionateScreenWidth(15)),
        ],
        if (htmlContent.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: HtmlWidget(
              unescape.convert(htmlContent),
              textStyle: AppFont.font(
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBulletPoint(BuildContext context, String? text, bool isDark) {
    if (text == null || text.isEmpty) return const SizedBox.shrink();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_outline_rounded,
          size: getProportionateScreenWidth(15),
          color: Theme.of(context).colorScheme.onSurface,
        ),
        Gap(getProportionateScreenWidth(5)),
        Expanded(
          child: customTextNormalStyle(
            text,
            getProportionateScreenWidth(14),
            TextAlign.start,
            Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultCMS(BuildContext context, CmsData data, bool isDark, HtmlUnescape unescape) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenWidth(100),
          width: getProportionateScreenWidth(100),
          child: Image.asset(AppAssets.splashLogoPng),
        ),
        HtmlWidget(
          unescape.convert(data.pageContent ?? ""),
          textStyle: AppFont.font(
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: getProportionateScreenWidth(14),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
