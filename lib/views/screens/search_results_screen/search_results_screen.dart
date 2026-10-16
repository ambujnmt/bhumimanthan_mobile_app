import 'package:bhumi_manthan/utils/app_imports.dart';

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
      appBar: CustomAppbar(title: 'Search Results'),
      body: Column(
        children: [Expanded(child: ListView(children: []))],
      ),
    );
  }
}
