import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_about_widget.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_amenities.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_bhk_and_type.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_floor_plan.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_location_widget.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_property_details.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_seller_widget.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_similar_properties.dart';
import 'package:bhumi_manthan/views/widgets/app_network_image.dart';

import '../../../utils/app_imports.dart';
import 'property_details_screen_controller.dart';

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
          AppNetworkImage(
            imgUrl: _con.data.img,
            height: Get.height * .5,
            width: Get.width,
            fit: BoxFit.cover,
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
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
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
                          '4 BHK Apartment',
                          size: 10,
                          weight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        heightSpace10,
                        CustomText.kText(
                          'DLF The Arbour',
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
                                'Sector 63, Golf Course Extension Road, Gurugram',
                                size: 14,
                                color: AppColors.subtitle,
                              ),
                            ),
                          ],
                        ),
                        heightSpace10,
                        CustomText.kText(
                          '₹7.25 Cr',
                          size: 30,
                          color: AppColors.primary,
                          weight: FontWeight.w900,
                          family: CustomFonts.outfit,
                        ),
                        CustomText.kText(
                          'Posted 2 days ago',
                          size: 12,
                          color: AppColors.subtitle,
                        ),
                        heightSpace15,
                        Row(
                          children: [
                            Expanded(
                              child: CustomText.kText(
                                'Ready to Move',
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
                                'Semi-Furnished',
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
                                'Freehold',
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
                                border: Border.all(color: AppColors.primary),
                              ),
                            ),
                            widthSpace10,
                            Expanded(
                              child: CustomButton(
                                text: 'Compare',
                                textColor: AppColors.secondary,
                                color: transparent,
                                border: Border.all(color: AppColors.secondary),
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
                  heightSpace40,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
