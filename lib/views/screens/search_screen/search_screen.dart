import 'package:bhumi_manthan/utils/app_imports.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimentions.defaultScreenPadding,
        ),
        child: Column(
          children: [
            SizedBox(height: Get.mediaQuery.padding.top + 20),
            AppTextfield(
              hintText: 'Search locality, projects or builders',
              prefixIcon: Image.asset(Images.searchIcon, height: 20, width: 20),
            ),
            Expanded(child: ListView(children: [])),
          ],
        ),
      ),
    );
  }
}
