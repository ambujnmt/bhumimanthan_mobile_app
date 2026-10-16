import '../../../../utils/app_imports.dart';
import '../../bottom_tab_screens/home_screen/home_screen.dart';
import '../search_screen_controller.dart';

class FiltersWidget extends StatefulWidget {
  const FiltersWidget({super.key});

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  final _con = Get.find<SearchScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(
              vertical: AppDimentions.defaultScreenPadding,
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimentions.defaultScreenPadding,
                ),
                child: Column(
                  children: [
                    AppContainer(
                      padding: EdgeInsets.all(AppDimentions.screenPaddingXS),
                      clip: Clip.hardEdge,
                      borderColor: grey.shade300,
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
                                borderRadius: AppDimentions.boxRadiusXXS,
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
                    heightSpace10,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _con.showFilters(false),
                          child: AppContainer(
                            padding: EdgeInsets.all(
                              AppDimentions.screenPaddingXXS,
                            ),
                            borderRadius: AppDimentions.boxRadiusXXS,
                            borderColor: grey.shade300,
                            child: Row(
                              children: [
                                Icon(Icons.add, size: 18, color: grey),
                                CustomText.kText(
                                  'Add More',
                                  color: grey,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              heightSpace10,
              Container(
                width: Get.width,
                color: white,
                child: Padding(
                  padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.kText(
                        'Budget in Rs',
                        family: CustomFonts.outfit,
                        size: 14,
                        color: AppColors.subtitle,
                        weight: FontWeight.w600,
                      ),
                      heightSpace10,
                      Row(
                        children: [
                          _budgetWidget(title: 'Min ₹'),
                          widthSpace10,
                          _budgetWidget(title: 'Max ₹'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              heightSpace10,
              Container(
                width: Get.width,
                color: white,
                child: Padding(
                  padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.kText(
                        'Property Type',
                        family: CustomFonts.outfit,
                        size: 14,
                        color: AppColors.subtitle,
                        weight: FontWeight.w600,
                      ),
                      heightSpace10,
                      Row(
                        spacing: 10,
                        children: categories
                            .map(
                              (c) => Expanded(
                                child: AppContainer(
                                  color: c.title == 'Flat'
                                      ? fromHex('ffe8d1')
                                      : white,
                                  borderColor: grey.shade300,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        height: 25,
                                        width: 25,
                                        c.icon,
                                      ),
                                      heightSpace7,
                                      CustomText.kText(c.title, size: 14),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              heightSpace10,
              Container(
                width: Get.width,
                color: white,
                child: Padding(
                  padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.kText(
                        'No of Bed Rooms',
                        family: CustomFonts.outfit,
                        size: 14,
                        color: AppColors.subtitle,
                        weight: FontWeight.w600,
                      ),
                      heightSpace10,
                      AppContainer(
                        clip: Clip.hardEdge,
                        padding: EdgeInsets.zero,
                        borderColor: grey.shade300,
                        child: Row(
                          children: List.generate(_items.length, (index) {
                            return Expanded(
                              child: Container(
                                height: 40,
                                color: index == 0 ? fromHex('ffe8d1') : null,
                                child: Row(
                                  children: [
                                    if (index != 0 || index == _items.length)
                                      SizedBox(
                                        height: 40,
                                        child: VerticalDivider(
                                          width: 0,
                                          thickness: 1.3,
                                          color: grey.shade300,
                                        ),
                                      ),
                                    Expanded(
                                      child: Center(
                                        child: CustomText.kText(
                                          _items[index],
                                          size: 14,
                                          weight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              heightSpace10,
              Container(
                width: Get.width,
                color: white,
                child: Padding(
                  padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.kText(
                        'Furnishing Status',
                        family: CustomFonts.outfit,
                        size: 14,
                        color: AppColors.subtitle,
                        weight: FontWeight.w600,
                      ),
                      heightSpace10,
                      Row(
                        spacing: 10,
                        children: ['Furnished', 'Semi Furnished', 'Unfurnished']
                            .map(
                              (c) => Expanded(
                                child: AppContainer(
                                  height: 45,
                                  color: c == 'Furnished'
                                      ? fromHex('ffe8d1')
                                      : white,
                                  padding: EdgeInsets.zero,
                                  borderRadius: AppDimentions.boxRadiusXXS,
                                  child: Center(
                                    child: CustomText.kText(
                                      c,
                                      size: 14,
                                      color: AppColors.subtitle,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              heightSpace100,
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
                        text: 'Show 542 Properties',
                        onTap: () => Get.toNamed(AppRoutes.searchResultsScreen),
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
                        onTap: () {
                          _con.selectedTags.clear();
                          _con.showFilters(false);
                        },
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

Expanded _budgetWidget({required String title}) {
  return Expanded(
    child: AppContainer(
      clip: Clip.hardEdge,
      padding: EdgeInsets.zero,
      borderColor: grey.shade300,
      child: Row(
        children: [
          Container(
            width: 70,
            height: 50,
            color: fromHex('ffe8d1'),
            child: Center(
              child: CustomText.kText(title, size: 14, weight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 50,
            child: VerticalDivider(width: 0, color: grey.shade300),
          ),
          widthSpace5,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText.kText('5L', weight: FontWeight.w700),
                widthSpace10,
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

final _items = ['1 BHK', '2 BHK', '3 BHK', '4 BHK', '4+ BHK'];
