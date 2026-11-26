import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/search_results_screen/widgets/srs_items_widget.dart';

import 'search_results_screen_controller.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final _con = Get.put(SearchResultsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        scrollController: _con.scrollController,
        title: 'Search Results',
      ),
      body: Obx(
        () => AppFadeAnimatedSwitcher(
          child: _con.isLoading.value
              ? AppLoader.widget()
              : _con.items.isEmpty
              ? NoDataAvailable(title: 'No results found')
              : Scrollbar(
                  controller: _con.scrollController,
                  child: ListView.separated(
                    controller: _con.scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(
                      AppDimentions.defaultScreenPadding,
                    ),
                    itemCount: _con.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _con.items.length) {
                        return PaginationPageEndWidget(
                          isLoadingMore: _con.isLoadingMore,
                          hasError: _con.hasPaginationError,
                          pagination: _con.pagination,
                          enabled: _con.items.length > 2,
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
