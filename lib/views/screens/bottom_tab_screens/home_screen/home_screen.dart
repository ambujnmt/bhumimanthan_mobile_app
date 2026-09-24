import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/widgets/home_data.dart';
import 'package:bhumi_manthan/views/widgets/app_network_image.dart';
import 'package:bhumi_manthan/views/widgets/section_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final sc = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: Get.mediaQuery.padding.top),
          SizedBox(
            height: 70,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimentions.defaultScreenPadding,
                vertical: AppDimentions.screenPaddingS,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Images.appLogo, width: 155),
                  widthSpace5,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppContainer(
                          width: 90,
                          height: 35,
                          borderRadius: AppDimentions.boxRadiusS,
                          color: fromHex('fef5ed'),
                          padding: EdgeInsets.all(
                            AppDimentions.screenPaddingXS,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                Images.mapPinIcon,
                                height: 14,
                                width: 14,
                                color: AppColors.primary,
                              ),
                              widthSpace5,
                              Expanded(
                                child: CustomText.kText(
                                  'Mumbai',
                                  size: 12,
                                  lines: 1,
                                  weight: FontWeight.w700,
                                  align: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        widthSpace10,
                        AppContainer(
                          width: 37,
                          height: 37,
                          shape: BoxShape.circle,
                          padding: EdgeInsets.all(
                            AppDimentions.screenPaddingXS,
                          ),
                          child: Image.asset(Images.alertIcon),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          ListenableBuilder(
            listenable: sc,
            builder: (context, child) {
              return Opacity(
                opacity: scrollProgressOpacity(sc, maxOffset: 50),
                child: Divider(color: grey[300], thickness: 1.5, height: 0),
              );
            },
          ),
          Expanded(
            child: ListView(
              controller: sc,
              padding: EdgeInsets.zero,
              children: [
                heightSpace10,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimentions.defaultScreenPadding,
                  ),
                  child: AppTextfield(
                    readOnly: true,
                    hintText: 'Search apartments, societies, builders...',
                    prefixIcon: Image.asset(
                      Images.searchIcon,
                      height: 20,
                      width: 20,
                    ),
                    onTap: () => Get.toNamed(AppRoutes.searchScreen),
                    bottomPad: 20,
                  ),
                ),
                AppContainer(
                  clip: Clip.hardEdge,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.symmetric(
                    horizontal: AppDimentions.defaultScreenPadding,
                  ),
                  child: Image.asset(Images.homeBanner, fit: BoxFit.cover),
                ),
                heightSpace20,
                SectionWidget(
                  title: 'Categories',
                  content: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimentions.defaultScreenPadding,
                    ),
                    child: Row(
                      spacing: 10,
                      children: categories
                          .map(
                            (c) => Expanded(
                              child: AppContainer(
                                hideShadow: false,
                                borderColor: transparent,
                                child: Column(
                                  children: [
                                    Image.asset(height: 25, width: 25, c.icon),
                                    heightSpace7,
                                    CustomText.kText(c.title, size: 14),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                heightSpace20,
                SectionWidget(
                  title: 'Featured Properties',
                  onViewAll: () {},
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
                        return AppContainer(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                        );
                      },
                      separatorBuilder: (context, index) => widthSpace15,
                    ),
                  ),
                ),
                heightSpace20,
                SectionWidget(
                  title: 'New Launch & Premium',
                  onViewAll: () {},
                  content: SizedBox(
                    height: 300,
                    child: ListView.separated(
                      itemCount: newLaunchedItems.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimentions.defaultScreenPadding,
                        vertical: 2,
                      ),
                      itemBuilder: (context, index) {
                        final item = newLaunchedItems[index];
                        return AppContainer(
                          width: 250,
                          clip: Clip.hardEdge,
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 7,
                                child: AppNetworkImage(
                                  imgUrl: item.img,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText.kText(
                                        item.owner,
                                        size: 12,
                                        weight: FontWeight.bold,
                                        color: AppColors.subtitle,
                                      ),
                                      CustomText.kText(
                                        item.title,
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
                heightSpace20,
                SectionWidget(
                  title: 'Popular Cities',
                  onViewAll: () {},
                  content: SizedBox(
                    height: 85,
                    width: Get.width,
                    child: ListView.separated(
                      itemCount: cityItems.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimentions.defaultScreenPadding,
                        vertical: 2,
                      ),
                      itemBuilder: (context, index) {
                        final item = cityItems[index];
                        return SizedBox(
                          width: 65,
                          child: Column(
                            children: [
                              AppContainer(
                                width: 56,
                                height: 56,
                                shape: BoxShape.circle,
                                padding: EdgeInsets.zero,
                                clip: Clip.hardEdge,
                                borderColor: AppColors.hint1,
                                child: AppNetworkImage(
                                  imgUrl: item.img,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Spacer(flex: 10),
                              CustomText.kText(
                                item.location,
                                size: 13,
                                lines: 1,
                                weight: FontWeight.bold,
                                color: AppColors.subtitle,
                              ),
                              Spacer(flex: 2),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => widthSpace15,
                    ),
                  ),
                ),
                heightSpace20,
                SectionWidget(
                  title: 'Premium Luxury',
                  onViewAll: () {},
                  content: SizedBox(
                    height: 330,
                    child: ListView.separated(
                      itemCount: luxuryItems.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimentions.defaultScreenPadding,
                        vertical: 2,
                      ),
                      itemBuilder: (context, index) {
                        final item = luxuryItems[index];
                        return AppContainer(
                          width: 340,
                          clip: Clip.hardEdge,
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 7,
                                child: AppNetworkImage(
                                  imgUrl: item.img,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            '₹${item.price}',
                                            size: 18,
                                            lines: 1,
                                            weight: FontWeight.w800,
                                            color: AppColors.primary,
                                            family: CustomFonts.outfit,
                                          ),
                                          widthSpace6,
                                          Expanded(
                                            child: CustomText.kText(
                                              item.size,
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
                heightSpace20,
                SectionWidget(
                  title: 'Real Estate News & Insights',
                  onViewAll: () {},
                  content: SizedBox(
                    height: 285,
                    child: ListView.separated(
                      itemCount: insightItems.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimentions.defaultScreenPadding,
                        vertical: 2,
                      ),
                      itemBuilder: (context, index) {
                        final item = insightItems[index];
                        return AppContainer(
                          width: 280,
                          clip: Clip.hardEdge,
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 7,
                                child: AppNetworkImage(
                                  imgUrl: item.img,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CustomText.kText(
                                            'Jan 12, 2025',
                                            size: 12,
                                            lines: 1,
                                            weight: FontWeight.bold,
                                            color: AppColors.subtitle,
                                          ),
                                          Spacer(),
                                          CustomText.kText(
                                            item.owner,
                                            size: 13,
                                            lines: 1,
                                            color: AppColors.subtitle,
                                          ),
                                        ],
                                      ),
                                      heightSpace4,
                                      CustomText.kText(
                                        item.title,
                                        size: 17,
                                        weight: FontWeight.w700,
                                        family: CustomFonts.outfit,
                                      ),
                                      CustomText.kText(
                                        item.location,
                                        size: 12,
                                        lines: 1,
                                        color: AppColors.subtitle,
                                      ),
                                      Spacer(),
                                      Row(
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
                                          widthSpace5,
                                          Expanded(
                                            child: CustomText.kText(
                                              item.size,
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
                heightSpace100,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final categories = <CateModel>[
  CateModel(title: 'Flat', icon: Images.flatIcon),
  CateModel(title: 'Villa', icon: Images.villaIcon),
  CateModel(title: 'Rent', icon: Images.rentIcon),
  CateModel(title: 'Buy', icon: Images.houseIcon),
];

class CateModel {
  final String title;
  final String icon;
  CateModel({required this.title, required this.icon});
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
