import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/search_results_screen/widgets/srs_items_widget.dart';

import '../bottom_tab_screens/home_screen/widgets/home_data.dart';
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: sc,
              padding: const EdgeInsets.all(16),
              itemCount: cityItems.length,
              itemBuilder: (context, index) =>
                  SrsItemsWidget(item: cityItems[index]),
            ),
          ),
        ],
      ),
    );
  }
}
