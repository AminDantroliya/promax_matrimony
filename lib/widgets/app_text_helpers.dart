import 'package:flutter/material.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';

Widget customTextNormalStyle(
    String name, double txtSize, TextAlign? textAlign, Color? textColor) {
  return Text(
    name,
    textAlign: textAlign ?? TextAlign.start,
    style: AppFont.font(fontSize: txtSize, color: textColor),
  );
}

Widget customTextSingleLineNormalStyle(
    String name, double txtSize, Color? textColor) {
  return Text(
    name,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: AppFont.font(fontSize: txtSize, color: textColor),
  );
}

Widget customTextBoldStyle(
    String name, double txtSize, TextAlign? textAlign, Color? textColor) {
  return Text(
    name,
    textAlign: textAlign ?? TextAlign.start,
    style: AppFont.font(
      fontSize: txtSize,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
  );
}

Widget customTextSemiBoldStyle(
    String name, double txtSize, TextAlign? textAlign, Color? textColor) {
  return Text(
    name,
    textAlign: textAlign ?? TextAlign.start,
    style: AppFont.font(
      fontSize: txtSize,
      fontWeight: FontWeight.w600,
      color: textColor,
    ),
  );
}

Widget customTextSemiBoldMaxStyle(
    String name, double txtSize, TextAlign? textAlign, Color? textColor, int maxLine) {
  return Text(
    name,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLine,
    overflow: TextOverflow.ellipsis,
    style: AppFont.font(
      fontSize: txtSize,
      fontWeight: FontWeight.w600,
      color: textColor,
    ),
  );
}

Widget customTextSingleLineBoldStyle(
    String name, double txtSize, Color? textColor) {
  return Text(
    name,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: AppFont.font(
      fontSize: txtSize,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
  );
}

Widget customTextBoldWithShadowStyle(
    String name, double txtSize, Color? textColor) {
  return Text(
    name,
    style: AppFont.font(
      fontSize: txtSize,
      fontWeight: FontWeight.bold,
      color: textColor,
      shadows: const <Shadow>[
        Shadow(
          offset: Offset(0.0, 1.0),
          blurRadius: 5.0,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ],
    ),
  );
}

Widget customTextNormalWithShadowStyle(
    String name, double txtSize, TextAlign? textAlign, Color? textColor) {
  return Text(
    name,
    textAlign: textAlign ?? TextAlign.start,
    style: AppFont.font(
      fontSize: txtSize,
      color: textColor,
      shadows: const <Shadow>[
        Shadow(
          offset: Offset(0.0, 1.0),
          blurRadius: 5.0,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ],
    ),
  );
}

Widget customToastMessageTextStyle(
    String name, double txtSize, TextAlign? textAlign, Color? textColor) {
  return Text(
    name,
    maxLines: 5,
    textAlign: textAlign ?? TextAlign.start,
    style: AppFont.font(fontSize: txtSize, color: textColor),
  );
}
