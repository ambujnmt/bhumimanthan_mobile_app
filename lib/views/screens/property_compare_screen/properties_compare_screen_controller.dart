import 'package:bhumi_manthan/models/compare_property_model.dart';
import 'package:bhumi_manthan/models/compare_tab_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

class PropertiesCompareScreenController extends GetxController {
  final tab = Get.arguments as ComparedTab;

  final _api = ApiServices();
  final isLoading = true.obs;

  final items = <CompareProperty>[].obs;

  Future<void> _getData() async {
    final res = await _api.get(
      '/compare',
      queries: {
        'property_type': tab.propertyType,
        'ids': tab.properties.map((y) => y.id).toList().join(','),
      },
    );
    if (!res.success) return;

    items.value = (res.data['data']['properties'] as List)
        .map((json) => CompareProperty.fromJson(json))
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
