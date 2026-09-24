import 'package:bhumi_manthan/app_routes/app_pages.dart';

import 'utils/app_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([SharedPrefs.init()]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bhumi Manthan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: CustomFonts.manrope,
        colorScheme: .fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.secondary,
          selectionHandleColor: AppColors.secondary,
        ),
      ),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppPages.pages,
      routingCallback: (value) => closeKeyboard(),
    );
  }
}
