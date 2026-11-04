import '../../../../models/propertiy_details_model.dart';
import '../../../../utils/app_imports.dart';

class FavoritesScreenController extends GetxController {
  final isLoading = true.obs;

  final perPage = '12';
  final pageNumber = 1;

  final items = <PropertyDetailsModel>[].obs;

  Future<void> _getData() async {
    final res = await ApiServices().get(
      '/wishlist',
      queries: {'per_page': perPage, 'page': pageNumber.toString()},
    );

    if (!res.success) return;

    items.value = (res.data['data']['properties'] as List)
        .map((json) => PropertyDetailsModel.fromJson(json))
        .toList();
  }

  void removeFavorite(PropertyDetailsModel property) {
    items.removeWhere((item) => item.id == property.id);
    AppToast.success('Removed from favorites');
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
