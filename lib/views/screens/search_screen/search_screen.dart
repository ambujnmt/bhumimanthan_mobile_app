import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/search_screen/search_screen_controller.dart';
import 'package:bhumi_manthan/views/screens/search_screen/widgets/filters_widget.dart';
import 'package:bhumi_manthan/views/screens/search_screen/widgets/search_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _con = Get.put(SearchScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => _con.isLoading.value
            ? AppLoader.widget()
            : _con.jsonData == null
            ? errorLoadingData()
            : Column(
                children: [
                  SizedBox(height: Get.mediaQuery.padding.top),
                  Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(
                            AppDimentions.defaultScreenPadding,
                          ),
                          child: Row(
                            spacing: 8,
                            children: _con.tabs
                                .map(
                                  (j) => GestureDetector(
                                    onTap: () => _con.setTab(j),
                                    child: Obx(() {
                                      final isActive =
                                          j == _con.selectedTab.value;
                                      return AppContainer(
                                        color: isActive
                                            ? AppColors.primary
                                            : white,
                                        borderRadius: 100,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: AppDimentions
                                              .defaultScreenPadding,
                                          vertical:
                                              AppDimentions.screenPaddingXS,
                                        ),
                                        child: CustomText.kText(
                                          j.label,
                                          color: isActive ? white : black,
                                          weight: FontWeight.w600,
                                          family: CustomFonts.outfit,
                                        ),
                                      );
                                    }),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      widthSpace12,
                      InkWell(
                        onTap: Get.back,
                        child: AppContainer(
                          height: 32,
                          width: 32,
                          shape: BoxShape.circle,
                          color: grey[300]!,
                          padding: EdgeInsets.zero,
                          child: Icon(
                            Icons.close,
                            color: AppColors.subtitle,
                            size: 20,
                          ),
                        ),
                      ),
                      widthSpace12,
                    ],
                  ),
                  Expanded(
                    child: Obx(
                      () => _con.showFilters.value
                          ? FiltersWidget()
                          : SearchWidget(),
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: AnimatedPadding(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Obx(
          () => _con.selectedTags.isEmpty
              ? SizedBox.shrink()
              : _con.showFilters.value
              ? Padding(
                  padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Clear All',
                          color: transparent,
                          border: Border.all(
                            color: AppColors.secondary,
                            width: 1.5,
                          ),
                          textColor: AppColors.secondary,
                          onTap: () => _con.clearAll(),
                        ),
                      ),
                      widthSpace10,
                      Expanded(
                        child: CustomButton(
                          text: '${_con.pCount.value} Properties',
                          onTap: () => Get.toNamed(
                            AppRoutes.searchResultsScreen,
                            arguments: _con.getQueryParams(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Clear All',
                          color: transparent,
                          border: Border.all(
                            color: AppColors.secondary,
                            width: 1.5,
                          ),
                          textColor: AppColors.secondary,
                          onTap: () => _con.clearAll(),
                        ),
                      ),
                      widthSpace10,
                      Expanded(
                        child: CustomButton(
                          text: 'Next',
                          onTap: () => _con.showFilters(true),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
