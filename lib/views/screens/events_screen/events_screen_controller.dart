import '../../../utils/app_imports.dart';

class EventsScreenController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }
}
