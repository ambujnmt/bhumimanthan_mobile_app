import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/home_screen_controller.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/widgets/distance_widget.dart';

import '../../../../../utils/app_imports.dart';

class FeaturedProperties extends StatelessWidget {
  FeaturedProperties({super.key});
  final _con = Get.find<HomeScreenController>();
  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Featured Properties',
      onViewAll: () => Get.toNamed(AppRoutes.allFeaturedPropertiesScreen),
      content: Obx(
        () => _con.featuredItems.isEmpty
            ? NoDataAvailable(isScrollable: false, height: 80)
            : SizedBox(
                height: 160,
                child: ListView.separated(
                  itemCount: _con.featuredItems.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimentions.defaultScreenPadding,
                    vertical: 2,
                  ),
                  itemBuilder: (context, index) {
                    final item = _con.featuredItems[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        AppRoutes.propertyDetailsScreen,
                        arguments: {'id': item.id},
                      ),
                      child: AppContainer(
                        width: 330,
                        clip: Clip.hardEdge,
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Stack(
                                children: [
                                  AppNetworkImage(
                                    imgUrl: item.mainImage,
                                    height: Get.height,
                                    width: Get.width,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: distanceWidget(
                                      item.distanceKm.toStringAsFixed(0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                width: Get.width,
                                padding: EdgeInsets.symmetric(
                                  vertical: AppDimentions.screenPaddingXS,
                                  horizontal: AppDimentions.screenPaddingS,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText.kText(
                                      item.title,
                                      size: 16,
                                      weight: FontWeight.w600,
                                      family: CustomFonts.outfit,
                                    ),
                                    heightSpace7,
                                    Row(
                                      children: [
                                        Image.asset(
                                          Images.mapPinIcon,
                                          height: 15,
                                          width: 15,
                                        ),
                                        widthSpace5,
                                        Expanded(
                                          child: CustomText.kText(
                                            item.location,
                                            size: 12,
                                            lines: 1,
                                            color: AppColors.subtitle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    CustomText.kText(
                                      formatPrice(item.price),
                                      size: 14,
                                      lines: 1,
                                      weight: FontWeight.w700,
                                      color: AppColors.primary,
                                      family: CustomFonts.outfit,
                                    ),
                                    CustomText.kText(
                                      '${item.superArea} Sq.Ft.',
                                      size: 12,
                                      lines: 1,
                                      color: AppColors.subtitle,
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CustomText.kText(
                                          'Ready to Move',
                                          size: 12,
                                          lines: 1,
                                          weight: FontWeight.w600,
                                          family: CustomFonts.outfit,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => widthSpace15,
                ),
              ),
      ),
    );
  }
}
