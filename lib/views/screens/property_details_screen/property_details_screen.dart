import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_about_widget.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_amenities.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_bhk_and_type.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_floor_plan.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_location_widget.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_property_details.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_seller_widget.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_similar_properties.dart';
import 'package:bhumi_manthan/views/widgets/app_fade_animated_switcher.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../utils/app_imports.dart';
import 'property_details_screen_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({super.key});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  final _con = Get.put(PropertyDetailsScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => AppFadeAnimatedSwitcher(
              child: _con.isLoading.value
                  ? Skeletonizer(
                      enabled: _con.isLoading.value,
                      child: AppNetworkImage(
                        height: Get.height * .5,
                        width: Get.width,
                        fit: BoxFit.cover,
                      ),
                    )
                  : AppNetworkImage(
                      imgUrl: _con.data.value?.mainImage ?? '',
                      height: Get.height * .5,
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ],
      ),
      bottomSheet: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        expand: false,
        snap: true,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: white,
              border: Border(top: BorderSide(color: grey.shade300, width: 1.3)),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Obx(
              () => AppFadeAnimatedSwitcher(
                child: _con.isLoading.value
                    ? AppLoader.widget()
                    : _con.data.value == null
                    ? errorLoadingData(sc: scrollController)
                    : SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimentions.defaultScreenPadding,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  heightSpace17,
                                  CustomText.kText(
                                    _con.data.value!.configuration,
                                    size: 12,
                                    weight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                  heightSpace5,
                                  CustomText.kText(
                                    _con.data.value!.title,
                                    size: 25,
                                    family: CustomFonts.outfit,
                                  ),
                                  heightSpace10,
                                  Row(
                                    children: [
                                      Image.asset(
                                        Images.mapPinIcon,
                                        height: 15,
                                        width: 15,
                                        color: AppColors.subtitle,
                                      ),
                                      widthSpace2,
                                      Expanded(
                                        child: CustomText.kText(
                                          _con.data.value!.location,
                                          size: 14,
                                          color: AppColors.subtitle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  heightSpace10,
                                  CustomText.kText(
                                    formatPrice(_con.data.value!.price),
                                    size: 25,
                                    color: AppColors.primary,
                                    weight: FontWeight.w800,
                                    family: CustomFonts.outfit,
                                  ),
                                  CustomText.kText(
                                    'Posted ${timeago.format(DateTime.parse(_con.data.value!.createdAt).toLocal())}',
                                    size: 12,
                                    color: AppColors.subtitle,
                                  ),
                                  heightSpace15,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomText.kText(
                                          _con.data.value!.status,
                                          size: 16,
                                          weight: FontWeight.w600,
                                          color: AppColors.subtitle,
                                          align: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        child: VerticalDivider(
                                          color: AppColors.hint,
                                          thickness: 1.5,
                                          width: 15,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomText.kText(
                                          _con.data.value!.furnishing,
                                          size: 16,
                                          weight: FontWeight.w600,
                                          color: AppColors.subtitle,
                                          align: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        child: VerticalDivider(
                                          color: AppColors.hint,
                                          thickness: 1.5,
                                          width: 15,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomText.kText(
                                          _con.data.value!.ownership ?? 'N/A',
                                          size: 16,
                                          weight: FontWeight.w600,
                                          color: AppColors.subtitle,
                                          align: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  heightSpace20,
                                  CustomButton(text: 'Contact Agent'),
                                  heightSpace15,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomButton(
                                          text: 'View',
                                          textColor: AppColors.primary,
                                          color: transparent,
                                          border: Border.all(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                      widthSpace10,
                                      Expanded(
                                        child: CustomButton(
                                          text: 'Compare',
                                          textColor: AppColors.secondary,
                                          color: transparent,
                                          border: Border.all(
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            heightSpace20,
                            PdsAboutWidget(),
                            heightSpace14,
                            PdsPropertyDetails(),
                            heightSpace10,
                            PdsAmenities(),
                            heightSpace10,
                            PdsFloorPlan(),
                            heightSpace10,
                            PdsBhkAndType(),
                            heightSpace10,
                            PdsLocationWidget(),
                            heightSpace17,
                            PdsSellerWidget(),
                            heightSpace17,
                            PdsSimilarProperties(),
                            heightSpace100,
                          ],
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
