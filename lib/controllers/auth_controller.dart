import 'package:bhumi_manthan/controllers/user_controller.dart';
import 'package:bhumi_manthan/shared_prefs/storage/user_storage.dart';
import 'package:bhumi_manthan/views/screens/auth_screens/otp_input_screen/otp_input_screen_controller.dart';

import '../utils/app_imports.dart';

class AuthController {
  static final _api = ApiServices();

  static Future<bool> verifyOtp(String email, String otp) async {
    final res = await _api.post(
      '/verify-otp',
      payload: {"email": email, "otp": otp},
      showErrorToast: true,
    );
    return res.success;
  }

  static Future<bool> resendOtp(String email, {String? message}) async {
    AppLoader.show(message: message);
    final res = await _api.post(
      '/resend-otp',
      payload: {"email": email},
      showErrorToast: true,
    );
    AppLoader.close();
    return res.success;
  }

  static Future<void> login(String email, String password) async {
    AppLoader.show();
    final res = await _api.post(
      '/login',
      payload: {"login": email, "password": password},
      showErrorToast: true,
    );
    await AppLoader.close();

    if (res.code == 403 &&
        res.data['message'] ==
            'Please verify your email with OTP before login.') {
      final success = await _verifyEmail(email);
      if (success) login(email, password);
      return;
    }
    if (!res.success) return;
    AppLoader.show();
    await UserStorage.setToken(res.data['data']['token']);
    final success = await UserController.getUser();
    await AppLoader.close();
    if (success) {
      UserController.init();
      return;
    }
    UserStorage.clearUserToken();
    UserStorage.clearUserData();
  }

  static Future<bool> _verifyEmail(String email) async {
    final success = await resendOtp(email, message: 'Sending otp.');
    if (!success) return false;
    return await Get.toNamed(
          AppRoutes.otpInputScreen,
          arguments: OtpInputArguments(
            value: email,
            onResend: () => resendOtp(email),
            onVerify: (otp) async {
              AppLoader.show();
              final veficationSuccess = await verifyOtp(email, otp);
              await AppLoader.close();
              if (!veficationSuccess) return;
              Get.back(result: true);
            },
          ),
        ) ??
        false;
  }
}
