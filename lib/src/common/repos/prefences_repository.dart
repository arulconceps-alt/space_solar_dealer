import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  final SharedPreferences _prefs;

  PreferencesRepository(this._prefs);

  dynamic getPreference(String key) {
    return _prefs.get(key);
  }

  Future<void> setPreference(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    }
  }

  Future<void> clearPreferences() async {
    await _prefs.clear();
  }

  Future<void> removePreference(String key) async {
    await _prefs.remove(key);
  }
}
