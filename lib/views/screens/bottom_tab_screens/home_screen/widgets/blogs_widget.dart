import '../../../../../utils/app_imports.dart';
import '../home_screen_controller.dart';

class BlogsWidget extends StatelessWidget {
  BlogsWidget({super.key});
  final _con = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Real Estate News & Insights',
      onViewAll: () {},
      content: Obx(
        () => _con.blogs.isEmpty
            ? noDataAvailable(isScrollable: false, height: 80)
            : SizedBox(
                height: 285,
                child: ListView.separated(
                  itemCount: _con.blogs.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimentions.defaultScreenPadding,
                    vertical: 2,
                  ),
                  itemBuilder: (context, index) {
                    final item = _con.blogs[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        AppRoutes.blogDetailsScreen,
                        arguments: {'id': item.id},
                      ),
                      child: AppContainer(
                        width: 280,
                        clip: Clip.hardEdge,
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 7,
                              child: AppNetworkImage(
                                imgUrl: item.image,
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
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomText.kText(
                                            'Jan 12, 2025',
                                            size: 12,
                                            lines: 1,
                                            weight: FontWeight.bold,
                                            color: AppColors.subtitle,
                                          ),
                                        ),
                                        // Spacer(),
                                        // CustomText.kText(
                                        //   item.authorName,
                                        //   size: 13,
                                        //   lines: 1,
                                        //   color: AppColors.subtitle,
                                        // ),
                                      ],
                                    ),
                                    heightSpace4,
                                    CustomText.kText(
                                      item.title,
                                      size: 17,
                                      family: CustomFonts.outfit,
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          CustomText.kText(
                                            'Read More',
                                            size: 14,
                                            lines: 1,
                                            weight: FontWeight.w700,
                                            color: AppColors.primary,
                                            family: CustomFonts.outfit,
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            size: 20,
                                            color: AppColors.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
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
