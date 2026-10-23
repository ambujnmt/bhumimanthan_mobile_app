import 'package:bhumi_manthan/utils/app_imports.dart';

import '../../../../models/compare_tab_model.dart';

class CompareScreenController extends GetxController {
  final _api = ApiServices();
  final isLoading = true.obs;

  final tabs = <ComparedTab>[].obs;

  Future<void> _getData() async {
    final res = await _api.get('/compare/list');
    if (!res.success) return;
    tabs.value = (res.data['data']['groups'] as List)
        .map((json) => ComparedTab.fromJson(json))
        .toList();
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
