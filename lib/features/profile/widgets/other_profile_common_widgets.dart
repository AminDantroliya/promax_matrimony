import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_matrimony/features/home/providers/dashboard_notifier.dart';
import 'package:pro_matrimony/features/notifications/providers/notification_notifier.dart';
import 'package:pro_matrimony/features/profile/data/models/profile_models.dart';
import 'package:pro_matrimony/features/profile/providers/other_profile_notifier.dart';
import 'package:pro_matrimony/utils/app_dialogs.dart';
import 'package:pro_matrimony/utils/app_routes.dart';
import 'package:pro_matrimony/utils/permission_utils.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/membership_upgrade_bottom_sheet.dart';
import 'package:pro_matrimony/widgets/photo_protected_widget.dart';
import 'package:pro_matrimony/widgets/photo_watermark_overlay.dart';
import 'package:url_launcher/url_launcher.dart';
export 'other_profile_interest_banner.dart';

class OtherProfileHelper {
  static List<String> getImageList(ProfileData? data) {
    if (data == null) return [];
    final list = <String>[];
    if (data.myProfileTab != null) {
      for (final tab in data.myProfileTab!) {
        if (tab.sectionId == "photos_section" ||
            tab.sectionTitle?.toLowerCase() == "gallery") {
          if (tab.sectionValue != null) {
            for (final field in tab.sectionValue!) {
              final val = field.value?.toString() ?? "";
              if (val.isNotEmpty &&
                  !val.contains("placeholderImage") &&
                  !val.contains("placeholder")) {
                list.add(val);
              }
            }
          }
        }
      }
    }
    if (list.isEmpty) {
      final rootPhotos =
          [
                if (data.photo1Status == "APPROVED") data.photo1,
                if (data.photo2Status == "APPROVED") data.photo2,
                if (data.photo3Status == "APPROVED") data.photo3,
                if (data.photo4Status == "APPROVED") data.photo4,
              ]
              .where((e) => e != null && e.toString().isNotEmpty)
              .cast<String>()
              .toList();
      list.addAll(rootPhotos);
    }
    return list;
  }

  static String calculateAge(dynamic birthdate, dynamic age) {
    if (age != null && age.toString().isNotEmpty && age.toString() != "0") {
      return age.toString();
    }
    if (birthdate != null && birthdate.toString().isNotEmpty) {
      try {
        final parts = birthdate.toString().split('-');
        if (parts.length == 3) {
          final year = int.tryParse(parts[0]);
          final month = int.tryParse(parts[1]);
          final day = int.tryParse(parts[2]);
          if (year != null && month != null && day != null) {
            final now = DateTime.now();
            int calculated = now.year - year;
            if (now.month < month || (now.month == month && now.day < day)) {
              calculated--;
            }
            return calculated.toString();
          }
        }
      } catch (_) {}
    }
    return "";
  }

  static String getDisplayName(ProfileData? data) {
    if (data == null) return "";
    if (data.fullname != null && data.fullname.toString().trim().isNotEmpty) {
      return data.fullname.toString().trim();
    }
    return data.matriId?.toString().trim() ?? "";
  }

  static String getDisplayTitle(ProfileData? data) {
    if (data == null) return "";
    if (data.profileTitle != null &&
        data.profileTitle.toString().trim().isNotEmpty) {
      return data.profileTitle.toString().trim();
    }
    return getDisplayName(data);
  }

  static String getReligion(ProfileData? data) {
    if (data == null) return "";
    if (data.religionName != null &&
        data.religionName.toString().trim().isNotEmpty) {
      return data.religionName.toString().trim();
    }
    if (data.religion != null && data.religion.toString().trim().isNotEmpty) {
      return data.religion.toString().trim();
    }
    return "";
  }

  static String getEducation(ProfileData? data) {
    if (data == null) return "";
    if (data.educationName != null &&
        data.educationName.toString().trim().isNotEmpty) {
      return data.educationName.toString().trim();
    }
    if (data.educationDetails != null &&
        data.educationDetails.toString().trim().isNotEmpty) {
      return data.educationDetails.toString().trim();
    }
    return "";
  }

  static String getOccupation(ProfileData? data) {
    if (data == null) return "";
    if (data.occupationName != null &&
        data.occupationName.toString().trim().isNotEmpty) {
      return data.occupationName.toString().trim();
    }
    if (data.occupation != null &&
        data.occupation.toString().trim().isNotEmpty) {
      return data.occupation.toString().trim();
    }
    return "";
  }

