import '../../../../../utils/app_imports.dart';
import '../home_screen_controller.dart';

class PopularCitiesWidget extends StatelessWidget {
  PopularCitiesWidget({super.key});
  final _con = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Popular Cities',
      onViewAll: () => Get.toNamed(AppRoutes.allCitiesScreen),
      content: Obx(
        () => _con.cities.isEmpty
            ? NoDataAvailable(isScrollable: false, height: 80)
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimentions.defaultScreenPadding,
                  vertical: 2,
                ),
                child: Row(
                  spacing: 12,
                  children: _con.cities
                      .map(
                        (item) => InkWell(
                          onTap: () => Get.toNamed(
                            AppRoutes.allPropertiesInCity,
                            arguments: {'data': item},
                          ),
                          child: AppContainer(
                            borderRadius: AppDimentions.boxRadiusL,
                            padding: EdgeInsets.zero,
                            height: 110,
                            width: 100,
                            clip: Clip.antiAlias,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AppNetworkImage(
                                  imgUrl: item.image,
                                  fit: BoxFit.cover,
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.8),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  right: 10,
                                  bottom: 13,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText.kText(
                                        item.propertiesCount > 99
                                            ? '99+'
                                            : item.propertiesCount.toString(),
                                        color: Colors.white70,
                                        size: 11,
                                      ),
                                      CustomText.kText(
                                        'Properties',
                                        color: Colors.white70,
                                        size: 11,
                                      ),
                                      CustomText.kText(
                                        item.name,
                                        color: Colors.white,
                                        weight: FontWeight.w700,
                                        lines: 1,
                                        size: 13,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
      ),
    );
  }
}
