import '../../../../utils/app_imports.dart';
import '../property_details_screen_controller.dart';

class PdsPropertyDetails extends StatelessWidget {
  const PdsPropertyDetails({super.key, required this.con});
  final PropertyDetailsScreenController con;

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Property Details',
      content: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimentions.defaultScreenPadding,
        ),
        child: Column(
          children: [
            _customRow(
              title: 'Property Type',
              val: con.data.value!.propertyType,
            ),
            Divider(color: AppColors.hint, height: 35),
            _customRow(
              title: 'Floor',
              val:
                  int.tryParse(con.data.value!.floor)?.ordinal ??
                  con.data.value!.floor,
            ),
            Divider(color: AppColors.hint, height: 35),
            _customRow(title: 'Furnishing', val: con.data.value!.furnishing),
            Divider(color: AppColors.hint, height: 35),
            _customRow(
              title: 'Ownership',
              val: con.data.value?.ownership ?? 'N/A',
            ),
            Divider(color: AppColors.hint, height: 35),
            _customRow(title: 'Project', val: con.data.value!.project),
            Divider(color: AppColors.hint, height: 35),
            _customRow(title: 'Facing', val: con.data.value!.facing),
            Divider(color: AppColors.hint, height: 35),
            _customRow(
              title: 'Age of Property',
              val: con.data.value!.ageOfProperty ?? 'N/A',
            ),
            Divider(color: AppColors.hint, height: 35),
            _customRow(title: 'Balconies', val: con.data.value!.balconies),
            Divider(color: AppColors.hint, height: 35),
          ],
        ),
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

extension Ordinal on int {
  String get ordinal {
    if (this % 100 >= 11 && this % 100 <= 13) {
      return '${this}th';
    }

    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }
}