  static List<String> getDynamicHighlights(ProfileData? data) {
    if (data == null) return [];
    final items = <String>[];
    if (data.motherTongue != null) {
      final mt = data.motherTongue.toString().trim();
      if (mt.isNotEmpty &&
          int.tryParse(mt) == null &&
          mt != "0" &&
          mt != "null" &&
          mt != "N/A") {
        items.add(mt);
      }
    }
    if (data.maritalStatus != null) {
      final ms = data.maritalStatus.toString().trim();
      if (ms.isNotEmpty &&
          int.tryParse(ms) == null &&
          ms != "0" &&
          ms != "null" &&
          ms != "N/A") {
        items.add(ms);
      }
    }
    if (data.diet != null) {
      final d = data.diet.toString().trim();
      if (d.isNotEmpty &&
          int.tryParse(d) == null &&
          d != "0" &&
          d != "null" &&
          d != "N/A") {
        items.add(d);
      }
    }
    if (data.smoke != null) {
      final s = data.smoke.toString().trim();
      if (s.isNotEmpty &&
          s != "No" &&
          int.tryParse(s) == null &&
          s != "0" &&
          s != "null" &&
          s != "N/A") {
        items.add("Smoke: $s");
      }
    }
    if (data.drink != null) {
      final dr = data.drink.toString().trim();
      if (dr.isNotEmpty &&
          dr != "No" &&
          int.tryParse(dr) == null &&
          dr != "0" &&
          dr != "null" &&
          dr != "N/A") {
        items.add("Drink: $dr");
      }
    }
    return items;
  }

  static String formatHeight(dynamic raw, {bool appendHeight = false}) {
    return formatDisplayHeight(raw, appendHeight: appendHeight);
  }

  static String getTabValueForLabel(
    ProfileData? data,
    String label, {
    String? directFallback,
  }) {
    final isHeight = label.trim().toLowerCase() == 'height';
    if (data == null) {
      if (isHeight && directFallback != null) {
        return formatDisplayHeight(directFallback, appendHeight: false);
      }
      return directFallback ?? "N/A";
    }
    if (data.myProfileTab != null) {
      final target = label.trim().toLowerCase();
      final targetKey = target.replaceAll(' ', '_');
      for (var tab in data.myProfileTab!) {
        if (tab.sectionValue != null) {
          for (var val in tab.sectionValue!) {
            final l = val.label?.trim().toLowerCase() ?? "";
            final k = val.key?.trim().toLowerCase() ?? "";
            if (l == target ||
                k == target ||
                k == targetKey ||
                l == targetKey ||
                (target.length > 3 &&
                    (l.contains(target) || k.contains(targetKey)))) {
              if (val.value != null &&
                  val.value.toString().trim().isNotEmpty &&
                  val.value.toString().trim() != "N/A" &&
                  val.value.toString().trim() != "null") {
                final v = val.value.toString().trim();
                if (isHeight) {
                  return formatDisplayHeight(v, appendHeight: false);
                }
                return v;
              }
            }
          }
        }
      }
    }
    if (isHeight && directFallback != null) {
      return formatDisplayHeight(directFallback, appendHeight: false);
    }
    if (directFallback != null &&
        directFallback.isNotEmpty &&
        directFallback != "0" &&
        directFallback != "null" &&
        int.tryParse(directFallback) == null) {
      return directFallback;
    }
    return directFallback ?? "N/A";
  }

  static String getCreatedByText(dynamic profileBy) {
    final p = profileBy?.toString() ?? "";
    if (p == "1" || p == "Self") return "Self";
    if (p == "2") return "Parent";
    if (p == "3") return "Sibling";
    if (p == "4") return "Relative";
    if (p == "5") return "Friend";
    return p.isNotEmpty ? p : "Self";
  }

  static List<String> getHobbyChips(ProfileData? data) {
    if (data == null) return [];
    final list = <String>[];
    if (data.myProfileTab != null) {
      for (final tab in data.myProfileTab!) {
        final title = tab.sectionTitle?.toLowerCase() ?? "";
        final id = tab.sectionId?.toLowerCase() ?? "";
        if (title.contains("hobb") ||
            title.contains("interest") ||
            id.contains("hobb") ||
            id.contains("interest")) {
          if (tab.sectionValue != null) {
            for (final f in tab.sectionValue!) {
              final val = f.value?.toString().trim() ?? "";
              if (val.isNotEmpty) {
                final parts = val
                    .split(RegExp(r'[,|•·]'))
                    .map((e) => e.trim())
                    .where((e) => e.isNotEmpty);
                list.addAll(parts);
              }
            }
          }
        }
      }
    }
    return list;
  }

