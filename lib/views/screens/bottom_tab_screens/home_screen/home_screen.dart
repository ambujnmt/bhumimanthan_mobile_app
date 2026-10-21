import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/home_screen_controller.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/widgets/blogs_widget.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/widgets/featured_properties.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/widgets/home_banner_widget.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/widgets/home_data.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/widgets/luxury_perperties.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/home_screen/widgets/popular_cities_widget.dart';
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
                          PopularCitiesWidget(),
                          heightSpace20,
                          LuxuryPerperties(),
                          heightSpace20,
                          BlogsWidget(),
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
