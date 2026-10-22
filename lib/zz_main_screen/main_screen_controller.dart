import 'package:bhumi_manthan/utils/app_imports.dart';

class MainScreenController extends GetxController {
  final pageController = PageController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final currentIndex = 0.obs;

  void setCurrentIndex(int i) {
    if (i == tabs.length - 1) {
      openDrawer();
      return;
    }

    if (i == 1) {
      Get.toNamed(AppRoutes.searchScreen);
      return;
    }

    if (i == currentIndex.value) return;
    // currentIndex(i);
    // pageController.jumpToPage(i);
  }

  void closeDrawer() => scaffoldKey.currentState?.closeEndDrawer();
  void openDrawer() => scaffoldKey.currentState?.openEndDrawer();

  final List<Map<String, String>> tabs = [
    {'title': 'Home', 'icon': Images.homeIcon},
    {'title': 'Search', 'icon': Images.searchIcon},
    {'title': 'Favorites', 'icon': Images.heartIcon},
    {'title': 'Chat', 'icon': Images.chatIcon},
    {'title': 'Profile', 'icon': Images.userIcon},
    {'title': 'Menu', 'icon': Images.menuIcon},
  ];
}
