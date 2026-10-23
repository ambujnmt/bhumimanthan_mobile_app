import '../../../../utils/app_imports.dart';
import '../property_details_screen_controller.dart';

class PdsBhkAndType extends StatelessWidget {
  const PdsBhkAndType({super.key, required this.con});
  final PropertyDetailsScreenController con;

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: con.data.value!.configuration,
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
                'Area: ${formatNumber(con.data.value!.superArea)} Sq.Ft.',
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