  static Map<String, dynamic> getPhotoExtraParams(
    List<String> images,
    ProfileData data,
    String memberId,
  ) {
    final calculatedAge = calculateAge(data.birthdate, data.age);
    final locationParts = [
      if (data.cityName != null && data.cityName.toString().trim().isNotEmpty)
        data.cityName.toString().trim(),
      if (data.stateName != null && data.stateName.toString().trim().isNotEmpty)
        data.stateName.toString().trim(),
      if (data.countryName != null &&
          data.countryName.toString().trim().isNotEmpty)
        data.countryName.toString().trim(),
    ];
    final locationStr = locationParts.isNotEmpty
        ? locationParts.join(', ')
        : (data.address?.toString() ?? "");
    final displayHeight = getTabValueForLabel(
      data,
      'Height',
      directFallback: data.heightStr?.toString() ?? data.height?.toString(),
    );

    final displayTitle = getDisplayTitle(data);

    return {
      'receiverMemberId': '${data.id ?? memberId}',
      'name': displayTitle,
      'profileTitle': displayTitle,
      'age': int.tryParse(calculatedAge) ?? calculatedAge,
      'city': locationStr,
      'height': displayHeight,
      'imageUrl': images.isNotEmpty ? images[0] : (data.profileImage ?? ''),
      'matchPercentage': '${data.matchPercent ?? 0}% Match',
      'isVerified': data.idProofStatus == 1,
      'photosCount': images.length,
      'isPhotoRequestSent':
          (data.isPhotoRequestSent == true ||
          data.isPhotoRequestSent == 1 ||
          data.isPhotoRequestSent.toString() == "1" ||
          data.isPhotoRequestSent.toString().toLowerCase() == "true"),
    };
  }

  static String maskPhone(String phone) {
    if (phone.isEmpty) return "N/A";
    final cleanPhone = phone.trim();
    final parts = cleanPhone.split('-');
    if (parts.length > 1) {
      final prefix = parts[0];
      final number = parts[1];
      if (number.length > 4) {
        final maskedNum =
            '*' * (number.length - 4) + number.substring(number.length - 4);
        return "$prefix-$maskedNum";
      }
    }
    if (cleanPhone.length > 4) {
      return '*' * (cleanPhone.length - 4) +
          cleanPhone.substring(cleanPhone.length - 4);
    }
    return '**********';
  }

  static String maskEmail(String email) {
    if (email.isEmpty) return "N/A";
    final cleanEmail = email.trim();
    final parts = cleanEmail.split('@');
    if (parts.length == 2) {
      final username = parts[0];
      final domain = parts[1];
      if (username.length > 2) {
        final maskedUser =
            username.substring(0, 2) + '*' * (username.length - 2);
        return "$maskedUser@$domain";
      }
    }
    return '*********@gmail.com';
  }

  static String maskAddress(String address) {
    if (address.isEmpty) return "N/A";
    final cleanAddress = address.trim();
    if (cleanAddress.isEmpty) return "N/A";
    if (cleanAddress.contains('*')) return cleanAddress;
    if (cleanAddress.length > 6) {
      final start = cleanAddress.substring(0, 2);
      final end = cleanAddress.substring(cleanAddress.length - 4);
      final starCount = cleanAddress.length - 6;
      final stars =
          '*' * (starCount > 10 ? 10 : (starCount < 4 ? 4 : starCount));
      return "$start$stars$end";
    } else if (cleanAddress.length > 2) {
      return "${cleanAddress.substring(0, 1)}****";
    }
    return '**********';
  }

  static String getAboutMeText(ProfileData? data) {
    if (data == null) return "";
    final text = data.profileText?.toString().trim() ?? "";
    if (text.isNotEmpty) return text;
    final title = data.profileTitle?.toString().trim() ?? "";
    if (title.isNotEmpty) return title;
    return "";
  }

  static bool hasViewedContact(dynamic val) {
    if (val == null) return false;
    return val == true || val == 1 || val == '1' || val == 'true';
  }

