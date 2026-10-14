import 'package:bhumi_manthan/controllers/user_controller.dart';
import 'package:bhumi_manthan/shared_prefs/storage/auth_prefs.dart';

import '../../../../utils/app_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _initScreen() {
    if (!AuthPrefs.introDone()) {
      Get.offAllNamed(AppRoutes.welcomeScreen);
      return;
    }
    UserController.init();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
