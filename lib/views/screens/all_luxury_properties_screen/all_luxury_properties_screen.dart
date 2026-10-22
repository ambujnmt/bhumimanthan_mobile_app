import '../../../models/featured_property_model.dart';
import '../../../utils/app_imports.dart';
import '../all_featured_properties_screen/widgets/afs_card_widget.dart';

class AllLuxuryPropertiesScreen extends StatefulWidget {
  const AllLuxuryPropertiesScreen({super.key});

  @override
  State<AllLuxuryPropertiesScreen> createState() =>
      _AllLuxuryPropertiesScreenState();
}

class _AllLuxuryPropertiesScreenState extends State<AllLuxuryPropertiesScreen> {
  final _api = ApiServices();

  final location = LocationController.currentLocation;

  final sc = ScrollController();

  final isLoading = true.obs;
  final items = <FeaturedProperty>[].obs;

  Future<void> _getData() async {
    final res = await _api.get(
      '/properties/luxury',
      queries: {
        'luxury': '1',
        'radius': '100',
        if (location.value != null) ...{
          'latitude': location.value!.lat.toString(),
          'longitude': location.value!.lng.toString(),
        },
      },
    );
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
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(scrollController: sc, title: 'Luxury Properties'),
      body: Obx(
        () => AppRefreshIndicator(
          onRefresh: refreshData,
          child: isLoading.value
              ? AppLoader.widget()
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
                    label: 'LUXURY',
                    property: items[index],
                  ),
                  separatorBuilder: (context, index) => heightSpace10,
                ),
        ),
      ),
    );
  }
}
