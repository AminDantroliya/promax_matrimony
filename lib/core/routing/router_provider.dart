// WHITE LABEL — reads from AppConfig only. Do not hardcode values here.
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/config/providers/config_providers.dart';
import 'package:pro_matrimony/services/app_session_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/activity/screens/blocked_profile_screen.dart';
import '../../features/activity/screens/featured_member_screen.dart';
import '../../features/activity/screens/photo_request_screen.dart';
import '../../features/activity/screens/shortlisted_profile_screen.dart';
import '../../features/auth/screens/aadhaar_verification_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/auth/screens/intro_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/login_with_otp_screen.dart';
import '../../features/auth/screens/register/selfie_camera_screen.dart';
import '../../features/auth/screens/register2/dynamic_register_screen.dart';
import '../../features/auth/screens/registration_success_screen.dart';
import '../../features/auth/screens/verify_otp_screen.dart';
import '../../features/auth/screens/welcome_screen.dart';
import '../../features/chat/screens/chat_conversation_screen.dart';
import '../../features/cms/screens/cms_screen.dart';
import '../../features/common/screens/force_update_screen.dart';
import '../../features/common/screens/maintenance_screen.dart';
import '../../features/common/screens/photo_viewer_screen.dart';
import '../../features/common/screens/splash_screen.dart';
import '../../features/connection/screens/connection_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/events/data/models/event_models.dart';
import '../../features/events/screens/event_confirmation_screen.dart';
import '../../features/events/screens/event_details_screen.dart';
import '../../features/events/screens/event_list_screen.dart';
import '../../features/events/screens/registered_events_screen.dart';
import '../../features/meeting/screens/meeting_list_screen.dart';
import '../../features/notifications/screens/notification_screen.dart';
import '../../features/plan/screens/current_plan_screen.dart';
import '../../features/plan/screens/plans_screen.dart';
import '../../features/plan/screens/plan_history_screen.dart';
import '../../features/profile/screens/change_password_screen.dart';
import '../../features/profile/screens/delete_profile_screen.dart';
import '../../features/profile/screens/language_setting_screen.dart';
import '../../features/profile/screens/manage_photos_screen.dart';
import '../../features/profile/screens/my_profile_screen.dart';
import '../../features/profile/screens/other_member_profile_screen.dart';
import '../../features/profile/data/models/profile_models.dart';
import '../../features/profile/screens/privacy_settings_screen.dart';
import '../../features/profile/screens/view_my_profile_screen.dart';
import '../../features/profile/screens/interest_message_settings_screen.dart';
import '../../features/profile/screens/notification_channel_settings_screen.dart';
import '../../features/activity/screens/call_history_screen.dart';
import '../../features/activity/screens/viewed_interaction_screens.dart';
import '../../features/search/providers/matches_notifier.dart';
import '../../features/search/screens/matches_screen.dart';
import '../../features/settings/screens/auto_send_interest_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/activity/screens/send_photo_request_screen.dart';
import '../../features/success_stories/data/models/success_story_models.dart';
import '../../features/success_stories/screens/success_stories_screen.dart';
import '../../features/success_stories/screens/success_story_details_screen.dart';
import '../../features/success_stories/screens/video_player_screen.dart';
import '../../features/success_stories/screens/add_success_story_screen.dart';
import '../../features/support/screens/help_support_screen.dart';
import '../../features/support/screens/manager_chat_screen.dart';
import '../../features/support/screens/report_to_admin_screen.dart';
import '../../features/verification/screens/verification_screen.dart';

