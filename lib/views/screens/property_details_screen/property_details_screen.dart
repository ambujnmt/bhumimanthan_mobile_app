import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_about_widget.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_amenities.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_bhk_and_type.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_floor_plan.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_location_widget.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_property_details.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_seller_widget.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_similar_properties.dart';

import '../../../utils/app_imports.dart';
import 'property_details_screen_controller.dart';
import 'widgets/pds_image_widget.dart';

class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({super.key});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  final sc = ScrollController();

  late final PropertyDetailsScreenController _con;

  @override
  void initState() {
    super.initState();
    _con = Get.find<PropertyDetailsScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _con.isLoading.value
          ? Scaffold(
              appBar: CustomAppbar(title: 'Details'),
              body: AppLoader.widget(),
            )
          : Scaffold(
              extendBodyBehindAppBar: true,
              appBar: CustomAppbar1(
                error: _con.data.value == null,
                scrollController: sc,
                title: _con.data.value == null
                    ? 'Details'
                    : _con.data.value!.title,
              ),
              body: Obx(
                () => _con.data.value == null
                    ? AppRefreshIndicator(
                        onRefresh: _con.refreshData,
                        child: errorLoadingData(),
                      )
                    : ListView(
                        controller: sc,
                        padding: EdgeInsets.zero,
                        children: [
                          PdsImageWidget(
                            images: _con.data.value!.galleryImages.isNotEmpty
                                ? _con.data.value!.galleryImages
                                : [_con.data.value?.mainImage ?? ''],
                          ),
                          Transform.translate(
                            offset: const Offset(0, -AppDimentions.boxRadiusXL),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimentions.defaultScreenPadding,
                              ),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                    AppDimentions.boxRadiusXL,
                                  ),
                                ),
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
                                  CustomButton(
                                    text: 'Enquiry',
                                    onTap: () => Get.toNamed(
                                      AppRoutes.propertyEnquiryScreen,
                                      arguments: {'data': _con.data.value},
                                    ),
                                  ),
                                  heightSpace15,
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
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
                                        flex: 6,
                                        child: Obx(
                                          () => _con.addedToCompare.value
                                              ? CustomButton(
                                                  showLoader:
                                                      _con.addingToCompare,
                                                  text: 'Remove Compare',
                                                  textColor:
                                                      AppColors.secondary,
                                                  loaderColor:
                                                      AppColors.secondary,
                                                  color: transparent,
                                                  border: Border.all(
                                                    color: AppColors.secondary,
                                                  ),
                                                  onTap: () =>
                                                      _con.removeCompare(),
                                                )
                                              : CustomButton(
                                                  showLoader:
                                                      _con.addingToCompare,
                                                  text: 'Add to Compare',
                                                  textColor:
                                                      AppColors.secondary,
                                                  loaderColor:
                                                      AppColors.secondary,
                                                  color: transparent,
                                                  border: Border.all(
                                                    color: AppColors.secondary,
                                                  ),
                                                  onTap: () =>
                                                      _con.addToCompare(),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          heightSpace20,
                          PdsAboutWidget(con: _con),
                          heightSpace14,
                          PdsPropertyDetails(con: _con),
                          heightSpace10,
                          PdsAmenities(),
                          heightSpace10,
                          PdsFloorPlan(con: _con),
                          heightSpace10,
                          PdsBhkAndType(con: _con),
                          heightSpace10,
                          PdsLocationWidget(con: _con),
                          heightSpace17,
                          PdsSellerWidget(con: _con),
                          heightSpace17,
                          PdsSimilarProperties(con: _con),
                          heightSpace100,
                        ],
                      ),
              ),
            ),
    );
  }
}
