import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/search_results_screen/widgets/srs_items_widget.dart';
import 'package:bhumi_manthan/views/widgets/app_fade_animated_switcher.dart';

import 'search_results_screen_controller.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final _con = Get.put(SearchResultsScreenController());
  final sc = ScrollController();

  @override
  void initState() {
    super.initState();

    sc.addListener(() {
      if (sc.position.pixels >= sc.position.maxScrollExtent) {
        onScrollEnd();
      }
    });
  }

  void onScrollEnd() {
    debugPrint('Reached end of list');
    _con.loadMore();
  }

  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(scrollController: sc, title: 'Search Results'),
      body: Obx(
        () => AppFadeAnimatedSwitcher(
          child: _con.isLoading.value
              ? AppLoader.widget()
              : _con.items.isEmpty
              ? NoDataAvailable(title: 'No results found')
              : Scrollbar(
                  controller: sc,
                  child: ListView.separated(
                    controller: sc,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(
                      AppDimentions.defaultScreenPadding,
                    ),
                    itemCount: _con.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _con.items.length) {
                        return SizedBox(
                          height: 100,
                          child: Center(
                            child: Obx(
                              () => _con.isLoadingMore.value
                                  ? AppLoader.widget(size: 35)
                                  : _con.isLastPage.value &&
                                        _con.items.length > 4
                                  ? CustomText.kText(
                                      'You have reached the end',
                                      weight: FontWeight.w600,
                                    )
                                  : _con.items.length > 4
                                  ? CustomText.kText(
                                      'Something went wrong!',
                                      color: red,
                                      // Add your preferred text styling here
                                    )
                                  : SizedBox.shrink(),
                            ),
                          ),
                        );
                      }

                      return SrsItemsWidget(item: _con.items[index]);
                    },
                    separatorBuilder: (context, index) => heightSpace10,
                  ),
                ),
        ),
      ),
    );
  }
}
