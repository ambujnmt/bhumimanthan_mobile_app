import '../../../models/featured_property_model.dart';
import '../../../utils/app_imports.dart';
import 'widgets/afs_card_widget.dart';

class AllFeaturedPropertiesScreen extends StatefulWidget {
  const AllFeaturedPropertiesScreen({super.key});

  @override
  State<AllFeaturedPropertiesScreen> createState() =>
      _AllFeaturedPropertiesScreenState();
}

class _AllFeaturedPropertiesScreenState
    extends State<AllFeaturedPropertiesScreen> {
  final _api = ApiServices();
  final location = LocationController.currentLocation;

  final sc = ScrollController();

  final isLoading = true.obs;
  final featuredItems = <FeaturedProperty>[].obs;

  Future<void> _getData() async {
    final res = await _api.get(
      '/properties/featured',
      queries: {
        'featured': '1',
        'radius': '100',
        if (location.value != null) ...{
          'latitude': location.value!.lat.toString(),
          'longitude': location.value!.lng.toString(),
        },
      },
    );
    if (!res.success) return;
    featuredItems.value = (res.data['data']['properties'] as List)
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
      appBar: CustomAppbar(scrollController: sc, title: 'Featured Properties'),
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
                  itemCount: featuredItems.length,
                  itemBuilder: (context, index) => FeaturedPropertyCard(
                    label: 'FEATURED',
                    property: featuredItems[index],
                  ),
                  separatorBuilder: (context, index) => heightSpace10,
                ),
        ),
      ),
    );
  }
}
