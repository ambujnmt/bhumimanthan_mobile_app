import '../../../../models/propertiy_details_model.dart';
import '../../../../utils/app_imports.dart';

class FavoritesScreenController extends GetxController {
  final isLoading = true.obs;

  final favorites = <PropertyDetailsModel>[].obs;

  Future<void> _getData() async {
    final res = await ApiServices().get('endPoint');

    if (!res.success) return;
  }

  void removeFavorite(PropertyDetailsModel property) {
    favorites.removeWhere((item) => item.id == property.id);

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
