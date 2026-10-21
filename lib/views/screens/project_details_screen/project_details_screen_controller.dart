import 'package:bhumi_manthan/models/project_details_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

class ProjectDetailsScreenController extends GetxController {
  final idOrSlug = (Get.arguments['id']).toString();

  final _api = ApiServices();

  final isLoading = true.obs;

  final data = Rxn<ProjectDetailsModel>();

  Future<void> _getData() async {
    final res = await _api.get('/projects/detail/$idOrSlug');
    if (!res.success) return;
    data.value = ProjectDetailsModel.fromJson(res.data['data']['project']);
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
