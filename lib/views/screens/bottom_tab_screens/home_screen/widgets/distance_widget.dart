import 'package:bhumi_manthan/utils/app_imports.dart';

Widget distanceWidget(String distance) {
  return AppContainer(
    borderColor: grey.shade700,
    borderRadius: AppDimentions.boxRadiusXXS,
    color: black.withValues(alpha: .55),
    padding: EdgeInsets.symmetric(
      vertical: 2,
      horizontal: AppDimentions.screenPaddingXXS,
    ),
    child: Row(
      children: [
        Icon(Icons.location_on_outlined, size: 12, color: white),
        widthSpace2,
        CustomText.kText('$distance Km', size: 12, color: white),
      ],
    ),
  );
}
