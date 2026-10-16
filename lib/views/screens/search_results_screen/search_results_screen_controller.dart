import 'package:bhumi_manthan/utils/app_imports.dart';

class SearchResultsScreenController extends GetxController {
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
