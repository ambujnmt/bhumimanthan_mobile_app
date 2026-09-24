import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _preferences;

  static SharedPreferences? get instance => _preferences;

  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await _preferences!.setString(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    return await _preferences!.setInt(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _preferences!.setBool(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    return await _preferences!.setDouble(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences!.setStringList(key, value);
  }

  static String? getString(String key) => _preferences!.getString(key);

  static int? getInt(String key) => _preferences!.getInt(key);
  static bool? getBool(String key) => _preferences!.getBool(key);
  static double? getDouble(String key) => _preferences!.getDouble(key);
  static List<String>? getStringList(String key) =>
      _preferences!.getStringList(key);

  static Future<bool> remove(String key) async {
    return await _preferences!.remove(key);
  }

  static Future<bool> clear() async {
    return await _preferences!.clear();
  }

  static bool containsKey(String key) {
    return _preferences!.containsKey(key);
  }
}
