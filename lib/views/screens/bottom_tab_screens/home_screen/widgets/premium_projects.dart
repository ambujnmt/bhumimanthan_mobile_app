import '../../../../../utils/app_imports.dart';
import '../home_screen_controller.dart';

class PremiumProjects extends StatelessWidget {
  PremiumProjects({super.key});
  final _con = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'New Launch & Premium Projects',
      onViewAll: () {},
      content: Obx(
        () => _con.projects.isEmpty
            ? noDataAvailable(isScrollable: false, height: 80)
            : SizedBox(
                height: 300,
                child: ListView.separated(
                  itemCount: _con.projects.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimentions.defaultScreenPadding,
                    vertical: 2,
                  ),
                  itemBuilder: (context, index) {
                    final item = _con.projects[index];
                    return AppContainer(
                      width: 250,
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
                                  CustomText.kText(
                                    item.builderName,
                                    size: 12,
                                    weight: FontWeight.bold,
                                    color: AppColors.subtitle,
                                  ),
                                  CustomText.kText(
                                    item.name,
                                    size: 17,
                                    weight: FontWeight.w700,
                                    family: CustomFonts.outfit,
                                  ),
                                  CustomText.kText(
                                    item.location,
                                    size: 12,
                                    color: AppColors.subtitle,
                                  ),
                                  Spacer(),
                                  CustomText.kText(
                                    formatPrice(item.startingPrice),
                                    size: 14,
                                    lines: 1,
                                    weight: FontWeight.w700,
                                    color: AppColors.primary,
                                    family: CustomFonts.outfit,
                                  ),
                                  CustomText.kText(
                                    item.configuration,
                                    size: 12,
                                    lines: 1,
                                    color: AppColors.subtitle,
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ],
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
