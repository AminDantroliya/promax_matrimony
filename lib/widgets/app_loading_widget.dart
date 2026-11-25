import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';

import '../app_theme/size_config.dart';

class AppLoadingWidget extends StatelessWidget {
  final String? loadingMessage;

  const AppLoadingWidget({super.key, this.loadingMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(appPrimaryColor),
          ),
          Gap(getProportionateScreenWidth(25)),
          customTextSemiBoldStyle(loadingMessage == null ? "Loading..." : loadingMessage!, getProportionateScreenWidth(15), TextAlign.center, Theme.of(context).colorScheme.onSurface)
        ],
      ),
    );
  }
}

class LoadingPaginationWidget extends StatelessWidget {
  final bool? show;

  const LoadingPaginationWidget({
    super.key,
    required this.show,
  });

  @override
  Widget build(BuildContext context) {
    return show == true
        ? Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(appPrimaryColor),
            ),
          )
        : Container();
  }
}
