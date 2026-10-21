import '../../../../utils/app_imports.dart';
import '../property_details_screen_controller.dart';

class PdsFloorPlan extends StatelessWidget {
  PdsFloorPlan({super.key});
  final _con = Get.find<PropertyDetailsScreenController>();

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Floor Plan',
      content: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimentions.defaultScreenPadding,
        ),
        child: AppNetworkImage(imgUrl: _con.data.value!.floorPlanImage),
      ),
    );
  }
}
