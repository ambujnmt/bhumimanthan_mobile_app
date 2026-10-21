import '../../../../utils/app_imports.dart';
import '../property_details_screen_controller.dart';

class PdsBhkAndType extends StatelessWidget {
  PdsBhkAndType({super.key});
  final _con = Get.find<PropertyDetailsScreenController>();

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: _con.data.value!.configuration,
      titleContentSpacing: 10,
      content: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimentions.defaultScreenPadding,
        ),
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.kText(
                'Area: ${formatNumber(_con.data.value!.superArea)} Sq.Ft.',
                size: 16,
                color: AppColors.subtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
