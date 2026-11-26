import 'package:bhumi_manthan/models/search_property_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

class SearchResultsScreenController extends GetxController {
  final queries = (Get.arguments as Map<String, String>?) ?? {};

  final _api = ApiServices();

  final isLoading = true.obs;

  final items = <SearchPropertyModel>[].obs;

  Future<bool> _getData() async {
    final res = await _api.get(
      '/search/properties',
      queries: {
        ...queries,
        ...{
          'page': (pagination.currentPage + 1).toString(),
          'per_page': pagination.perPage.toString(),
        },
      },
    );
    if (!res.success) return false;
    items.addAll(
      JsonParser.parseList(
        res.data['data']['properties'],
        (json) => SearchPropertyModel.fromJson(json),
      ),
    );
    final paginationJson = res.data['data']['pagination'];
    pagination =
        JsonParser.tryParse(
          paginationJson,
          (json) => PaginationModel.fromJson(json),
        ) ??
        PaginationModel();
    return true;
  }

  Future<void> refreshData() async {
    isLoading(true);
    await _getData();
    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    _startListener();
    refreshData();
  }

  final isLoadingMore = false.obs;
  final scrollController = ScrollController();
  final hasPaginationError = false.obs;
  var pagination = PaginationModel();

  Future<void> _loadMore() async {
    isLoadingMore(true);
    hasPaginationError.value = !await _getData();
    isLoadingMore(false);
  }

  void _startListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        _onScrollEnds();
      }
    });
  }

  void _onScrollEnds() {
    final currentPage = pagination.currentPage;
    final lastPage = pagination.lastPage;
    debugPrint('\nPagination:\ncurrent page:$currentPage\nlast page:$lastPage');

    if (isLoadingMore.value) {
      debugPrint('Pagination: Skip more loading, already loading more');
      return;
    }
    if (currentPage >= lastPage) {
      debugPrint('Pagination: Skip more loading, reached last page');
      return;
    }
    debugPrint('Pagination: Loading more...');
    _loadMore();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
