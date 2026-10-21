import '../../../../../utils/app_imports.dart';
import '../home_screen_controller.dart';

class LuxuryPerperties extends StatelessWidget {
  LuxuryPerperties({super.key});
  final _con = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Premium Luxury',
      onViewAll: () {},
      content: Obx(
        () => _con.luxuryItems.isEmpty
            ? noDataAvailable(isScrollable: false, height: 80)
            : SizedBox(
                height: 330,
                child: ListView.separated(
                  itemCount: _con.luxuryItems.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimentions.defaultScreenPadding,
                    vertical: 2,
                  ),
                  itemBuilder: (context, index) {
                    final item = _con.luxuryItems[index];
                    return AppContainer(
                      width: 340,
                      clip: Clip.hardEdge,
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 7,
                            child: AppNetworkImage(
                              imgUrl: item.mainImage,
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
                                    size: 17,
                                    lines: 1,
                                    weight: FontWeight.w700,
                                    family: CustomFonts.outfit,
                                  ),
                                  CustomText.kText(
                                    item.location,
                                    size: 12,
                                    lines: 1,
                                    color: AppColors.subtitle,
                                  ),
                                  heightSpace10,
                                  Row(
                                    spacing: 12,
                                    children: [
                                      _customPrope(
                                        'Security',
                                        Icons.shield_outlined,
                                      ),
                                      _customPrope(
                                        'Parking',
                                        Icons.local_parking_outlined,
                                      ),
                                      _customPrope(
                                        'Gym',
                                        Icons.sports_gymnastics,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      CustomText.kText(
                                        formatPrice(item.price),
                                        size: 18,
                                        lines: 1,
                                        weight: FontWeight.w800,
                                        color: AppColors.primary,
                                        family: CustomFonts.outfit,
                                      ),
                                      widthSpace6,
                                      Expanded(
                                        child: CustomText.kText(
                                          '${item.superArea} Sq.Ft.',
                                          size: 12,
                                          lines: 1,
                                          color: AppColors.subtitle,
                                          align: TextAlign.right,
                                        ),
                                      ),
                                    ],
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

Widget _customPrope(String text, IconData icon) {
  return Column(
    children: [
      AppContainer(
        height: 32,
        width: 32,
        color: grey[100]!,
        shape: BoxShape.circle,
        padding: EdgeInsets.zero,
        child: Icon(icon, size: 18),
      ),
      heightSpace4,
      CustomText.kText(text, size: 12),
    ],
  );
}
