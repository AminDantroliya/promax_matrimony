import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storage_provider.g.dart';

@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError();
}

/// A wrapper class for session management that can be used within Riverpod
class SessionService {
  final SharedPreferences _prefs;
  SessionService(this._prefs);

  Future<void> setValue(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    }
  }

  T? getValue<T>(String key) {
    return _prefs.get(key) as T?;
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}

@riverpod
SessionService sessionService(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SessionService(prefs);
}
