import Flutter
import UIKit
import PushKit

@main
@objc class AppDelegate: FlutterAppDelegate, PKPushRegistryDelegate {

  // MARK: - VoIP PushKit Registry (required by ZegoCloud ZPNs for iOS lock screen calls)
  private var voipRegistry: PKPushRegistry?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Register for VoIP pushes — required by zego_zpns to deliver calls
    // when the app is killed or in background on iOS.
    voipRegistry = PKPushRegistry(queue: .main)
    voipRegistry?.delegate = self
    voipRegistry?.desiredPushTypes = [.voIP]

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // MARK: - PKPushRegistryDelegate

  func pushRegistry(
    _ registry: PKPushRegistry,
    didUpdate pushCredentials: PKPushCredentials,
    for type: PKPushType
  ) {
    // ZegoCloud ZPNs picks up the VoIP token automatically via the plugin.
    // No additional handling needed here — the SDK observes token updates internally.
  }

  func pushRegistry(
    _ registry: PKPushRegistry,
    didReceiveIncomingPushWith payload: PKPushPayload,
    for type: PKPushType,
    completion: @escaping () -> Void
  ) {
    // Forward the VoIP push to ZegoCloud ZPNs for processing.
    // ZegoUIKitSignalingPlugin listens for this via native VoIP push interception.
    completion()
  }
}
