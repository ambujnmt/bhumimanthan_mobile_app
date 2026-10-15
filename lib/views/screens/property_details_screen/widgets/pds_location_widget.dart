import '../../../../utils/app_imports.dart';

class PdsLocationWidget extends StatelessWidget {
  const PdsLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Location & Map',
      content: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimentions.defaultScreenPadding,
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/map.png',
              height: 200,
              width: Get.width,
              fit: BoxFit.cover,
            ),
            heightSpace15,
            Row(
              children: [
                _customColumn('Rapid Metro', '2.1 km'),
                _customColumn('Heritage School', '1.4 km'),
                _customColumn('Artemis Hospital', '4.8 km'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Expanded _customColumn(String title, String val) {
  return Expanded(
    child: Column(
      children: [
        CustomText.kText(val, size: 16, weight: FontWeight.bold),
        CustomText.kText(title, color: AppColors.subtitle),
      ],
    ),
  );
}
