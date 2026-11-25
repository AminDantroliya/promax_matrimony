import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../app_theme/size_config.dart';
import '../utils/utils.dart';


class AppNoRecordsWidget extends StatelessWidget {
  final String? noRecordFoundMessage;
  final bool? isShowIcon;

  const AppNoRecordsWidget({super.key, this.noRecordFoundMessage,this.isShowIcon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: isShowIcon ?? true,
            child: SizedBox(
              width: getProportionateScreenHeight(120),
              height: getProportionateScreenHeight(120),
              child: Lottie.asset(AppAssets.noDataFound),
            ),
          ),
          Gap(getProportionateScreenHeight(5)),
          customTextSemiBoldStyle(
            (noRecordFoundMessage == null) ? 'no_data_found_error'.tr : noRecordFoundMessage!,
            getProportionateScreenWidth(15),
            TextAlign.center,
            Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ],
      ),
    );
  }
}
