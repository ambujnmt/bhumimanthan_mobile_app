import 'package:bhumi_manthan/models/search_property_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

class SearchResultsScreenController extends GetxController {
  final q = Get.arguments as Map<String, String>;

  final _api = ApiServices();

  final isLoading = true.obs;

  final items = <SearchPropertyModel>[].obs;

  Future<void> _getData() async {
    final res = await _api.get('/search/properties', queries: q);
    if (!res.success) return;
    items.value = (res.data['data']['properties'] as List)
        .map((json) => SearchPropertyModel.fromJson(json))
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
