import 'package:bhumi_manthan/views/screens/auth_screens/forget_password_screen/forget_password_screen.dart';
import 'package:bhumi_manthan/views/screens/auth_screens/login_screen/login_screen.dart';
import 'package:bhumi_manthan/views/screens/search_screen/search_screen.dart';
import 'package:bhumi_manthan/zz_main_screen/main_screen.dart';

import '../utils/app_imports.dart';
import '../views/screens/auth_screens/splash_screen/splash_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splashScreen, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => const LoginScreen()),
    GetPage(
      name: AppRoutes.forgetPasswordScreen,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(name: AppRoutes.mainScreen, page: () => const MainScreen()),
    GetPage(name: AppRoutes.searchScreen, page: () => const SearchScreen()),
  ];
}
