import 'package:bhumi_manthan/models/category_model.dart';

import '../../../utils/app_imports.dart';

class CategoryDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final category = Get.arguments?['data'] as CategoryModel?;

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: category?.children.length ?? 0,
      vsync: this,
    );
  }
}
