import '../../../../utils/app_imports.dart';
import '../search_screen_controller.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _con = Get.find<SearchScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
            children: [
              AppContainer(
                padding: EdgeInsets.zero,
                clip: Clip.hardEdge,
                borderColor: grey.shade300,
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
                    Obx(
                      () => _con.selectedTags.isEmpty
                          ? SizedBox.shrink()
                          : Column(
                              children: [
                                Divider(
                                  height: 0,
                                  color: grey.shade300,
                                  thickness: 1.3,
                                ),
                                Container(
                                  constraints: BoxConstraints(minHeight: 50),
                                  padding: EdgeInsets.all(
                                    AppDimentions.screenPaddingXS,
                                  ),
                                  child: Obx(
                                    () => SizedBox(
                                      width: Get.width,
                                      child: Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: _con.selectedTags.map((
                                          suggestion,
                                        ) {
                                          return AppContainer(
                                            color: fromHex('ffe8d1'),
                                            borderColor: transparent,
                                            borderRadius:
                                                AppDimentions.boxRadiusXXS,
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  AppDimentions.screenPaddingXS,
                                              vertical: AppDimentions
                                                  .screenPaddingXXS,
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
                                                    onTap: () => _con
                                                        .selectedTags
                                                        .removeWhere(
                                                          (r) =>
                                                              r == suggestion,
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
                                border: Border.all(color: Colors.grey.shade300),
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
        Obx(
          () => _con.selectedTags.isEmpty
              ? SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                  child: Column(
                    children: [
                      CustomButton(
                        text: 'Next',
                        onTap: () => _con.showFilters(true),
                      ),
                      heightSpace10,
                      CustomButton(
                        text: 'Clear All',
                        color: transparent,
                        border: Border.all(
                          color: AppColors.secondary,
                          width: 1.5,
                        ),
                        textColor: AppColors.secondary,
                        onTap: () => _con.selectedTags.clear(),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

final _suggestions = [
  'Sector 62',
  'Electronic City',
  'Sector 18',
  'Sector 137',
  'Botanical Garden',
  'Sector 150',
];

// final _inputBorder = UnderlineInputBorder(
//   borderSide: BorderSide(color: grey[200]!, width: 1.2),
// );
final _inputBorder = InputBorder.none;
