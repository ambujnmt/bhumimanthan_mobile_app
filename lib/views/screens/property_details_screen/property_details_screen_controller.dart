import 'package:bhumi_manthan/models/propertiy_details_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

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

  Future<void> addToCompare() async {
    addingToCompare(true);
    final res = await _api.post('endPoint', showErrorToast: true);
    addingToCompare(false);
    if (!res.success) return;
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
