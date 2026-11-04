import '../../../models/city_model.dart';
import '../../../models/featured_property_model.dart';
import '../../../utils/app_imports.dart';
import '../all_featured_properties_screen/widgets/afs_card_widget.dart';

class AllPropertiesInCity extends StatefulWidget {
  const AllPropertiesInCity({super.key});

  @override
  State<AllPropertiesInCity> createState() => _AllPropertiesInCityState();
}

class _AllPropertiesInCityState extends State<AllPropertiesInCity> {
  late CityModel city;

  final _api = ApiServices();
  final location = LocationController.currentLocation;

  final sc = ScrollController();

  final isLoading = true.obs;

  final items = <FeaturedProperty>[].obs;

  Future<void> _getData() async {
    final res = await _api.get('/cities/${city.id}');
    if (!res.success) return;
    items.value = (res.data['data']['properties'] as List)
        .map((json) => FeaturedProperty.fromJson(json))
        .toList();
  }

  Future<void> refreshData() async {
    isLoading(true);
    await _getData();
    isLoading(false);
  }

  @override
  void initState() {
    super.initState();
    city = Get.arguments['data'] as CityModel;
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(scrollController: sc, title: city.name),
      body: Obx(
        () => AppRefreshIndicator(
          onRefresh: refreshData,
          child: isLoading.value
              ? AppLoader.widget()
              : items.isEmpty
              ? NoDataAvailable()
              : ListView.separated(
                  controller: sc,
                  padding: EdgeInsets.fromLTRB(
                    AppDimentions.defaultScreenPadding,
                    AppDimentions.defaultScreenPadding,
                    AppDimentions.defaultScreenPadding,
                    100,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) => FeaturedPropertyCard(
                    label: 'FEATURED',
                    property: items[index],
                  ),
                  separatorBuilder: (context, index) => heightSpace10,
                ),
        ),
      ),
    );
  }
}
