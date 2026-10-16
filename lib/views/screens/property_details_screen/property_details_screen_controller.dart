import 'package:bhumi_manthan/utils/app_imports.dart';

import '../bottom_tab_screens/home_screen/widgets/home_data.dart';

class PropertyDetailsScreenController extends GetxController {
  final data = Get.arguments['data'] as HomeItems;
  final isLoading = true.obs;

  Future<void> _getData() async {
    await waitForSec(1);
  }

  Future<void> refreshData() async {
    isLoading(true);
    await _getData();
    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }
}
