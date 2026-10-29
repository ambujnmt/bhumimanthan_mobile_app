import '../../../../utils/app_imports.dart';
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
              vertical: AppDimentions.screenPaddingXS,
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimentions.defaultScreenPadding,
                ),
                child: Column(
                  children: [
                    AppContainer(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimentions.screenPaddingXS,
                      ),
                      clip: Clip.hardEdge,
                      borderColor: grey.shade300,
                      child: Obx(
                        () => SizedBox(
                          width: Get.width,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimentions.screenPaddingXS,
                            ),
                            child: Row(
                              spacing: 8,
                              children: _con.selectedTags.map((tag) {
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
                                          tag.title,
                                          size: 14,
                                          weight: FontWeight.w400,
                                          color: grey[700],
                                        ),
                                        widthSpace6,
                                        InkWell(
                                          onTap: () => _con.removeTag(tag),
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
                                  color: grey.shade700,
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
                        'Budget',
                        family: CustomFonts.outfit,
                        size: 14,
                        color: AppColors.subtitle,
                        weight: FontWeight.w600,
                      ),
                      heightSpace10,
                      Row(
                        children: [
                          Obx(
                            () => _budgetWidget(
                              title: 'Min ₹',
                              hint: 'No min',
                              val: _con.minBudget.value?.label,
                              onSelected: (budget) => _con.minBudget(budget),
                            ),
                          ),
                          widthSpace10,
                          Obx(
                            () => _budgetWidget(
                              title: 'Max ₹',
                              hint: 'No max',
                              val: _con.maxBudget.value?.label,
                              onSelected: (budget) => _con.maxBudget(budget),
                            ),
                          ),
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(2),
                        child: Row(
                          spacing: 10,
                          children: _con.pTypes
                              .map(
                                (c) => InkWell(
                                  onTap: () => _con.selectedType(c),
                                  child: Obx(
                                    () => AppContainer(
                                      // height: 100,
                                      width: 100,
                                      color:
                                          c.key == _con.selectedType.value?.key
                                          ? fromHex('ffe8d1')
                                          : white,
                                      borderColor: grey.shade300,
                                      child: Column(
                                        children: [
                                          // Image.asset(
                                          //   height: 25,
                                          //   width: 25,
                                          //   c.icon,
                                          // ),
                                          // heightSpace7,
                                          CustomText.kText(
                                            c.label,
                                            size: 14,
                                            lines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              heightSpace10,
              Obx(
                () => AnimatedSize(
                  duration: Duration(milliseconds: 250),
                  child:
                      !['flat', 'house'].contains(_con.selectedType.value?.key)
                      ? SizedBox()
                      : Column(
                          children: [
                            Container(
                              width: Get.width,
                              color: white,
                              child: Padding(
                                padding: EdgeInsets.all(
                                  AppDimentions.defaultScreenPadding,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText.kText(
                                      'Bed Rooms',
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
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                            _con.bedrooms.length,
                                            (i) {
                                              final b = _con.bedrooms[i];
                                              return InkWell(
                                                onTap: () => _con.setBedroom(b),
                                                child: Obx(
                                                  () => Container(
                                                    height: 40,
                                                    width: 100,
                                                    color:
                                                        b ==
                                                            _con
                                                                .selectedBed
                                                                .value
                                                        ? fromHex('ffe8d1')
                                                        : null,
                                                    child: Row(
                                                      children: [
                                                        if (i != 0 ||
                                                            i ==
                                                                _con
                                                                    .bedrooms
                                                                    .length)
                                                          SizedBox(
                                                            height: 40,
                                                            child:
                                                                VerticalDivider(
                                                                  width: 0,
                                                                  thickness:
                                                                      1.3,
                                                                  color: grey
                                                                      .shade300,
                                                                ),
                                                          ),
                                                        Expanded(
                                                          child: Center(
                                                            child:
                                                                CustomText.kText(
                                                                  b.label,
                                                                  size: 14,
                                                                  weight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: grey
                                                                      .shade800,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
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
                                padding: EdgeInsets.all(
                                  AppDimentions.defaultScreenPadding,
                                ),
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
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        spacing: 10,
                                        children: _con.furnishings
                                            .map(
                                              (item) => InkWell(
                                                onTap: () =>
                                                    _con.setFurnishing(item),
                                                child: Obx(
                                                  () => AppContainer(
                                                    borderColor: grey.shade300,
                                                    color:
                                                        item ==
                                                            _con
                                                                .selectedFurnishing
                                                                .value
                                                        ? fromHex('ffe8d1')
                                                        : white,
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: AppDimentions
                                                          .screenPaddingS,
                                                      vertical: AppDimentions
                                                          .screenPaddingXXS,
                                                    ),
                                                    borderRadius: AppDimentions
                                                        .boxRadiusXXS,
                                                    child: Center(
                                                      child: CustomText.kText(
                                                        item.label,
                                                        size: 14,
                                                        color: grey.shade800,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              heightSpace100,
            ],
          ),
        ),
      ],
    );
  }
}

Expanded _budgetWidget({
  required String title,
  required String hint,
  String? val,
  Function(SearchBudget budget)? onSelected,
}) {
  final con = Get.find<SearchScreenController>();
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
            child: PopupMenuButton<SearchBudget>(
              // constraints: const BoxConstraints(minWidth: 300, maxWidth: 400),
              onSelected: (value) => onSelected?.call(value),
              itemBuilder: (context) => con.budgets.map((value) {
                return PopupMenuItem<SearchBudget>(
                  height: 42,
                  value: value,
                  child: CustomText.kText(value.label),
                );
              }).toList(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText.kText(
                    val ?? hint,
                    weight: FontWeight.w600,
                    color: val == null ? grey : black,
                  ),
                  widthSpace10,
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

final _items = ['1 BHK', '2 BHK', '3 BHK', '4 BHK', '4+ BHK'];
