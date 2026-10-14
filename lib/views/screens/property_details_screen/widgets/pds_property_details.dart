import '../../../../utils/app_imports.dart';

class PdsPropertyDetails extends StatelessWidget {
  const PdsPropertyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Property Details',
      padding: EdgeInsets.zero,
      content: Column(
        children: [
          _customRow(title: 'Property Type', val: 'Apartment'),
          Divider(color: AppColors.hint, height: 35),
          _customRow(title: 'Floor', val: '18 of 39 floors'),
          Divider(color: AppColors.hint, height: 35),
          _customRow(title: 'Furnishing', val: 'Semi-Furnished'),
          Divider(color: AppColors.hint, height: 35),
          _customRow(title: 'Ownership', val: 'Freehold'),
          Divider(color: AppColors.hint, height: 35),
          _customRow(title: 'Project', val: 'DLF The Arbour'),
          Divider(color: AppColors.hint, height: 35),
          _customRow(title: 'Facing', val: 'North-East'),
          Divider(color: AppColors.hint, height: 35),
          _customRow(title: 'Age of Property', val: 'Less than 1 year'),
          Divider(color: AppColors.hint, height: 35),
          _customRow(title: 'Balconies', val: '3 spacious balconies'),
          Divider(color: AppColors.hint, height: 35),
        ],
      ),
    );
  }
}

Row _customRow({required String title, required String val}) {
  return Row(
    children: [
      CustomText.kText(title, size: 16, color: AppColors.subtitle),
      widthSpace10,
      Expanded(
        child: CustomText.kText(
          val,
          size: 16,
          weight: FontWeight.w900,
          align: TextAlign.right,
        ),
      ),
    ],
  );
}
