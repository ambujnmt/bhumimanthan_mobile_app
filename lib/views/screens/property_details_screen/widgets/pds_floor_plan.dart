import '../../../../utils/app_imports.dart';
import '../property_details_screen_controller.dart';

class PdsFloorPlan extends StatelessWidget {
  const PdsFloorPlan({super.key, required this.con});
  final PropertyDetailsScreenController con;

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Floor Plan',
      content: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimentions.defaultScreenPadding,
        ),
        child: InkWell(
          onTap: () => Get.toNamed(
            AppRoutes.imageViewScreen,
            arguments: con.data.value!.floorPlanImage,
          ),
          child: AppNetworkImage(
            imgUrl: con.data.value!.floorPlanImage,
            height: 250,
            width: Get.width,
          ),
        ),
      ),
    );
  }
}
