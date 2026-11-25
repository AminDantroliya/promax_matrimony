class RegistrationTokenHolder {
  RegistrationTokenHolder._();

  static String? _token;

  /// Returns the current in-memory registration token (or null if not in registration flow).
  static String? get token => _token;

  /// Sets the temporary in-memory registration token received from register step 1.
  /// NOTE: This is strictly stored in RAM and NEVER persisted to SharedPreferences / Session.
  static void setToken(String? value) {
    _token = value;
  }

  /// Clears the temporary registration token (when registration completes, cancels, exits to login, or app restarts).
  static void clear() {
    _token = null;
  }

  /// Returns true if an in-memory registration token is actively available.
  static bool get hasToken => _token != null && _token!.trim().isNotEmpty;
}
