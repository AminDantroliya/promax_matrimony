import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../preference/session_keys.dart';
import '../services/app_session_service.dart';
import '../utils/utils.dart';
import '../core/config/env_config.dart';

/// Formats raw image URL to full network URL
String formatImageUrl(String? rawUrl) {
  if (rawUrl == null || rawUrl.isEmpty || rawUrl == "null" || rawUrl == "N/A") {
    return "";
  }
  if (!rawUrl.startsWith("http://") && !rawUrl.startsWith("https://")) {
    final cleanBaseUrl = EnvConfig.baseUrl.replaceAll("api/", "");
    final baseWithSlash = cleanBaseUrl.endsWith("/") ? cleanBaseUrl : "$cleanBaseUrl/";
    if (rawUrl.startsWith("uploads/")) {
      return "$baseWithSlash$rawUrl";
    } else {
      return "${baseWithSlash}uploads/member_photos/$rawUrl";
    }
  }
  return rawUrl;
}

/// Resolves appropriate gender placeholder asset path
String getGenderAssetPlaceholder({
  bool? isMyPhoto,
  bool? isProtected,
  String? targetGender,
}) {
  final myGender = AppSessionService.getValue(SessionDetail.kGender)?.toString().toLowerCase();
  final isMyGenderMale = myGender == "male" || myGender == "m";
  final protected = isProtected ?? false;

  if (isMyPhoto == true) {
    // Own photo -> Same gender as logged-in user
    if (isMyGenderMale) {
      return protected ? AppAssets.placeholderMaleProtected : AppAssets.placeholderMale;
    } else {
      return protected ? AppAssets.placeholderFemaleProtected : AppAssets.placeholderFemale;
    }
  } else {
    // Other member photo
    final targetGenStr = targetGender?.trim().toLowerCase();
    if (targetGenStr != null && targetGenStr.isNotEmpty) {
      if (targetGenStr == "male" || targetGenStr == "m") {
        return protected ? AppAssets.placeholderMaleProtected : AppAssets.placeholderMale;
      } else if (targetGenStr == "female" || targetGenStr == "f") {
        return protected ? AppAssets.placeholderFemaleProtected : AppAssets.placeholderFemale;
      }
    }
    // Fallback: Opposite gender of logged-in user
    if (isMyGenderMale) {
      // Logged-in user is Male -> Other user default is Female
      return protected ? AppAssets.placeholderFemaleProtected : AppAssets.placeholderFemale;
    } else {
      // Logged-in user is Female -> Other user default is Male
      return protected ? AppAssets.placeholderMaleProtected : AppAssets.placeholderMale;
    }
  }
}

Widget getImageWidget({
  required String? url,
  String? placeHolder,
  double? imageWidth,
  double? imageHeight,
  BoxFit? boxFit,
  Alignment? alignment,
  bool? isMyPhoto,
  bool? isProtected,
  String? targetGender,
}) {
  final String formattedUrl = formatImageUrl(url);
  final String defaultLocalPlaceholder = getGenderAssetPlaceholder(
    isMyPhoto: isMyPhoto,
    isProtected: isProtected,
    targetGender: targetGender,
  );

  // If placeHolder is passed as a network URL from backend, format it:
  String? backendPlaceholderUrl;
  if (placeHolder != null &&
      placeHolder.isNotEmpty &&
      placeHolder != "null" &&
      !placeHolder.startsWith("assets/")) {
    backendPlaceholderUrl = formatImageUrl(placeHolder);
  }

  Widget buildPlaceholderWidget() {
    if (backendPlaceholderUrl != null &&
        backendPlaceholderUrl.isNotEmpty &&
        isValidUrl(backendPlaceholderUrl)) {
      return CachedNetworkImage(
        imageUrl: backendPlaceholderUrl,
        fit: boxFit,
        alignment: alignment ?? Alignment.topCenter,
        width: imageWidth ?? 250.0,
        height: imageHeight ?? 180.0,
        errorWidget: (_, _, _) => Image.asset(
          defaultLocalPlaceholder,
          fit: boxFit,
          width: imageWidth ?? 250.0,
          height: imageHeight ?? 180.0,
        ),
      );
    }
    final String localAsset = (placeHolder != null && placeHolder.startsWith("assets/"))
        ? placeHolder
        : defaultLocalPlaceholder;

    return Image.asset(
      localAsset,
      fit: boxFit,
      width: imageWidth ?? 250.0,
      height: imageHeight ?? 180.0,
    );
  }

  if (formattedUrl.isNotEmpty && isValidUrl(formattedUrl)) {
    return CachedNetworkImage(
      imageUrl: formattedUrl,
      alignment: alignment ?? Alignment.topCenter,
      fit: boxFit,
      width: imageWidth ?? 250.0,
      height: imageHeight ?? 180.0,
      progressIndicatorBuilder: (context, url, downloadProgress) => buildPlaceholderWidget(),
      errorWidget: (context, url, error) => buildPlaceholderWidget(),
    );
  } else {
    return buildPlaceholderWidget();
  }
}

bool isValidString1(String? str) {
  return str != null && str.isNotEmpty && str != 'null';
}
