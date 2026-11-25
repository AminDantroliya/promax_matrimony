import 'package:pro_matrimony/core/config/env_config.dart';

int get zegoAppId => EnvConfig.zegoAppId;
String get zegoAppSign => EnvConfig.zegoAppSign;

const String appName = 'Pro Max Matrimony';
const String packageName = 'com.pro.matrimony';

// 1 = Top user details with actions
// 2 = Bottom user details with action
const int listItemDesign = 2;

// 1 = Underline
// 2 = Outline
const int formFieldDesign = 2;

const String androidUserAgent = 'NI-AOS';
const String iosUserAgent = 'NI-IOS';

//validations expression
final RegExp emailValidatorRegExp = RegExp(
  r"^[a-zA-Z0-9._+]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);
final RegExp passwordValidatorRegExp = RegExp(
  r"^((?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%&*]{6,})$",
);
final RegExp urlValidatorRegExp = RegExp(
  r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?",
);
