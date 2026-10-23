import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/property_details_screen_controller.dart';

class PropertyDetailsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<PropertyDetailsScreenController>(
      () => PropertyDetailsScreenController(),
    );
  }
}
