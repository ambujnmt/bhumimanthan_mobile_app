import 'dart:async';

import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:flutter/services.dart';

class MainScreenController extends GetxController {
  final pageController = PageController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final currentIndex = 0.obs;

  void setCurrentIndex(int i) {
    // if (i == tabs.length - 1) {
    //   openDrawer();
    //   return;
    // }

    if (i == 1) {
      Get.toNamed(AppRoutes.searchScreen);
      return;
    }

    if (i == currentIndex.value) return;
    currentIndex(i);
    pageController.jumpToPage(i);
  }

  void closeDrawer() => scaffoldKey.currentState?.closeEndDrawer();
  void openDrawer() => scaffoldKey.currentState?.openEndDrawer();

  final List<Map<String, String>> tabs = [
    {'title': 'Home', 'icon': Images.homeIcon},
    {'title': 'Search', 'icon': Images.searchIcon},
    {'title': 'Favorites', 'icon': Images.heartIcon},
    {'title': 'Chat', 'icon': Images.chatIcon},
    {'title': 'Compare', 'icon': Images.compareIcon},
    {'title': 'Menu', 'icon': Images.menuIcon},
  ];

  Timer? timer;
  void onBackPressed() {
    if (timer != null) {
      SystemNavigator.pop();
      return;
    }
    AppToast.show('Press back again to get exit.');
    timer = Timer(Duration(seconds: 2), () {
      timer?.cancel();
      timer = null;
    });
  }
}
