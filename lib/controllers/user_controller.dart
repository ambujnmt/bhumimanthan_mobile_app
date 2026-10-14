import 'package:bhumi_manthan/helpers/app_dialog.dart';
import 'package:bhumi_manthan/shared_prefs/storage/user_storage.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

class UserController {
  static final user = Rxn<UserModel>();

  static final _api = ApiServices();

  static Future<void> init() async {
    user.value = UserStorage.getUserData();
    final token = UserStorage.getToken();

    if (token == null || user.value == null) {
      Get.offAllNamed(AppRoutes.loginScreen);
      return;
    }
    getUser();
    Get.offAllNamed(AppRoutes.mainScreen);
  }

  static Future<bool> getUser() async {
    final res = await _api.get('/profile');
    if (!res.success) return false;
    await UserStorage.setUserData(res.data['data']['user']);
    refreshUser();
    return true;
  }

  static void refreshUser() {
    user.value = UserStorage.getUserData();
  }

  static Future<void> logout() async {
    if (!await AppDialog.confirm(message: 'Are you sure to logout?')) {
      return;
    }
    AppLoader.show();
    await waitForMilliSec(500);
    await SharedPrefs.clear();
    AppLoader.close();
    Get.offAllNamed(AppRoutes.loginScreen);
  }
}