  static Future<bool> dialPhoneNumber(String? phone) async {
    if (phone == null || phone.trim().isEmpty) {
      showToast("no_contact_details_available".tr);
      return false;
    }
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    if (cleanPhone.isEmpty) {
      showToast("no_contact_details_available".tr);
      return false;
    }
    final uri = Uri.parse('tel:$cleanPhone');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        return true;
      } else {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      try {
        return await launchUrl(uri);
      } catch (e) {
        debugPrint("Error opening dialer: $e");
        showToast("no_contact_details_available".tr);
        return false;
      }
    }
  }

  static Future<void> handleCallAction({
    required BuildContext context,
    required WidgetRef ref,
    required String memberId,
    required OtherMemberProfileResponseModel profileResponse,
    required bool isRevealed,
    required VoidCallback onRevealed,
    required VoidCallback scrollToContact,
  }) async {
    final currentProfile =
        ref.read(otherProfileProvider(memberId)).value ?? profileResponse;
    final hasViewed = isRevealed ||
        hasViewedContact(currentProfile.hasViewedContact) ||
        hasViewedContact(profileResponse.hasViewedContact);

    if (hasViewed) {
      final phone = currentProfile.data?.mobile?.toString().trim() ?? '';
      final clean = phone.replaceAll(RegExp(r'[^0-9+]'), '');
      if (clean.isNotEmpty) {
        await dialPhoneNumber(clean);
        return;
      }
      scrollToContact();
      showToast("no_contact_details_available".tr);
      return;
    }

    await handleViewContact(
      context: context,
      ref: ref,
      memberId: memberId,
      profileResponse: profileResponse,
      onSuccess: () async {
        onRevealed();
        scrollToContact();
        final freshProfile = ref.read(otherProfileProvider(memberId)).value;
        final phone = freshProfile?.data?.mobile?.toString().trim() ?? '';
        final clean = phone.replaceAll(RegExp(r'[^0-9+]'), '');
        if (clean.isNotEmpty) {
          await dialPhoneNumber(clean);
        }
      },
    );
  }

  // --- ACTIONS & API HANDLERS ---

  static Future<bool> handleViewContact({
    required BuildContext context,
    required WidgetRef ref,
    required String memberId,
    required OtherMemberProfileResponseModel profileResponse,
    required VoidCallback onSuccess,
  }) async {
    final hasViewed = hasViewedContact(profileResponse.hasViewedContact);

    if (hasViewed) {
      onSuccess();
      return true;
    }

    final remaining =
        int.tryParse(profileResponse.remainingContacts?.toString() ?? '') ?? 0;
    final theme = Theme.of(context);
    final confirmed = await AppDialogs.confirm(
      context,
      title: 'view_contact_details_title'.tr,
      message: 'view_contact_details_message'.trParams({
        'remaining': '$remaining',
      }),
      confirmLabel: 'btn_proceed'.tr,
      customBody: RichText(
        text: TextSpan(
          style: AppFont.font(
            fontSize: 15,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            height: 1.5,
          ),
          children: [
            TextSpan(text: "deduct_contact_credit_prefix".tr),
            TextSpan(
              text: "1",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            TextSpan(text: "deduct_contact_credit_suffix".tr),
            TextSpan(
              text: "$remaining",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
            const TextSpan(text: ")"),
          ],
        ),
      ),
    );
    if (confirmed != true || !context.mounted) return false;

    showLoading(context);
    final result = await ref
        .read(otherProfileProvider(memberId).notifier)
        .viewContactDetails();
    hideLoading();
    if (result['status'] == 'success') {
      onSuccess();
      return true;
    } else {
      showToast(result['message'] ?? "Action failed");
      return false;
    }
  }

  static void showDetailBottomSheet(
    BuildContext context,
    String title,
    String value,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1B1C2A) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white24 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppFont.font(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF16182F),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.of(context).pop(),
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ],
                ),
                const Gap(12),
                Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      value,
                      style: AppFont.font(
                        fontSize: 14.5,
                        height: 1.6,
                        color: isDark
                            ? Colors.white70
                            : const Color(0xFF4A4E69),
                      ),
                    ),
                  ),
                ),
                const Gap(16),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> toggleShortlist({
    required BuildContext context,
    required WidgetRef ref,
    required String memberId,
    required ProfileData data,
  }) async {
    final success = await withLoading(
      context,
      () => ref.read(otherProfileProvider(memberId).notifier).toggleShortlist(),
    );
    if (!context.mounted) return;
    if (success == true) {
      final wasShortlisted =
          data.isShortlisted == "1" ||
          data.isShortlisted == 1 ||
          data.isShortlisted == true ||
          data.isShortlisted == "Yes";
      showToast(
        wasShortlisted ? 'removed_from_shortlist'.tr : 'added_to_shortlist'.tr,
      );
    }
  }

  static Future<void> handleBlock({
    required BuildContext context,
    required WidgetRef ref,
    required String memberId,
    required ProfileData data,
  }) async {
    final isBlocked = data.isBlock?.toString() == "1";
    final confirmed = await AppDialogs.confirm(
      context,
      title: isBlocked ? "unblock_profile".tr : "block_profile".tr,
      message: isBlocked
          ? "confirm_unblock_profile_msg".tr
          : "confirm_block_profile_msg".tr,
      confirmLabel: isBlocked ? "unblock_lbl".tr : "block_lbl".tr,
    );
    if (confirmed == true) {
      await ref
          .read(otherProfileProvider(memberId).notifier)
          .toggleBlock();
    }
  }

  static Future<void> sendInterest({
    required BuildContext context,
    required WidgetRef ref,
    required String memberId,
    required ProfileData data,
  }) async {
    final state = data.interestState?.toLowerCase();
    final status = data.interestStatus?.toLowerCase();

    if (state == "sent" ||
        status == "sent" ||
        state == "accepted" ||
        status == "accepted") {
      return;
    }

    final result = await withLoading(
      context,
      () => ref.read(otherProfileProvider(memberId).notifier).sendInterest(),
    );

    if (!context.mounted) return;

    final resStatus = result['status']?.toString().toLowerCase();
    final message = (result['message'] ?? '').toString();

    if (resStatus == 'success') {
      showSuccessToast(
        context,
        message.isNotEmpty ? message : 'interest_sent_successfully'.tr,
        icon: Icons.favorite_rounded,
      );
    } else {
      final lowerMsg = message.toLowerCase();
      if (lowerMsg.contains('paid member') ||
          lowerMsg.contains('upgrade') ||
          lowerMsg.contains('membership') ||
          lowerMsg.contains('plan')) {
        MembershipUpgradeBottomSheet.show(context, message);
      } else if (message.isNotEmpty) {
        showToast(message);
      }
    }
  }

  static Future<void> cancelInterest({
    required BuildContext context,
    required WidgetRef ref,
    required String memberId,
    required ProfileData data,
  }) async {
    final result = await withLoading(
      context,
      () => ref.read(otherProfileProvider(memberId).notifier).deleteInterest(),
    );
    if (!context.mounted) return;
    final message = (result['message'] ?? '').toString();
    if (message.isNotEmpty) {
      showToast(message);
    }
  }

  static Future<void> acceptInterest({
    required BuildContext context,
    required WidgetRef ref,
    required String memberId,
    required ProfileData data,
  }) async {
    final result = await withLoading(
      context,
      () => ref.read(otherProfileProvider(memberId).notifier).acceptInterest(),
    );
    if (!context.mounted) return;
    final message = (result['message'] ?? '').toString();
    if (message.isNotEmpty) {
      showToast(message);
    }
  }

  static Future<void> declineInterest({
    required BuildContext context,
    required WidgetRef ref,
    required String memberId,
    required ProfileData data,
  }) async {
    final result = await withLoading(
      context,
      () => ref.read(otherProfileProvider(memberId).notifier).rejectInterest(),
    );
    if (!context.mounted) return;
    final message = (result['message'] ?? '').toString();
    if (message.isNotEmpty) {
      showToast(message);
    }
  }

  static Future<void> sendReminder({
    required BuildContext context,
    required WidgetRef ref,
    required String memberId,
    required ProfileData data,
  }) async {
    final enableReminders = ref.read(
      featureProvider('enableInterestReminders'),
    );
    if (!enableReminders) {
      showToast('Interest reminders are currently disabled');
      return;
    }
    final result = await withLoading(
      context,
      () => ref.read(otherProfileProvider(memberId).notifier).sendReminder(),
    );
    if (!context.mounted) return;
    final message = (result['message'] ?? '').toString();
    final lowerMsg = message.toLowerCase();
    if (lowerMsg.contains('paid member') ||
        lowerMsg.contains('upgrade') ||
        lowerMsg.contains('membership') ||
        lowerMsg.contains('plan')) {
      MembershipUpgradeBottomSheet.show(context, message);
    } else if (message.isNotEmpty) {
      showToast(message);
    }
  }

  static Future<void> makeCall({
    required BuildContext context,
    required WidgetRef ref,
    required ProfileData data,
    required String memberId,
  }) async {
    await initiateAppCall(
      context,
      ref,
      targetModel: data,
      isVideo: false,
      sendCallInvitation: true,
    );
  }

  static Future<void> makeVideoCall({
    required BuildContext context,
    required WidgetRef ref,
    required ProfileData data,
    required String memberId,
  }) async {
    await initiateAppCall(
      context,
      ref,
      targetModel: data,
      isVideo: true,
      sendCallInvitation: true,
    );
  }

  static Future<void> openChat({
    required BuildContext context,
    required WidgetRef ref,
    required ProfileData data,
    required String memberId,
  }) async {
    final hasAccess = await checkChatPermission(context, ref);
    if (!hasAccess || !context.mounted) return;

    final images = getImageList(data);
    final photoUrl = images.isNotEmpty
        ? images.first
        : (data.profileImage?.toString() ?? "");
    AppRoutes.openChat(
      context,
      memberId: memberId,
      receiverName: getDisplayName(data),
      receiverPhoto: photoUrl,
    );
  }

  static void openFullScreenImage(
    BuildContext context,
    int initialIndex,
    List<String> images,
  ) {
    if (images.isEmpty) return;
    context.push(
      '/photo-viewer',
      extra: {'imageList': images, 'initialIndex': initialIndex},
    );
  }
}

