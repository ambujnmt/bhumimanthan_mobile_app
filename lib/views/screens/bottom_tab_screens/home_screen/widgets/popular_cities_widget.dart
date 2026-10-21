import '../../../../../utils/app_imports.dart';
import '../home_screen_controller.dart';

class PopularCitiesWidget extends StatelessWidget {
  PopularCitiesWidget({super.key});
  final _con = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Popular Cities',
      // onViewAll: () {},
      content: Obx(
        () => _con.cities.isEmpty
            ? noDataAvailable(isScrollable: false, height: 80)
            : SizedBox(
                height: 95,
                width: Get.width,
                child: ListView.separated(
                  itemCount: _con.cities.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimentions.defaultScreenPadding,
                    vertical: 2,
                  ),
                  itemBuilder: (context, index) {
                    final item = _con.cities[index];
                    return SizedBox(
                      width: 75,
                      child: Column(
                        children: [
                          AppContainer(
                            width: 65,
                            height: 65,
                            shape: BoxShape.circle,
                            padding: EdgeInsets.zero,
                            clip: Clip.hardEdge,
                            borderColor: AppColors.hint1,
                            child: AppNetworkImage(
                              imgUrl: item.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Spacer(flex: 10),
                          CustomText.kText(
                            item.name,
                            size: 13,
                            lines: 1,
                            weight: FontWeight.bold,
                            color: AppColors.subtitle,
                          ),
                          Spacer(flex: 1),
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
