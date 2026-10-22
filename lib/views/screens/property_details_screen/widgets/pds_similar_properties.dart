import '../../../../utils/app_imports.dart';
import '../../bottom_tab_screens/home_screen/widgets/home_data.dart';

class PdsSimilarProperties extends StatefulWidget {
  const PdsSimilarProperties({super.key});

  @override
  State<PdsSimilarProperties> createState() => _PdsSimilarPropertiesState();
}

class _PdsSimilarPropertiesState extends State<PdsSimilarProperties> {
  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Similar Properties',
      content: SizedBox(
        height: 160,
        child: ListView.separated(
          itemCount: featuredItems.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
            horizontal: AppDimentions.defaultScreenPadding,
            vertical: 2,
          ),
          itemBuilder: (context, index) {
            final item = featuredItems[index];
            return GestureDetector(
              onTap: () => Get.toNamed(
                AppRoutes.propertyDetailsScreen,
                arguments: {'data': item},
              ),
              child: AppContainer(
                width: 330,
                clip: Clip.hardEdge,
                padding: EdgeInsets.zero,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: AppNetworkImage(
                        imgUrl: item.img,
                        height: Get.height,
                        width: Get.width,
                        fit: BoxFit.cover,
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
                              '₹${item.price}',
                              size: 14,
                              lines: 1,
                              weight: FontWeight.w700,
                              color: AppColors.primary,
                              family: CustomFonts.outfit,
                            ),
                            CustomText.kText(
                              item.size,
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
    );
  }
}
