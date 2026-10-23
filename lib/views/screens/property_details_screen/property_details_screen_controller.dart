import 'package:bhumi_manthan/controllers/compare_controller.dart';
import 'package:bhumi_manthan/models/propertiy_details_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/compare_screen/compare_screen_controller.dart';
import 'package:bhumi_manthan/zz_main_screen/main_screen_controller.dart';

class PropertyDetailsScreenController extends GetxController {
  final idOrSlug = (Get.arguments['id']).toString();
  final isLoading = true.obs;

  final _api = ApiServices();

  final data = Rxn<PropertyDetailsModel>();

  List<PropertyDetailsModel> similarItems = <PropertyDetailsModel>[];

  Future<void> _getData() async {
    final res = await _api.get('/properties/detail/$idOrSlug');
    if (!res.success) return;
    data.value = PropertyDetailsModel.fromJson(res.data['data']['property']);
    similarItems = (res.data['data']['similar_properties'] as List)
        .map((json) => PropertyDetailsModel.fromJson(json))
        .toList();
  }

  final addingToCompare = false.obs;
  final addedToCompare = false.obs;

  Future<void> addToCompare() async {
    addingToCompare(true);
    final success = await CompareController.addToCompare(data.value!.id);
    addingToCompare(false);
    if (!success) return;

    addedToCompare(true);

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

  Future<void> removeCompare() async {
    addingToCompare(true);
    final success = await CompareController.removeCompare(data.value!.id);

    addingToCompare(false);

    if (!success) return;

    addedToCompare(false);
    AppToast.error('Removed successfully.');
    findController<CompareScreenController>()?.refreshData();
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
