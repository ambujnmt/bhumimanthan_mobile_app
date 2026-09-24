import 'dart:convert';

import '../../utils/app_imports.dart';

class UserStorage {
  static final _userDataKey = 'user_data_key';
  static final _userTokenKey = 'user_token_key';

  static Future<void> setUserData(Map<String, dynamic> data) async {
    await SharedPrefs.setString(_userDataKey, jsonEncode(data));
  }

  static UserModel? getUserData() {
    final user = SharedPrefs.getString(_userDataKey);
    if (user == null) return null;
    return UserModel.fromJson(jsonDecode(user));
  }

  static Future<void> setToken(String token) async {
    await SharedPrefs.setString(_userTokenKey, token);
  }

  static String? getToken() => SharedPrefs.getString(_userTokenKey);

  static Future<void> clearUserData() => SharedPrefs.remove(_userDataKey);
  static Future<void> clearUserToken() => SharedPrefs.remove(_userTokenKey);
}
