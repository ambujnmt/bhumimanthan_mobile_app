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
  final sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(scrollController: sc, title: 'Search Results'),
      body: Obx(
        () => _con.isLoading.value
            ? AppLoader.widget()
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: sc,
                      padding: const EdgeInsets.all(16),
                      itemCount: _con.items.length,
                      itemBuilder: (context, index) =>
                          SrsItemsWidget(item: _con.items[index]),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
