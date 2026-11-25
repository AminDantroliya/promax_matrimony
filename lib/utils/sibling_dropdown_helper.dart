import '../features/common/data/models/dropdown_models.dart';

/// Helper utility to handle sibling counts and dynamically filter/sort
/// married brother and married sister options based on selected total counts.
class SiblingDropdownHelper {
  SiblingDropdownHelper._();

  /// Checks if a field name refers to a married sibling count.
  static bool isMarriedSiblingField(String? fieldName) {
    if (fieldName == null) return false;
    final lower = fieldName.toLowerCase().replaceAll('_', '').replaceAll(' ', '');
    return lower == 'noofmarriedbrother' ||
        lower == 'noofmarriedbrothers' ||
        lower == 'noofmarriedsister' ||
        lower == 'noofmarriedsisters';
  }

  /// Checks if a field name refers to a total sibling count.
  static bool isTotalSiblingField(String? fieldName) {
    if (fieldName == null) return false;
    final lower = fieldName.toLowerCase().replaceAll('_', '').replaceAll(' ', '');
    return lower == 'noofbrother' ||
        lower == 'noofbrothers' ||
        lower == 'noofsister' ||
        lower == 'noofsisters';
  }

  /// Extracts the integer sibling count from various possible representations
  /// (e.g. DropdownOptionModel, Map, String, int).
  ///
  /// Examples:
  /// - "0", "None", "No Brothers" -> 0
  /// - "1", "One" -> 1
  /// - "2", "Two" -> 2
  /// - "3", "Three" -> 3
  /// - "4", "Four" -> 4
  /// - "Above 4", "4+", "Above four", "5" -> 5
  static int? parseSiblingCount(dynamic raw) {
    if (raw == null) return null;
    String text = '';
    if (raw is DropdownOptionModel) {
      text = (raw.val ?? raw.id ?? '').toString().trim();
    } else if (raw is Map) {
      text = (raw['val'] ?? raw['value'] ?? raw['id'] ?? '').toString().trim();
    } else {
      text = raw.toString().trim();
    }
    if (text.isEmpty) return null;

    final lower = text.toLowerCase();
    if (lower == '0' ||
        lower == 'none' ||
        lower.startsWith('no ') ||
        lower == 'no') {
      return 0;
    }

    // Check for "above 4" or "4+" or "above four"
    if (lower.contains('above') || lower.contains('+')) {
      final match = RegExp(r'\d+').firstMatch(lower);
      if (match != null) {
        final num = int.tryParse(match.group(0)!);
        if (num != null) return num >= 4 ? 5 : num;
      }
      return 5;
    }

    // Direct digit check
    final match = RegExp(r'\d+').firstMatch(lower);
    if (match != null) {
      final num = int.tryParse(match.group(0)!);
      if (num != null) return num;
    }

    // Word checks
    if (lower.contains('zero')) return 0;
    if (lower.contains('one')) return 1;
    if (lower.contains('two')) return 2;
    if (lower.contains('three')) return 3;
    if (lower.contains('four')) return 4;
    if (lower.contains('five')) return 5;

    return null;
  }

  /// Extracts the married count represented by a married sibling dropdown option.
  ///
  /// Options typically returned by API:
  /// - "No married brother" / "No married sister" -> 0
  /// - "One married brother" / "One married sister" -> 1
  /// - "Two married brothers" / "Two married sisters" -> 2
  /// - "Three married brothers" / "Three married sisters" -> 3
  /// - "Four married brothers" / "Four married sisters" -> 4
  /// - "Above four married brothers" / "Above four married sisters" -> 5
  static int getMarriedCount(dynamic raw) {
    if (raw == null) return 999;
    String text = '';
    if (raw is DropdownOptionModel) {
      text = '${raw.val ?? ''} ${raw.id ?? ''}'.toLowerCase().trim();
    } else if (raw is Map) {
      text = '${raw['val'] ?? raw['value'] ?? ''} ${raw['id'] ?? ''}'.toLowerCase().trim();
    } else {
      text = raw.toString().toLowerCase().trim();
    }
    if (text.isEmpty) return 999;

    // "Above four married brothers/sisters" or "Above 4"
    if (text.contains('above') || text.contains('+')) return 5;

    // "No married brother" / "No married sister" / "0" / "None"
    if (text.contains('no ') ||
        text.startsWith('no') ||
        text.contains('none') ||
        text == '0') {
      return 0;
    }

    if (text.contains('one') || RegExp(r'\b1\b').hasMatch(text)) return 1;
    if (text.contains('two') || RegExp(r'\b2\b').hasMatch(text)) return 2;
    if (text.contains('three') || RegExp(r'\b3\b').hasMatch(text)) return 3;
    if (text.contains('four') || RegExp(r'\b4\b').hasMatch(text)) return 4;
    if (text.contains('five') || RegExp(r'\b5\b').hasMatch(text)) return 5;

    final match = RegExp(r'\d+').firstMatch(text);
    if (match != null) {
      return int.tryParse(match.group(0)!) ?? 999;
    }

    return 999;
  }

  /// Filters and sorts married sibling options based on total sibling count.
  ///
  /// - If total siblings is 1: shows "No married..." (0) and "One married..." (1).
  /// - If total siblings is 2: shows 0, 1, 2.
  /// - If total siblings is 3: shows 0, 1, 2, 3.
  /// - If total siblings is 4: shows 0, 1, 2, 3, 4.
  /// - If total siblings is 5+ ("Above 4"): shows all options (0, 1, 2, 3, 4, 5).
  ///
  /// Options are always returned sorted in ascending numeric order.
  static List<DropdownOptionModel> filterAndSortMarriedOptions({
    required List<DropdownOptionModel> options,
    dynamic totalSiblingValue,
  }) {
    if (options.isEmpty) return const [];

    final list = List<DropdownOptionModel>.from(options);

    // Sort ascending by married count
    list.sort((a, b) => getMarriedCount(a).compareTo(getMarriedCount(b)));

    final totalCount = parseSiblingCount(totalSiblingValue);
    if (totalCount == null) {
      // If total sibling is not specified yet, return sorted full list
      return list;
    }

    // Keep only options where married count <= total sibling count
    return list.where((opt) {
      final count = getMarriedCount(opt);
      return count <= totalCount;
    }).toList();
  }

  /// Sorts total sibling options (e.g. 0, 1, 2, 3, 4, Above 4) in ascending order.
  static List<DropdownOptionModel> sortTotalSiblingOptions(
    List<DropdownOptionModel> options,
  ) {
    if (options.isEmpty) return const [];
    final list = List<DropdownOptionModel>.from(options);
    list.sort((a, b) {
      final countA = parseSiblingCount(a) ?? 999;
      final countB = parseSiblingCount(b) ?? 999;
      return countA.compareTo(countB);
    });
    return list;
  }

  /// Determines if the currently selected married sibling value should be reset
  /// when the total sibling value changes.
  static bool shouldResetMarriedSibling({
    required dynamic currentMarriedValue,
    required dynamic newTotalSiblingValue,
  }) {
    if (currentMarriedValue == null) return false;

    final marriedCount = getMarriedCount(currentMarriedValue);
    // If it couldn't be parsed, no need to reset
    if (marriedCount == 999) return false;

    final totalCount = parseSiblingCount(newTotalSiblingValue);
    if (totalCount == null || totalCount <= 0) {
      // If total is 0 or cleared, reset
      return true;
    }

    // If married sibling count exceeds the new total sibling count, reset
    return marriedCount > totalCount;
  }
}
