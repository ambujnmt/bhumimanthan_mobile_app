import 'package:bhumi_manthan/utils/app_imports.dart';

class BlogDetailsScreenController extends GetxController {
  final idOrSlug = (Get.arguments['id']).toString();

  final _api = ApiServices();

  final isLoading = true.obs;

  Future<void> _getData() async {
    final res = await _api.get('/blogs/detail/$idOrSlug');
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
