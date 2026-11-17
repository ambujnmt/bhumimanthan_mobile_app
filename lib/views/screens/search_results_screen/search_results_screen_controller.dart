import 'package:bhumi_manthan/models/search_property_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

class SearchResultsScreenController extends GetxController {
  final queries = (Get.arguments as Map<String, String>?) ?? {};

  final _api = ApiServices();

  final isLoading = true.obs;
  final isLoadingMore = false.obs;

  final items = <SearchPropertyModel>[].obs;

  final isLastPage = false.obs;

  final _perPage = 12;
  int _currentPage = 1;

  Future<bool> _getData() async {
    final res = await _api.get(
      '/search/properties',
      queries: {
        ...queries,
        ...{'page': _currentPage.toString(), 'per_page': _perPage.toString()},
      },
    );
    if (!res.success) return false;
    items.addAll(
      (res.data['data']['properties'] as List)
          .map((json) => SearchPropertyModel.fromJson(json))
          .toList(),
    );
    final lastPage = res.data['data']['pagination']['last_page'];
    isLastPage.value = _currentPage >= lastPage;
    return true;
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value) {
      debugPrint('skip more loading, wait for running loader');
      return;
    }

    if (isLastPage.value) {
      debugPrint('skip more loading, reached last page');
      return;
    }

    _currentPage++;
    isLoadingMore(true);
    final success = await _getData();
    isLoadingMore(false);
    if (success) return;
    _currentPage--;
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
