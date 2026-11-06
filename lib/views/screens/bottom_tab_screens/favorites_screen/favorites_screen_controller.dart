import 'package:bhumi_manthan/controllers/fav_controller.dart';
import 'package:bhumi_manthan/models/fav_property_model.dart';

import '../../../../utils/app_imports.dart';

class FavoritesScreenController extends GetxController {
  final isLoading = true.obs;

  final perPage = '12';
  final pageNumber = 1;

  final items = <FavPropertyModel>[].obs;

  Future<void> _getData() async {
    final res = await ApiServices().get(
      '/wishlist',
      queries: {'per_page': perPage, 'page': pageNumber.toString()},
    );

    if (!res.success) return;

    items.value = (res.data['data']['properties'] as List)
        .map((json) => FavPropertyModel.fromJson(json))
        .toList();
  }

  Future<void> removeFavorite(FavPropertyModel property) async {
    final index = items.indexWhere((item) => item.id == property.id);
    items.removeAt(index);
    final success = await FavController.remove(property.id);
    if (!success) {
      items.insert(index, property);
      return;
    }
    // AppToast.error('Removed from favorites');
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
