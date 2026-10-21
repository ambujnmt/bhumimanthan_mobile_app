import 'package:bhumi_manthan/views/screens/all_blogs_screen/all_blogs_screen.dart';
import 'package:bhumi_manthan/views/screens/all_luxury_properties_screen/all_luxury_properties_screen.dart';
import 'package:bhumi_manthan/views/screens/auth_screens/forget_password_screen/forget_password_screen.dart';
import 'package:bhumi_manthan/views/screens/auth_screens/login_screen/login_screen.dart';
import 'package:bhumi_manthan/views/screens/auth_screens/welcome_screen/welcome_screen.dart';
import 'package:bhumi_manthan/views/screens/blog_details_screen/blog_details_screen.dart';
import 'package:bhumi_manthan/views/screens/project_details_screen/project_details_screen.dart';
import 'package:bhumi_manthan/views/screens/search_screen/search_screen.dart';
import 'package:bhumi_manthan/zz_main_screen/main_screen.dart';

import '../utils/app_imports.dart';
import '../views/screens/all_featured_properties_screen/all_featured_properties_screen.dart';
import '../views/screens/auth_screens/otp_input_screen/otp_input_screen.dart';
import '../views/screens/auth_screens/register_screen/register_screen.dart';
import '../views/screens/auth_screens/splash_screen/splash_screen.dart';
import '../views/screens/property_details_screen/property_details_screen.dart';
import '../views/screens/search_results_screen/search_results_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splashScreen, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.welcomeScreen, page: () => const WelcomeScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.registerScreen, page: () => const RegisterScreen()),
    GetPage(
      name: AppRoutes.forgetPasswordScreen,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(name: AppRoutes.mainScreen, page: () => const MainScreen()),
    GetPage(name: AppRoutes.searchScreen, page: () => const SearchScreen()),
    GetPage(name: AppRoutes.otpInputScreen, page: () => OtpInputScreen()),
    GetPage(
      name: AppRoutes.propertyDetailsScreen,
      page: () => PropertyDetailsScreen(),
    ),

    GetPage(
      name: AppRoutes.passwordResetSuccessScreen,
      page: () => PasswordResetSuccessScreen(),
    ),
    GetPage(
      name: AppRoutes.searchResultsScreen,
      page: () => SearchResultsScreen(),
    ),

    GetPage(
      name: AppRoutes.allFeaturedPropertiesScreen,
      page: () => AllFeaturedPropertiesScreen(),
    ),

    GetPage(
      name: AppRoutes.allLuxuryPropertiesScreen,
      page: () => AllLuxuryPropertiesScreen(),
    ),
    GetPage(name: AppRoutes.allBlogsScreen, page: () => AllBlogsScreen()),
    GetPage(name: AppRoutes.blogDetailsScreen, page: () => BlogDetailsScreen()),
    GetPage(
      name: AppRoutes.projectDetailsScreen,
      page: () => ProjectDetailsScreen(),
    ),
  ];
}
