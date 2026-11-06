import 'package:bhumi_manthan/controllers/compare_controller.dart';
import 'package:bhumi_manthan/controllers/fav_controller.dart';
import 'package:bhumi_manthan/models/propertiy_details_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/compare_screen/compare_screen_controller.dart';
import 'package:bhumi_manthan/zz_main_screen/main_screen_controller.dart';

import '../../../models/similar_properties_model.dart';

class PropertyDetailsScreenController extends GetxController {
  final idOrSlug = (Get.arguments['id']).toString();
  final isLoading = true.obs;
  final _api = ApiServices();

  final addedToCompare = false.obs;
  final addedToFav = false.obs;

  final data = Rxn<PropertyDetailsModel>();

  List<SimilarPropertyModel> similarItems = <SimilarPropertyModel>[];

  Future<void> _getData() async {
    final res = await _api.get('/properties/detail/$idOrSlug');
    if (!res.success) return;
    data.value = PropertyDetailsModel.fromJson(res.data['data']['property']);
    similarItems = (res.data['data']['similar_properties'] as List)
        .map((json) => SimilarPropertyModel.fromJson(json))
        .toList();
    addedToCompare.value = data.value!.isCompared;
  }

  void toggleCompare() {
    if (addedToCompare.value) {
      _removeCompare();
    } else {
      _addToCompare();
    }
  }

  Future<void> _addToCompare() async {
    addedToCompare(true);
    final success = await CompareController.add(data.value!.id);
    if (!success) {
      addedToCompare(false);
      return;
    }

    AppToast.success(
      'Added successfully.',
      actionLabel: 'Go to compare',
      onActionTap: () {
        final mc = Get.find<MainScreenController>();
        mc.setCurrentIndex(4);
        Get.until((k) => k.settings.name == AppRoutes.mainScreen);
      },
    );
    findController<CompareScreenController>()?.refreshData();
  }

  Future<void> _removeCompare() async {
    addedToCompare(false);
    final success = await CompareController.remove(data.value!.id);

    if (!success) {
      addedToCompare(true);
      return;
    }

    AppToast.error('Removed successfully.');
    findController<CompareScreenController>()?.refreshData();
  }

  void toggleFav() {
    if (addedToFav.value) {
      removeFromFav();
    } else {
      addToFav();
    }
  }

  Future<void> addToFav() async {
    addedToFav(true);
    final success = await FavController.add(data.value!.id);
    if (success) return;
    addedToFav(false);
  }

  Future<void> removeFromFav() async {
    addedToFav(false);
    final success = await FavController.remove(data.value!.id);

    if (success) return;
    addedToFav(true);
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
