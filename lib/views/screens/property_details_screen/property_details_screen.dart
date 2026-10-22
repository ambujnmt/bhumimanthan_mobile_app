import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_about_widget.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_amenities.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_bhk_and_type.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_floor_plan.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_location_widget.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_property_details.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_seller_widget.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_similar_properties.dart';
import 'package:bhumi_manthan/views/widgets/app_fade_animated_switcher.dart';

import '../../../utils/app_imports.dart';
import 'property_details_screen_controller.dart';

class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({super.key});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  final sc = ScrollController();
  final _con = Get.put(PropertyDetailsScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: Get.height * .6 + AppDimentions.boxRadiusXL,
        maxHeight: Get.height * .95,
        parallaxEnabled: true,
        scrollController: sc,
        body: Align(
          alignment: Alignment.topCenter,
          child: Obx(
            () => Skeletonizer(
              enabled: _con.isLoading.value,
              child: AppNetworkImage(
                imgUrl: _con.data.value?.mainImage ?? '',
                height: Get.height * .5,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        color: transparent,
        panelBuilder: () => Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimentions.boxRadiusXL),
            ),
          ),
          child: Obx(
            () => AppFadeAnimatedSwitcher(
              child: _con.isLoading.value
                  ? Column(
                      children: [
                        SizedBox(height: 400, child: AppLoader.widget()),
                      ],
                    )
                  : _con.data.value == null
                  ? AppRefreshIndicator(
                      onRefresh: _con.refreshData,
                      child: errorLoadingData(),
                    )
                  : SingleChildScrollView(
                      controller: sc,
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
                                  'Posted ${timeAgo(_con.data.value!.createdAt)}',
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
        ),
      ),
    );
  }
}
