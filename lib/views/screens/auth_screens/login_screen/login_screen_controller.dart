import 'package:bhumi_manthan/controllers/auth_controller.dart';
import 'package:bhumi_manthan/shared_prefs/storage/auth_prefs.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

class LoginScreenController extends GetxController {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final emailError = ''.obs;
  final passError = ''.obs;

  Future<void> onSubmit() async {
    // Get.toNamed(AppRoutes.mainScreen);
    // return;
    if (!_validateForm()) return;
    closeKeyboard();
    AuthController.login(emailController.text, passController.text);
  }

  bool _validateForm() {
    bool isValid = true;

    // Email
    final email = emailController.text.trim();

    if (email.isEmpty) {
      emailError.value = 'Please enter your email';
      isValid = false;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = 'Please enter a valid email';
      isValid = false;
    } else {
      emailError.value = '';
    }

    // Password
    final password = passController.text;

    if (password.isEmpty) {
      passError.value = 'Please enter your password';
      isValid = false;
    } else if (password.length < 8) {
      passError.value = 'Password must be at least 8 characters';
      isValid = false;
    } else {
      passError.value = '';
    }

    if (!isValid) return false;

    return true;
  }

  @override
  void onInit() {
    super.onInit();
    // LocationController().getCityFromIp();
    AuthPrefs.markIntroAsDone();
  }
}
