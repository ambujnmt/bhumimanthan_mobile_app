import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../utils/app_imports.dart';
import '../../../widgets/app_fade_animated_switcher.dart';
import '../property_details_screen_controller.dart';

class PdsLocationWidget extends StatelessWidget {
  PdsLocationWidget({super.key, required this.con});
  final PropertyDetailsScreenController con;

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
                            double.parse(con.data.value!.latitude),
                            double.parse(con.data.value!.longitude),
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
            SizedBox(
              width: Get.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 15,
                  children: [
                    if (con.data.value?.rapidMetroDistance != null)
                      _customColumn(
                        'Rapid Metro',
                        '${con.data.value!.rapidMetroDistance} km',
                      ),
                    if (con.data.value?.schoolDistance != null)
                      _customColumn(
                        'School',
                        '${con.data.value?.schoolDistance} km',
                      ),
                    if (con.data.value?.hospitalDistance != null)
                      _customColumn(
                        'Hospital',
                        '${con.data.value?.hospitalDistance} km',
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Column _customColumn(String title, String val) {
  return Column(
    children: [
      CustomText.kText(val, size: 16, weight: FontWeight.bold),
      CustomText.kText(title, color: AppColors.subtitle),
    ],
  );
}
