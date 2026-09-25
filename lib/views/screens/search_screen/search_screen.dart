import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/search_screen/search_screen_controller.dart';

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
      body: Column(
        children: [
          Container(color: white, height: Get.mediaQuery.padding.top),
          Container(
            color: white,
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                    child: Row(
                      spacing: 8,
                      children: _appbarItems
                          .map(
                            (j) => InkWell(
                              onTap: () => _con.selectedMainTag(j),
                              child: Obx(() {
                                final isActive =
                                    j == _con.selectedMainTag.value;
                                return AppContainer(
                                  color: isActive ? AppColors.primary : white,
                                  borderRadius: 100,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        AppDimentions.defaultScreenPadding,
                                    vertical: AppDimentions.screenPaddingXS,
                                  ),
                                  child: CustomText.kText(
                                    j,
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
                AppContainer(
                  height: 30,
                  width: 30,
                  shape: BoxShape.circle,
                  color: grey[300]!,
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.close, color: AppColors.subtitle, size: 20),
                ),
                widthSpace12,
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
              children: [
                AppContainer(
                  padding: EdgeInsets.zero,
                  clip: Clip.hardEdge,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 55,
                        child: TextField(
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Search locality, projects or builders',
                            hintStyle: CustomText.kTextStyle(
                              color: grey,
                              size: 16,
                            ),
                            border: _inputBorder,
                            errorBorder: _inputBorder,
                            enabledBorder: _inputBorder,
                            focusedBorder: _inputBorder,
                            disabledBorder: _inputBorder,
                            focusedErrorBorder: _inputBorder,
                            prefixIcon: IntrinsicWidth(
                              child: Center(
                                child: Image.asset(
                                  Images.searchIcon,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(minHeight: 50),
                        padding: EdgeInsets.all(AppDimentions.screenPaddingXS),
                        child: Obx(
                          () => SizedBox(
                            width: Get.width,
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _con.selectedTags.map((suggestion) {
                                return AppContainer(
                                  color: fromHex('ffe8d1'),
                                  borderColor: transparent,
                                  borderRadius: AppDimentions.boxRadiusXS,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppDimentions.screenPaddingXS,
                                    vertical: AppDimentions.screenPaddingXXS,
                                  ),
                                  child: IntrinsicWidth(
                                    child: Row(
                                      children: [
                                        CustomText.kText(
                                          suggestion,
                                          size: 14,
                                          weight: FontWeight.w400,
                                          color: grey[700],
                                        ),
                                        widthSpace6,
                                        InkWell(
                                          onTap: () =>
                                              _con.selectedTags.removeWhere(
                                                (r) => r == suggestion,
                                              ),
                                          child: Icon(
                                            Icons.close,
                                            size: 15,
                                            color: AppColors.subtitle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                heightSpace15,
                CustomText.kText(
                  'Similar Localities',
                  size: 14,
                  weight: FontWeight.w600,
                  family: CustomFonts.outfit,
                  color: AppColors.subtitle,
                ),
                heightSpace10,
                SizedBox(
                  width: Get.width,
                  child: Obx(
                    () => Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: _suggestions
                          .where((t) => !_con.selectedTags.contains(t))
                          .map((suggestion) {
                            return GestureDetector(
                              onTap: () => _con.selectedTags.add(suggestion),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppDimentions.screenPaddingS,
                                  vertical: AppDimentions.screenPaddingXXS,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: CustomText.kText(
                                  suggestion,
                                  size: 14,
                                  weight: FontWeight.w400,
                                ),
                              ),
                            );
                          })
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
            child: Column(
              children: [
                CustomButton(text: 'Next'),
                heightSpace10,
                CustomButton(
                  text: 'Clear All',
                  color: transparent,
                  border: Border.all(color: AppColors.secondary, width: 1.5),
                  textColor: AppColors.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final _appbarItems = ['Buy', 'Rent', 'Commercial', 'Flat', 'Villa'];

final _suggestions = [
  'Sector 62',
  'Electronic City',
  'Sector 18',
  'Sector 137',
  'Botanical Garden',
  'Sector 150',
];

final _inputBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: grey[300]!, width: 1.2),
);
