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
      body: Column(
        children: [
          SizedBox(height: Get.mediaQuery.padding.top + 20),
          Container(
            color: white,
            padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
            child: Row(
              children: _appbarItems
                  .map(
                    (j) => AppContainer(
                      color: AppColors.primary,
                      child: CustomText.kText('Buy'),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
              children: [
                AppTextfield(
                  hintText: 'Search locality, projects or builders',
                  prefixIcon: Image.asset(
                    Images.searchIcon,
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final _appbarItems = ['Buy', 'Rent', 'Commercial'];
