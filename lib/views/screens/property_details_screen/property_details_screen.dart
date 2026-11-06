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
          : _con.data.value == null
          ? Scaffold(
              appBar: CustomAppbar(title: 'Details'),
              body: AppRefreshIndicator(
                onRefresh: _con.refreshData,
                child: ApiErrorWidget(),
              ),
            )
          : Scaffold(
              extendBodyBehindAppBar: true,
              appBar: CustomAppbar1(
                scrollController: sc,
                title: _con.data.value!.title,
                actions: [
                  CustomCircleIconButton(
                    onTap: () => _con.toggleFav(),
                    icon: Obx(
                      () => _con.addedToFav.value
                          ? Image.asset(
                              Images.heartFilled,
                              height: 22,
                              width: 22,
                              color: red,
                            )
                          : Image.asset(
                              Images.heartIcon,
                              height: 22,
                              width: 22,
                              color: black,
                            ),
                    ),
                  ),
                  widthSpace12,
                ],
              ),
              body: Obx(
                () => ListView(
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
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppDimentions.boxRadiusXL),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heightSpace17,
                            Row(
                              children: [
                                Expanded(
                                  child: CustomText.kText(
                                    _con.data.value!.configuration,
                                    size: 12,
                                    weight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                widthSpace3,
                                GestureDetector(
                                  onTap: () => copyToClipboard(
                                    _con.data.value?.propertyId,
                                  ),
                                  child: AppContainer(
                                    borderRadius: AppDimentions.boxRadiusXXS,
                                    padding: EdgeInsets.symmetric(
                                      vertical: AppDimentions.screenPaddingXXS,
                                      horizontal: AppDimentions.screenPaddingXS,
                                    ),
                                    child: Row(
                                      children: [
                                        CustomText.kText(
                                          _con.data.value!.propertyId,
                                          size: 13,
                                          weight: FontWeight.bold,
                                          color: AppColors.secondary,
                                        ),
                                        widthSpace5,
                                        Icon(
                                          Icons.copy,
                                          size: 16,
                                          color: AppColors.secondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                                    size: 13,
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
                                    size: 13,
                                    weight: FontWeight.w600,
                                    color: AppColors.subtitle,
                                    align: TextAlign.center,
                                  ),
                                ),
                                if (_con.data.value!.ownership != null) ...[
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
                                      size: 13,
                                      weight: FontWeight.w600,
                                      color: AppColors.subtitle,
                                      align: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            heightSpace20,
                            Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: CustomButton(
                                    text: _con.addedToCompare.value
                                        ? 'Remove Compare'
                                        : 'Add to Compare',
                                    textColor: AppColors.secondary,
                                    loaderColor: AppColors.secondary,
                                    color: transparent,
                                    border: Border.all(
                                      color: AppColors.secondary,
                                    ),
                                    onTap: () => _con.toggleCompare(),
                                  ),
                                ),
                                widthSpace10,
                                Expanded(
                                  flex: 4,
                                  child: CustomButton(
                                    text: 'Enquiry',
                                    onTap: () => Get.toNamed(
                                      AppRoutes.propertyEnquiryScreen,
                                      arguments: {'data': _con.data.value},
                                    ),
                                  ),
                                ),
                              ],
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
                            // AppContainer(
                            //   height: 200,
                            //   child: AppNetworkImage(
                            //     imgUrl:
                            //         'https://maps.googleapis.com/maps/api/staticmap?center=${_con.data.value!.latitude},${_con.data.value!.longitude}&zoom=15&key=AIzaSyAXkpxO--oleAJ1_jRL18Q1QqZn7iIwnG0',
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            heightSpace17,
                            PdsSellerWidget(con: _con),
                          ],
                        ),
                      ),
                    ),
                    PdsSimilarProperties(con: _con),
                    heightSpace100,
                  ],
                ),
              ),
            ),
    );
  }
}
