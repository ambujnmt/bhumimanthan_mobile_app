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
                        controller: _con.textController,
                        focusNode: _con.textNode,
                        onChanged: (value) => _con.getSuggesttions(),
                        textAlignVertical: TextAlignVertical.center,
                        textCapitalization: TextCapitalization.sentences,
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
                    Obx(() {
                      return _con.selectedTags.isEmpty
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
                                  child: Obx(
                                    () => SizedBox(
                                      width: Get.width,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.all(
                                          AppDimentions.screenPaddingXS,
                                        ),
                                        child: Row(
                                          spacing: 8,
                                          children: _con.selectedTags.map((
                                            tag,
                                          ) {
                                            return InkWell(
                                              onTap: () => _con.removeTag(tag),
                                              child: AppContainer(
                                                color: fromHex('ffe8d1'),
                                                borderColor: transparent,
                                                borderRadius:
                                                    AppDimentions.boxRadiusXXS,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: AppDimentions
                                                      .screenPaddingXS,
                                                  vertical: AppDimentions
                                                      .screenPaddingXXS,
                                                ),
                                                child: IntrinsicWidth(
                                                  child: Row(
                                                    children: [
                                                      CustomText.kText(
                                                        tag.title,
                                                        size: 13,
                                                        color: grey[700],
                                                      ),
                                                      widthSpace6,
                                                      Icon(
                                                        Icons.close,
                                                        size: 15,
                                                        color:
                                                            AppColors.subtitle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                    }),
                  ],
                ),
              ),
              heightSpace15,
              ListenableBuilder(
                listenable: _con.textController,
                builder: (context, child) => Obx(
                  () => _con.textController.text.isNotEmpty
                      ? Column(
                          children: _con.suggestions
                              .map(
                                (s) => InkWell(
                                  onTap: () {
                                    if (s.type == 'city' &&
                                        _con.selectedTags.any(
                                          (u) => u.type == s.type,
                                        )) {
                                      return;
                                    }
                                    _con.addTag(s);
                                    _con.textController.clear();
                                    _con.suggestions.clear();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: grey.shade300,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5.0,
                                          ),
                                          child: Icon(
                                            Icons.call_made,
                                            size: 15,
                                            color: grey,
                                          ),
                                        ),
                                        widthSpace10,
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText.kText(
                                                s.title,
                                                size: 13,
                                                weight: FontWeight.w600,
                                              ),
                                              CustomText.kText(
                                                s.type == 'city'
                                                    ? 'City'
                                                    : 'Locality',
                                                color: grey,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      : _con.selectedTags.isNotEmpty ||
                            _con.selectedTags.any((t) => t.type == 'city')
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.kText(
                              'Localities',
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
                                  children: _con.localities
                                      .where(
                                        (t) => _con.selectedTags.every(
                                          (o) => o.title != t,
                                        ),
                                      )
                                      .map((name) {
                                        return GestureDetector(
                                          onTap: () => _con.addTag(
                                            SearchTag(
                                              title: name,
                                              type: 'locality',
                                            ),
                                          ),
                                          child: AppContainer(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  AppDimentions.screenPaddingXS,
                                              vertical: AppDimentions
                                                  .screenPaddingXXS,
                                            ),
                                            child: IntrinsicWidth(
                                              child: Row(
                                                children: [
                                                  Icon(Icons.add, size: 14),
                                                  widthSpace2,
                                                  CustomText.kText(
                                                    name,
                                                    size: 13,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.kText(
                              'Popular cities',
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
                                  children: _con.cities.map((city) {
                                    return GestureDetector(
                                      onTap: () => _con.addTag(
                                        SearchTag(title: city, type: 'city'),
                                      ),
                                      child: AppContainer(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              AppDimentions.screenPaddingXS,
                                          vertical:
                                              AppDimentions.screenPaddingXXS,
                                        ),
                                        child: IntrinsicWidth(
                                          child: Row(
                                            children: [
                                              Icon(Icons.add, size: 14),
                                              widthSpace2,
                                              CustomText.kText(city, size: 13),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
        // Obx(
        //   () => _con.selectedTags.isEmpty
        //       ? SizedBox.shrink()
        //       : Padding(
        //           padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
        //           child: Row(
        //             children: [
        //               Expanded(
        //                 child: CustomButton(
        //                   text: 'Clear All',
        //                   color: transparent,
        //                   border: Border.all(
        //                     color: AppColors.secondary,
        //                     width: 1.5,
        //                   ),
        //                   textColor: AppColors.secondary,
        //                   onTap: () => _con.selectedTags.clear(),
        //                 ),
        //               ),
        //               widthSpace10,
        //               Expanded(
        //                 child: CustomButton(
        //                   text: 'Next',
        //                   onTap: () => _con.showFilters(true),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        // ),
      ],
    );
  }
}

// final _inputBorder = UnderlineInputBorder(
//   borderSide: BorderSide(color: grey[200]!, width: 1.2),
// );
final _inputBorder = InputBorder.none;
