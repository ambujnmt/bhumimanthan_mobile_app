import 'package:bhumi_manthan/shared_prefs/shared_preferences.dart';

class AuthPrefs {
  static final _introKey = 'intro_key';

  static bool introDone() {
    return SharedPrefs.getBool(_introKey) ?? false;
  }

  static Future<void> markIntroAsDone() async {
    await SharedPrefs.setBool(_introKey, true);
  }
}
