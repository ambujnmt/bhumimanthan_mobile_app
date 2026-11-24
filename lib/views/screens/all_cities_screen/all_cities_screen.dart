import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/all_cities_screen/all_cities_screen_controller.dart';

class AllCitiesScreen extends StatefulWidget {
  const AllCitiesScreen({super.key});

  @override
  State<AllCitiesScreen> createState() => _AllCitiesScreenState();
}

class _AllCitiesScreenState extends State<AllCitiesScreen> {
  final _con = Get.put(AllCitiesScreenController());
  final sc = ScrollController();
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(scrollController: sc, title: 'Cities'),
      body: Obx(
        () => AppFadeAnimatedSwitcher(
          child: _con.isLoading.value
              ? AppLoader.widget()
              : _con.cities.value == null
              ? ApiErrorWidget()
              : _con.cities.value!.isEmpty
              ? NoDataAvailable()
              : ListView(
                  controller: sc,
                  padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                  children: [
                    AppTextfield(
                      hintText: 'Search cities...',
                      node: _con.fNode,
                      controller: searchController,
                      prefixIcon: Icon(Icons.search),
                      onChanged: (input) => _con.searchCity(input),
                      actions: [
                        Obx(
                          () => _con.filteredCities.value == null
                              ? SizedBox.shrink()
                              : InkWell(
                                  onTap: () {
                                    closeKeyboard();
                                    _con.filteredCities.value = null;
                                    searchController.clear();
                                  },
                                  child: Icon(Icons.close),
                                ),
                        ),
                        widthSpace4,
                      ],
                    ),

                    Obx(() {
                      final list = _con.filteredCities.value == null
                          ? _con.cities.value!
                          : _con.filteredCities.value!;

                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        child: KeyedSubtree(
                          key: ValueKey(list.map((e) => e.image).join(',')),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                            padding: const EdgeInsets.only(bottom: 100),
                            itemBuilder: (context, index) {
                              final city = list[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.allPropertiesInCity,
                                    arguments: {'data': city},
                                  );
                                  // searchController.clear();
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    AppDimentions.boxRadiusS,
                                  ),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      AppNetworkImage(
                                        imgUrl: city.image,
                                        fit: BoxFit.cover,
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withValues(
                                                alpha: 0.8,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 12,
                                        right: 12,
                                        bottom: 13,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              city.name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${city.propertiesCount > 99 ? '99+' : city.propertiesCount} Properties',
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }),

                    // Expanded(child:GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder)),
                  ],
                ),
        ),
      ),
    );
  }
}
