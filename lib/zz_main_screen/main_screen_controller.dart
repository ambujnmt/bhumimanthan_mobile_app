import 'package:bhumi_manthan/utils/app_imports.dart';

class MainScreenController extends GetxController {
  final pageController = PageController();

  final currentIndex = 0.obs;

  void setCurrentIndex(int i) {
    if (i == currentIndex.value) return;

    // currentIndex(i);
    // pageController.jumpToPage(i);
  }
}