// ---------------------------------------------------------------------------
// REUSABLE PROFILE COMMON WIDGETS
// ---------------------------------------------------------------------------

/// Frosted Top App Bar (Back, Notification with badge, 3-dots More with Block & Report)
class OtherProfileTopAppBar extends ConsumerWidget {
  final ProfileData data;
  final String memberId;
  final VoidCallback? onBack;
  final VoidCallback? onNotification;

  const OtherProfileTopAppBar({
    super.key,
    required this.data,
    required this.memberId,
    this.onBack,
    this.onNotification,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardUnread =
        ref.watch(dashboardProvider).value?.unreadNotificationCount ?? 0;
    final notificationUnread = ref.watch(unreadNotificationCountProvider);
    final unreadCount = dashboardUnread > 0
        ? dashboardUnread
        : notificationUnread;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap:
              onBack ??
              () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  Navigator.of(context).maybePop();
                }
              },
          child: Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 17,
            ),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap:
                  onNotification ?? () => AppRoutes.openNotifications(context),
              child: Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.35),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.icAppbarNotifications,
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    if (unreadCount > 0)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF4B6E),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const Gap(10),
            _buildMoreMenuBtn(context, ref),
          ],
        ),
      ],
    );
  }

  Widget _buildMoreMenuBtn(BuildContext context, WidgetRef ref) {
    final isBlocked = data.isBlock?.toString() == "1";
    final horoscopeUrl = data.horoscopeFile?.toString().trim();
    final hasHoroscope =
        horoscopeUrl != null &&
        horoscopeUrl.isNotEmpty &&
        horoscopeUrl.toLowerCase() != 'null';

    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        shape: BoxShape.circle,
      ),
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        icon: const Icon(
          Icons.more_vert_rounded,
          color: Colors.white,
          size: 20,
        ),
        onSelected: (value) async {
          if (value == 'view_horoscope') {
            if (hasHoroscope) {
              OtherProfileHelper.openFullScreenImage(context, 0, [
                horoscopeUrl,
              ]);
            }
          } else if (value == 'block') {
            await OtherProfileHelper.handleBlock(
              context: context,
              ref: ref,
              memberId: memberId,
              data: data,
            );
          } else if (value == 'report') {
            context.push('/report-admin', extra: {'memberId': memberId});
          }
        },
        itemBuilder: (context) => [
          if (hasHoroscope)
            PopupMenuItem(
              value: 'view_horoscope',
              child: Text(
                "view_horoscope".tr,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          PopupMenuItem(
            value: 'block',
            child: Text(
              isBlocked ? "unblock_lbl".tr : "block_lbl".tr,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'report',
            child: Text(
              "report_lbl".tr,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Key-Value Detail Item Row with 2-line overflow detection and "Read More" BottomSheet trigger
class OtherProfileDetailItemRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;
  final Widget? trailing;

  const OtherProfileDetailItemRow({
    super.key,
    required this.label,
    required this.value,
    required this.isDark,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = AppFont.font(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: isDark ? Colors.white : const Color(0xFF16182F),
      height: 1.4,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: AppFont.font(
                fontSize: 12.5,
                color: isDark ? Colors.white60 : const Color(0xFF8F96AC),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            flex: 6,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final tp = TextPainter(
                  text: TextSpan(text: value, style: textStyle),
                  maxLines: 2,
                  textDirection: TextDirection.ltr,
                )..layout(maxWidth: constraints.maxWidth);

                final bool isOverflowing = tp.didExceedMaxLines;

                if (!isOverflowing) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          value,
                          textAlign: TextAlign.end,
                          style: textStyle,
                        ),
                      ),
                      ?trailing,
                    ],
                  );
                }

                return GestureDetector(
                  onTap: () => OtherProfileHelper.showDetailBottomSheet(
                    context,
                    label,
                    value,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              value,
                              textAlign: TextAlign.end,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textStyle,
                            ),
                          ),
                          ?trailing,
                        ],
                      ),
                      const Gap(4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Read More",
                              style: AppFont.font(
                                fontSize: 11,
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(3),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 9,
                              color: theme.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Numbered Section Header (e.g., "02 — Basic Details" with Divider line & Collapsible Chevron)
class OtherProfileNumberedHeader extends StatelessWidget {
  final String number;
  final String title;
  final String? italic;
  final bool isExpanded;
  final VoidCallback onToggle;
  final bool isDark;

  const OtherProfileNumberedHeader({
    super.key,
    required this.number,
    required this.title,
    this.italic,
    required this.isExpanded,
    required this.onToggle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fullTitle = (italic != null && italic!.isNotEmpty)
        ? (title.isNotEmpty ? "$title $italic" : italic!)
        : title;

    return Row(
      children: [
        Text(
          "$number — ",
          style: AppFont.font(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: theme.primaryColor,
          ),
        ),
        Text(
          fullTitle,
          style: AppFont.font(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF16182F),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Divider(
            color: isDark ? Colors.white12 : const Color(0xFFE5E8F2),
            thickness: 1,
          ),
        ),
        const Gap(10),
        GestureDetector(
          onTap: onToggle,
          child: Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF222438) : const Color(0xFFF4F6FB),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: isDark ? Colors.white60 : const Color(0xFF5E6278),
            ),
          ),
        ),
      ],
    );
  }
}

/// Contact Details Locked/Unlocked Card
class OtherProfileContactCard extends StatelessWidget {
  final ProfileData data;
  final bool isRevealed;
  final bool hasViewedContact;
  final VoidCallback onViewContact;
  final bool isDark;
  final Key? cardKey;

  const OtherProfileContactCard({
    super.key,
    this.cardKey,
    required this.data,
    required this.isRevealed,
    required this.hasViewedContact,
    required this.onViewContact,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnlocked = isRevealed || OtherProfileHelper.hasViewedContact(hasViewedContact);

    return Container(
      key: cardKey,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF222438) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : const Color(0xFFF0F2F8),
        ),
      ),
      child: isUnlocked
          ? ((data.mobile == null || data.mobile.toString().trim().isEmpty) &&
                    (data.email == null ||
                        data.email.toString().trim().isEmpty) &&
                    (data.address == null ||
                        data.address.toString().trim().isEmpty))
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Text(
                        'no_contact_details_available'.tr,
                        style: AppFont.font(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? Colors.white60
                              : const Color(0xFF5A5E78),
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      if (data.mobile != null &&
                          data.mobile.toString().isNotEmpty)
                        InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () => OtherProfileHelper.dialPhoneNumber(
                            data.mobile.toString(),
                          ),
                          child: OtherProfileDetailItemRow(
                            label: 'mobile'.tr,
                            value: data.mobile.toString(),
                            isDark: isDark,
                            trailing: Container(
                              margin: const EdgeInsets.only(left: 6),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color:
                                    theme.primaryColor.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.phone,
                                size: 13,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      if (data.email != null &&
                          data.email.toString().isNotEmpty)
                        OtherProfileDetailItemRow(
                          label: 'email'.tr,
                          value: data.email.toString(),
                          isDark: isDark,
                        ),
                      if (data.address != null &&
                          data.address.toString().isNotEmpty)
                        OtherProfileDetailItemRow(
                          label: 'address'.tr,
                          value: data.address.toString(),
                          isDark: isDark,
                        ),
                    ],
                  )
          : Row(
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  color: theme.primaryColor,
                  size: 22,
                ),
                const Gap(10),
                Expanded(
                  child: Text(
                    'contact_details_locked'.tr,
                    style: AppFont.font(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white70 : const Color(0xFF5A5E78),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: onViewContact,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.getButtonBorderRadius(context),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    'view'.tr,
                    style: AppFont.font(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

/// Reusable Portrait Gallery (0.72 aspect ratio matching Design 2)
class OtherProfileGallery extends StatelessWidget {
  final List<String> images;
  final ProfileData data;
  final String memberId;
  final double borderRadius;

  const OtherProfileGallery({
    super.key,
    required this.images,
    required this.data,
    required this.memberId,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();
    final isProtected = checkIsPhotoProtected(data);
    final extraParams = OtherProfileHelper.getPhotoExtraParams(
      images,
      data,
      memberId,
    );

    if (images.length == 1) {
      return AspectRatio(
        aspectRatio: 0.72,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              GestureDetector(
                onTap: isProtected
                    ? () => context.push(
                        '/send-photo-request',
                        extra: extraParams,
                      )
                    : () => OtherProfileHelper.openFullScreenImage(
                        context,
                        0,
                        images,
                      ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    getImageWidget(
                      url: images[0],
                      boxFit: BoxFit.cover,
                      isProtected: isProtected,
                      targetGender: data.gender,
                    ),
                    const PhotoWatermarkOverlay(),
                  ],
                ),
              ),
              if (isProtected)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () =>
                        context.push('/send-photo-request', extra: extraParams),
                    child: ProtectedImageOverlay(borderRadius: borderRadius),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    if (images.length == 2) {
      return Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 0.72,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      onTap: isProtected
                          ? () => context.push(
                              '/send-photo-request',
                              extra: extraParams,
                            )
                          : () => OtherProfileHelper.openFullScreenImage(
                              context,
                              0,
                              images,
                            ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          getImageWidget(
                            url: images[0],
                            boxFit: BoxFit.cover,
                            isProtected: isProtected,
                            targetGender: data.gender,
                          ),
                          const PhotoWatermarkOverlay(),
                        ],
                      ),
                    ),
                    if (isProtected)
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () => context.push(
                            '/send-photo-request',
                            extra: extraParams,
                          ),
                          child: ProtectedImageOverlay(
                            borderRadius: borderRadius,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: AspectRatio(
              aspectRatio: 0.72,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      onTap: isProtected
                          ? () => context.push(
                              '/send-photo-request',
                              extra: extraParams,
                            )
                          : () => OtherProfileHelper.openFullScreenImage(
                              context,
                              1,
                              images,
                            ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          getImageWidget(
                            url: images[1],
                            boxFit: BoxFit.cover,
                            isProtected: isProtected,
                            targetGender: data.gender,
                          ),
                          const PhotoWatermarkOverlay(),
                        ],
                      ),
                    ),
                    if (isProtected)
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () => context.push(
                            '/send-photo-request',
                            extra: extraParams,
                          ),
                          child: ProtectedImageOverlay(
                            borderRadius: borderRadius,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    // 3 or more images: 2-column uniform 0.72 aspect ratio portrait grid
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 10) / 2;
        final cardHeight = cardWidth / 0.72;

        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(images.length, (idx) {
            return SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      onTap: isProtected
                          ? () => context.push(
                              '/send-photo-request',
                              extra: extraParams,
                            )
                          : () => OtherProfileHelper.openFullScreenImage(
                              context,
                              idx,
                              images,
                            ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          getImageWidget(
                            url: images[idx],
                            boxFit: BoxFit.cover,
                            isProtected: isProtected,
                            targetGender: data.gender,
                          ),
                          const PhotoWatermarkOverlay(),
                        ],
                      ),
                    ),
                    if (isProtected)
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () => context.push(
                            '/send-photo-request',
                            extra: extraParams,
                          ),
                          child: ProtectedImageOverlay(
                            borderRadius: borderRadius,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
