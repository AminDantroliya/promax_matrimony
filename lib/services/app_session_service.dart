import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppSessionService {
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences instance
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save a value
  static Future<void> setValue(String key, dynamic value) async {
    if (_prefs == null) return;
    if (value is String) {
      await _prefs!.setString(key, value);
    } else if (value is int) {
      await _prefs!.setInt(key, value);
    } else if (value is double) {
      await _prefs!.setDouble(key, value);
    } else if (value is bool) {
      await _prefs!.setBool(key, value);
    } else if (value is List<String>) {
      await _prefs!.setStringList(key, value);
    }
  }

  // Get a value
  static dynamic getValue(String key) {
    if (_prefs == null) return null;
    return _prefs!.get(key);
  }

  // Save model value
  void saveWithEncode(String key, dynamic value) {
    if (_prefs == null) return;
    _prefs!.setString(key, json.encode(value));
  }

  // Get model value
  dynamic readWithDecode(String key) {
    if (_prefs == null) return null;
    if (_prefs!.containsKey(key)) {
      return json.decode(_prefs!.getString(key)!);
    } else {
      return null;
    }
  }

  // Remove a key
  static void removeValue(String key) {
    if (_prefs == null) return;
    _prefs!.remove(key);
  }

  // Clear all data
  static Future<bool> clear() async {
    if (_prefs == null) return false;
    return await _prefs!.clear();
  }
}
