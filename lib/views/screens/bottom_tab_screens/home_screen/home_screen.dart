import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/home_screen_controller.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/widgets/featured_properties.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/widgets/home_banner_widget.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/widgets/home_data.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/widgets/luxury_perperties.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/widgets/premium_projects.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _con = Get.put(HomeScreenController());
  final sc = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: Get.mediaQuery.padding.top),
          SizedBox(
            height: 65,
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
            child: Obx(
              () => AppRefreshIndicator(
                onRefresh: _con.refreshData,
                child: _con.isLoading.value
                    ? AppLoader.widget()
                    : ListView(
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
                              hintText:
                                  'Search apartments, societies, builders...',
                              prefixIcon: Image.asset(
                                Images.searchIcon,
                                height: 20,
                                width: 20,
                              ),
                              onTap: () => Get.toNamed(AppRoutes.searchScreen),
                              bottomPad: 20,
                            ),
                          ),
                          HomeBannerSlider(),
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
                                              Image.asset(
                                                height: 25,
                                                width: 25,
                                                c.icon,
                                              ),
                                              heightSpace7,
                                              CustomText.kText(
                                                c.title,
                                                size: 14,
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
                          heightSpace20,
                          FeaturedProperties(),
                          heightSpace20,
                          PremiumProjects(),
                          heightSpace20,
                          SectionWidget(
                            title: 'Popular Cities',
                            onViewAll: () {},
                            content: SizedBox(
                              height: 95,
                              width: Get.width,
                              child: ListView.separated(
                                itemCount: cityItems.length,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      AppDimentions.defaultScreenPadding,
                                  vertical: 2,
                                ),
                                itemBuilder: (context, index) {
                                  final item = cityItems[index];
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
                                        Spacer(flex: 1),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    widthSpace15,
                              ),
                            ),
                          ),
                          heightSpace20,
                          LuxuryPerperties(),
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
                                  horizontal:
                                      AppDimentions.defaultScreenPadding,
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
                                              vertical:
                                                  AppDimentions.screenPaddingXS,
                                              horizontal:
                                                  AppDimentions.screenPaddingS,
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
                                                      family:
                                                          CustomFonts.outfit,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .keyboard_arrow_right,
                                                      size: 20,
                                                      color: AppColors.primary,
                                                    ),
                                                    widthSpace5,
                                                    Expanded(
                                                      child: CustomText.kText(
                                                        item.size,
                                                        size: 12,
                                                        lines: 1,
                                                        color:
                                                            AppColors.subtitle,
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
                                separatorBuilder: (context, index) =>
                                    widthSpace15,
                              ),
                            ),
                          ),
                          heightSpace100,
                        ],
                      ),
              ),
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
