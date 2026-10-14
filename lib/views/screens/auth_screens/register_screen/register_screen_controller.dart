import 'package:bhumi_manthan/controllers/auth_controller.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

import '../otp_input_screen/otp_input_screen_controller.dart';

class RegisterScreenController extends GetxController {
  final _api = ApiServices();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final cPassController = TextEditingController();

  final nameError = ''.obs;
  final emailError = ''.obs;
  final phoneError = ''.obs;
  final passError = ''.obs;
  final cPassError = ''.obs;

  final terms = false.obs;

  Future<void> onSubmit() async {
    if (!_validateForm()) return;
    closeKeyboard();
    AppLoader.show();
    final res = await _api.post(
      '/register',
      payload: {
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passController.text,
        "role": "customer",
        "terms": terms.value,
      },
      showErrorToast: true,
    );
    await AppLoader.close();

    if (!res.success) return;

    Get.toNamed(
      AppRoutes.otpInputScreen,
      arguments: OtpInputArguments(
        value: emailController.text,
        onResend: () => AuthController.resendOtp(emailController.text),
        onVerify: (otp) => _verifyOtp(otp),
      ),
    );
  }

  Future<void> _verifyOtp(String otp) async {
    AppLoader.show();
    final success = await AuthController.verifyOtp(emailController.text, otp);
    await AppLoader.close();
    if (!success) return;
    Get.until((route) => route.settings.name == AppRoutes.registerScreen);
    AuthController.login(emailController.text, passController.text);
  }

  bool _validateForm() {
    bool isValid = true;

    // Name
    if (nameController.text.trim().isEmpty) {
      nameError.value = 'Please enter your name';
      isValid = false;
    } else {
      nameError.value = '';
    }

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

    // Phone (optional)
    final phone = phoneController.text.trim();

    if (phone.isNotEmpty && !GetUtils.isPhoneNumber(phone)) {
      phoneError.value = 'Please enter a valid phone number';
      isValid = false;
    } else {
      phoneError.value = '';
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

    // Confirm password
    if (cPassController.text.isEmpty) {
      cPassError.value = 'Please confirm your password';
      isValid = false;
    } else if (cPassController.text != password) {
      cPassError.value = 'Passwords do not match';
      isValid = false;
    } else {
      cPassError.value = '';
    }

    if (!isValid) return false;

    if (!terms.value) {
      AppToast.error('Please accept the Terms & Conditions');
      return false;
    }

    return true;
  }
}
