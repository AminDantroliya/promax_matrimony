import 'package:pro_matrimony/core/config/env_config.dart';
import '../../../features/common/data/models/member_models.dart';
import '../data/models/dashboard_models.dart';
import '../../profile/data/models/profile_models.dart';
import '../../../utils/application_data.dart';

/// Common helper methods for Home feature components.
class HomeHelpers {
  /// Checks whether the user has an active current plan
  static bool hasActivePlan({DashboardData? data, ProfileData? myProfile}) {
    if (data == null && myProfile == null) return false;

    final dataPlanStatus = data?.planStatus?.trim().toLowerCase();
    final profilePlanStatus = myProfile?.planStatus?.toString().trim().toLowerCase();

    // Explicitly inactive / expired / not paid
    if (dataPlanStatus == 'expired' || dataPlanStatus == 'not paid') {
      return false;
    }
    if (profilePlanStatus == 'expired' || profilePlanStatus == 'not paid') {
      return false;
    }

    // Valid current_plan object
    final currentPlan = data?.currentPlan;
    if (currentPlan != null) {
      final status = currentPlan.status?.trim().toLowerCase();
      if (status == 'expired' || status == 'inactive') {
        return false;
      }
      if (currentPlan.id != null ||
          (currentPlan.planName != null &&
              currentPlan.planName!.trim().isNotEmpty)) {
        return true;
      }
    }

    // Paid status
    if (dataPlanStatus == 'paid' ||
        profilePlanStatus == 'paid' ||
        ApplicationData.isMemberPaid == true) {
      return true;
    }

    return false;
  }
  /// Format city display text (ignoring raw numbers/IDs)
  static String getDisplayCity(dynamic cityVal) {
    if (cityVal == null) return "";
    final str = cityVal.toString().trim();
    if (RegExp(r'^\d+$').hasMatch(str)) return "";
    return str;
  }

  /// Format plan expiry date string into DD-MM-YYYY or DD MMM YYYY
  static String getFormattedPlanDate(String rawDate) {
    if (rawDate.isEmpty) return "";
    try {
      final parsed = DateTime.parse(rawDate);
      return "${parsed.day.toString().padLeft(2, '0')}-${parsed.month.toString().padLeft(2, '0')}-${parsed.year}";
    } catch (_) {
      return rawDate;
    }
  }

  /// Formats date difference to relative string ("15m", "2h", "3d")
  static String getTimeAgo(dynamic dateVal) {
    if (dateVal == null) return "2h";
    try {
      final date = DateTime.parse(dateVal.toString());
      final diff = DateTime.now().difference(date);
      if (diff.inMinutes < 60) {
        return "${diff.inMinutes}m";
      } else if (diff.inHours < 24) {
        return "${diff.inHours}h";
      } else {
        return "${diff.inDays}d";
      }
    } catch (_) {
      return "2h";
    }
  }

  /// Extracts religion string from member or subtitle text
  static String getReligion(MemberListModel member) {
    if (member.religion != null && member.religion.toString().isNotEmpty) {
      return member.religion.toString();
    }
    final sub = (member.subTitle ?? "").toString().toLowerCase();
    if (sub.contains("islam")) return "Islam";
    if (sub.contains("hindu")) return "Hindu";
    if (sub.contains("sikh")) return "Sikh";
    if (sub.contains("christian")) return "Christian";
    return "";
  }

  /// Extract YouTube video ID from URL
  static String? getYouTubeId(String? url) {
    if (url == null || url.isEmpty) return null;
    final RegExp regExp = RegExp(
      r'^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/|shorts\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(url);
    return (match != null && match.groupCount >= 1) ? match.group(1) : null;
  }

  /// Resolve full media URL for success story images/videos
  static String getFullSuccessMediaUrl(String? path) {
    if (path == null || path.isEmpty) return "";
    if (path.startsWith("http://") || path.startsWith("https://")) {
      return path;
    }
    String host = EnvConfig.baseUrl.replaceAll("/api/", "/");
    if (!host.endsWith("/")) {
      host += "/";
    }
    return "${host}uploads/success_story/$path";
  }
}
