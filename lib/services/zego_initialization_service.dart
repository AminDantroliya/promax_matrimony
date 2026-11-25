import 'package:flutter/material.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

/// Service responsible for isolating Zego invitation calling engine
/// setup code, keeping main entry points clean.
class ZegoInitializationService {
  /// Global navigator key shared by GoRouter and Zego call invitation service.
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<void> initialize([GlobalKey<NavigatorState>? key]) async {
    final targetKey = key ?? navigatorKey;
    ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(targetKey);

    // Initialise Zego log system
    await ZegoUIKit().initLog();
  }
}
