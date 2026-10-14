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

  static Future<bool> resendOtp(String email) async {
    AppLoader.show();
    final res = await _api.post(
      '/resend-otp',
      payload: {"email": email},
      showErrorToast: true,
    );
    AppLoader.close();
    return !res.success;
  }

  static Future<void> login(String email, String password) async {
    AppLoader.show();
    final res = await _api.post(
      '/login',
      payload: {"login": email, "password": password},
      showErrorToast: true,
    );
    await AppLoader.close();

    if (!res.success) return;
  }
}