import '../../services/zego_initialization_service.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: ZegoInitializationService.navigatorKey,
    // initialLocation: '/register',
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) =>
            SplashScreen(args: state.extra as Map<String, dynamic>? ?? {}),
      ),
      GoRoute(path: '/intro', builder: (context, state) => const IntroScreen()),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/registration-success',
        builder: (context, state) => const RegistrationSuccessScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) {
          final stepParam =
              state.uri.queryParameters['step'] ??
              (state.extra is Map
                  ? (state.extra as Map)['step']?.toString()
                  : null);
          final initialStep = stepParam != null
              ? int.tryParse(stepParam)
              : null;
          return DynamicRegisterScreen(initialStep: initialStep);
        },
      ),
      GoRoute(
        path: '/login-otp',
        builder: (context, state) => const LoginWithOtpScreen(),
      ),
      GoRoute(
        path: '/verify-otp',
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>? ?? {};
          return VerifyOtpScreen(
            countryCode: extras['countryCode'] ?? '',
            mobile: extras['mobile'] ?? '',
            isRegister: extras['isRegister'] ?? false,
            registrationToken: extras['registrationToken'] ?? '',
            verificationId: extras['verificationId'],
            resendToken: extras['resendToken'],
          );
        },
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/profile-other/:id',
        builder: (context, state) =>
            OtherMemberProfileScreen(memberId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/my-profile',
        builder: (context, state) => const MyProfileScreen(),
      ),
      GoRoute(
        path: '/call-history',
        builder: (context, state) => const CallHistoryScreen(),
      ),
      GoRoute(
        path: '/profile-view-my',
        builder: (context, state) => const ViewMyProfileScreen(),
      ),
      GoRoute(
        path: '/connections',
        builder: (context, state) =>
            ConnectionScreen(initialTab: state.extra as String? ?? 'sent'),
      ),
      GoRoute(
        path: '/photo-requests',
        builder: (context, state) =>
            PhotoRequestScreen(initialTab: state.extra as String? ?? 'sent'),
      ),
      GoRoute(
        path: '/viewed-profiles',
        builder: (context, state) => const ViewedProfileScreen(),
      ),
      GoRoute(
        path: '/viewed-contacts',
        builder: (context, state) => const ViewedContactScreen(),
      ),
      // ── Always-on routes ──────────────────────────────────────────────
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/blocked-profiles',
        builder: (context, state) => const BlockedProfileScreen(),
      ),
      GoRoute(
        path: '/shortlisted-profiles',
        builder: (context, state) => const ShortlistedProfileScreen(),
      ),
      GoRoute(
        path: '/help-support',
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: '/chat-with-admin',
        builder: (context, state) => const ManagerChatScreen(),
      ),
      GoRoute(
        path: '/manager-chat',
        builder: (context, state) => const ManagerChatScreen(),
      ),
      GoRoute(
        path: '/delete-profile',
        builder: (context, state) => const DeleteProfileScreen(),
      ),
      GoRoute(
        path: '/cms',
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>? ?? {};
          String slug = (extras['slug'] ?? '').toString();
          String title = (extras['title'] ?? '').toString();

          if (slug.isEmpty) {
            final rawPage = (extras['pageName'] ?? extras['page_name'] ?? '')
                .toString();
            if (rawPage.isNotEmpty) {
              title = rawPage;
              final clean = rawPage.toLowerCase().trim();
              if (clean.contains('refund')) {
                slug = 'refund-policy';
              } else if (clean.contains('terms')) {
                slug = 'terms-condition';
              } else if (clean.contains('privacy')) {
                slug = 'privacy-policy';
              } else if (clean.contains('about')) {
                slug = 'about-us';
              } else {
                slug = rawPage.replaceAll(' ', '-').toLowerCase();
              }
            }
          }

          return CMSScreen(slug: slug, title: title);
        },
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: '/privacy-settings',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return PrivacySettingsScreen(
            scrollToSection: extra?['scrollTo'] as String?,
          );
        },
      ),
      GoRoute(
        path: '/interest-message-settings',
        builder: (context, state) => const InterestMessageSettingsScreen(),
      ),
      GoRoute(
        path: '/push-notification-settings',
        builder: (context, state) => const NotificationChannelSettingsScreen(
          title: 'Push Notifications',
          subtitle:
              'Customize your Notification alerts to receive only the updates that matter to you.',
          templateType: 'notification',
        ),
      ),
      GoRoute(
        path: '/email-notification-settings',
        builder: (context, state) => const NotificationChannelSettingsScreen(
          title: 'Email Notification',
          subtitle:
              'Customize your Email alerts to receive only the updates that matter to you.',
          templateType: 'email',
        ),
      ),
      GoRoute(
        path: '/sms-notification-settings',
        builder: (context, state) => const NotificationChannelSettingsScreen(
          title: 'SMS Notification',
          subtitle:
              'Customize your SMS alerts to receive only the updates that matter to you.',
          templateType: 'sms',
        ),
      ),
      GoRoute(
        path: '/language-setting',
        redirect: (context, state) {
          final enabled = ref.read(featureProvider('enableMultiLanguage'));
          if (!enabled) return '/settings';
          return null;
        },
        builder: (context, state) => const LanguageSettingScreen(),
      ),
      GoRoute(
        path: '/manage-photos',
        builder: (context, state) {
          final indexStr = state.uri.queryParameters['index'];
          final extraIndex = state.extra is int
              ? state.extra as int
              : (state.extra is Map
                    ? (state.extra as Map)['index'] as int?
                    : null);
          final index = indexStr != null ? int.tryParse(indexStr) : extraIndex;
          return ManagePhotosScreen(initialIndex: index);
        },
      ),
      GoRoute(
        path: '/maintenance',
        builder: (context, state) => const MaintenanceScreen(),
      ),
      GoRoute(
        path: '/force-update',
        builder: (context, state) => const ForceUpdateScreen(),
      ),
      GoRoute(
        path: '/recommended-matches',
        builder: (context, state) => const MatchesScreen(
          type: MatchType.recommended,
          title: 'recommended_matches',
        ),
      ),
      GoRoute(
        path: '/premium-matches',
        builder: (context, state) => const MatchesScreen(
          type: MatchType.premium,
          title: 'premium_matches',
        ),
      ),
      GoRoute(
        path: '/suggested-matches',
        builder: (context, state) => const MatchesScreen(
          type: MatchType.suggested,
          title: 'suggested_matches',
        ),
      ),
      GoRoute(
        path: '/recently-joined-matches',
        builder: (context, state) => const MatchesScreen(
          type: MatchType.recentlyJoined,
          title: 'recently_joined',
        ),
      ),
      GoRoute(
        path: '/recently-login-matches',
        builder: (context, state) => const MatchesScreen(
          type: MatchType.recentlyLogin,
          title: 'recently_login',
        ),
      ),
      GoRoute(
        path: '/featured-members',
        builder: (context, state) => const FeaturedMemberScreen(),
      ),
      GoRoute(
        path: '/report-admin',
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>? ?? {};
          return ReportToAdminScreen(memberId: extras['memberId'] ?? '');
        },
      ),
      // ── Feature-flag gated routes ─────────────────────────────────────
      // These routes are included ONLY if the corresponding flag is enabled
      // in AppConfig (merged from backend + flavor). The backend admin can
      // toggle them without a release.
      if (ref.read(featureProvider('enableChat')))
        GoRoute(
          path: '/chat-conversation/:id',
          builder: (context, state) {
            String receiverName = 'Chat';
            String? receiverPhoto;
            final extra = state.extra;
            if (extra is Map) {
              receiverName = extra['receiverName']?.toString() ?? 'Chat';
              receiverPhoto = extra['receiverPhoto']?.toString();
            } else if (extra is ProfileData) {
              receiverName =
                  (extra.fullname != null &&
                      extra.fullname.toString().trim().isNotEmpty)
                  ? extra.fullname.toString().trim()
                  : (extra.matriId?.toString() ?? 'Chat');
              receiverPhoto = extra.profileImage?.toString();
            }
            return ChatConversationScreen(
              receiverId: state.pathParameters['id']!,
              receiverName: receiverName,
              receiverPhoto: receiverPhoto,
            );
          },
        ),
      if (ref.read(featureProvider('enableMeeting')))
        GoRoute(
          path: '/meetings',
          builder: (context, state) => const MeetingListScreen(),
        ),
      if (ref.read(featureProvider('enableSuccessStories'))) ...[
        // ── Success Stories (feature-flag: enableSuccessStories) ──────────
        GoRoute(
          path: '/success-stories',
          builder: (context, state) => const SuccessStoriesScreen(),
        ),
        GoRoute(
          path: '/success-story-details',
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>? ?? {};
            return SuccessStoryDetailsScreen(
              story: extras['story'] as SuccessStory,
            );
          },
        ),
        GoRoute(
          path: '/add-success-story',
          builder: (context, state) => const AddSuccessStoryScreen(),
        ),
        GoRoute(
          path: '/play-video',
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>? ?? {};
            return VideoPlayerScreen(
              videoUrl: extras['videoUrl'] as String? ?? '',
              isYoutube: extras['isYoutube'] as bool? ?? false,
            );
          },
        ),
      ], // end enableSuccessStories
      // ── Admin matches ───────────────────────────────────────────────
      GoRoute(
        path: '/admin-matches',
        builder: (context, state) =>
            const MatchesScreen(type: MatchType.admin, title: 'Admin Matches'),
      ),

      GoRoute(
        path: '/aadhaar-verification',
        builder: (context, state) => const AadhaarVerificationScreen(),
      ),
      GoRoute(
        path: '/verification',
        builder: (context, state) => const VerificationScreen(),
      ),

      GoRoute(
        path: '/selfie-camera',
        builder: (context, state) => const SelfieCameraScreen(),
      ),
      GoRoute(
        path: '/register-dynamic',
        builder: (context, state) => const DynamicRegisterScreen(),
      ),
      GoRoute(
        path: '/register2',
        builder: (context, state) => const DynamicRegisterScreen(),
      ),
      GoRoute(
        path: '/photo-viewer',
        builder: (context, state) {
          final extras = state.extra is Map ? (state.extra as Map) : const {};
          final rawList = extras['imageList'];
          final List<String> imageList = rawList is List
              ? rawList.map((e) => e.toString()).toList()
              : [];
          final rawIndex = extras['initialIndex'];
          final int initialIndex = rawIndex is int
              ? rawIndex
              : int.tryParse(rawIndex?.toString() ?? '') ?? 0;
          return PhotoViewerScreen(
            imageList: imageList,
            initialIndex: initialIndex,
          );
        },
      ),
      GoRoute(path: '/plans', builder: (context, state) => const PlansScreen()),
      GoRoute(
        path: '/current-plan',
        builder: (context, state) {
          final fromCheckout = state.extra == true;
          return CurrentPlanScreen(fromCheckout: fromCheckout);
        },
      ),
      GoRoute(
        path: '/plan-history',
        builder: (context, state) => const PlanHistoryScreen(),
      ),
      GoRoute(
        path: '/auto-send-interest',
        builder: (context, state) => const AutoSendInterestScreen(),
      ),
      GoRoute(
        path: '/send-photo-request',
        builder: (context, state) {
          final extras = state.extra is Map ? (state.extra as Map) : const {};
          final rawAge = extras['age'];
          final int parsedAge = rawAge is int
              ? rawAge
              : int.tryParse(rawAge?.toString() ?? '') ?? 0;
          final rawPhotosCount = extras['photosCount'];
          final int? parsedPhotosCount = rawPhotosCount is int
              ? rawPhotosCount
              : int.tryParse(rawPhotosCount?.toString() ?? '');
          final rawIsVerified = extras['isVerified'];
          final bool parsedIsVerified = rawIsVerified is bool
              ? rawIsVerified
              : (rawIsVerified == true ||
                    rawIsVerified == 1 ||
                    rawIsVerified?.toString() == '1' ||
                    rawIsVerified?.toString().toLowerCase() == 'true');
          final rawIsSent = extras['isPhotoRequestSent'];
          final bool parsedIsSent = rawIsSent is bool
              ? rawIsSent
              : (rawIsSent == true ||
                    rawIsSent == 1 ||
                    rawIsSent?.toString() == '1' ||
                    rawIsSent?.toString().toLowerCase() == 'true');

          final rawProfileTitle = extras['profileTitle'] ??
              extras['profile_title'] ??
              extras['name'];

          return SendPhotoRequestScreen(
            receiverMemberId: extras['receiverMemberId']?.toString() ?? '',
            name: extras['name']?.toString() ?? '',
            profileTitle: rawProfileTitle?.toString(),
            age: parsedAge,
            city: extras['city']?.toString() ?? '',
            height: extras['height']?.toString() ?? "",
            imageUrl: extras['imageUrl']?.toString(),
            matchPercentage: extras['matchPercentage']?.toString() ?? "",
            isVerified: parsedIsVerified,
            photosCount: parsedPhotosCount,
            isPhotoRequestSent: parsedIsSent,
          );
        },
      ),
      GoRoute(
        path: '/events',
        builder: (context, state) => const EventListScreen(),
      ),
      GoRoute(
        path: '/events/:id',
        builder: (context, state) {
          final idParam = state.pathParameters['id'] ?? '0';
          final eventId = int.tryParse(idParam) ?? 0;
          final event = state.extra is EventItem ? state.extra as EventItem : null;
          return EventDetailsScreen(
            eventId: eventId,
            initialEvent: event,
          );
        },
      ),
      GoRoute(
        path: '/event-confirmation',
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>? ?? {};
          final event = extras['event'] as EventItem;
          final quantity = extras['quantity'] as int? ?? 1;
          return EventConfirmationScreen(
            event: event,
            quantity: quantity,
          );
        },
      ),
      GoRoute(
        path: '/registered-events',
        builder: (context, state) => const RegisteredEventsScreen(),
      ),
    ],
  );
}

/// Reads the register_step_status saved by the login / verify-otp API response.
/// Falls back to 'Enable' when the value has not been set yet.
String get registerStepStatus {
  return AppSessionService.getValue('registerStepStatus')?.toString() ??
      'Enable';
}

/// - 'Disable' or step >= 9 → always '/home' (registration wizard completed or skipped).
/// - 'Enable'  → '/register?step=$step' (opens the exact incomplete registration step).
String getRouteForRegisterStep(int step) {
  if (registerStepStatus == 'Disable' || step >= 9) {
    return '/home';
  }
  return '/register?step=$step';
}
