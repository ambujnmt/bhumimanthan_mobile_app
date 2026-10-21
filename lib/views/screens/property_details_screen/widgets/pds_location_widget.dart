import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../utils/app_imports.dart';
import '../../../widgets/app_fade_animated_switcher.dart';
import '../property_details_screen_controller.dart';

class PdsLocationWidget extends StatefulWidget {
  const PdsLocationWidget({super.key});

  @override
  State<PdsLocationWidget> createState() => _PdsLocationWidgetState();
}

class _PdsLocationWidgetState extends State<PdsLocationWidget> {
  final _con = Get.find<PropertyDetailsScreenController>();

  final isMapTileLoaded = false.obs;

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
            AppContainer(
              height: 190,
              clip: Clip.hardEdge,
              padding: EdgeInsets.zero,
              borderColor: grey[300]!,
              child: IgnorePointer(
                ignoring: true,
                child: Obx(
                  () => Stack(
                    alignment: Alignment.center,
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse(_con.data.value!.latitude),
                            double.parse(_con.data.value!.longitude),
                          ),
                          zoom: 14,
                        ),
                        onCameraIdle: () => isMapTileLoaded(true),
                        compassEnabled: false,
                        rotateGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        myLocationButtonEnabled: false,
                      ),
                      AppFadeAnimatedSwitcher(
                        child: isMapTileLoaded.value
                            ? SizedBox.shrink()
                            : Container(
                                height: Get.height,
                                width: Get.width,
                                color: white,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: Icon(
                          Icons.location_pin,
                          size: 42,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
