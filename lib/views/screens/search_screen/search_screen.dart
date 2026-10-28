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
      body: Obx(
        () => _con.isLoading.value
            ? AppLoader.widget()
            : Column(
                children: [
                  Container(color: white, height: Get.mediaQuery.padding.top),
                  Container(
                    color: white,
                    child: Row(
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
                                    (j) => InkWell(
                                      onTap: () => _con.selectedTab(j),
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
                            height: 30,
                            width: 30,
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
    );
  }
}
