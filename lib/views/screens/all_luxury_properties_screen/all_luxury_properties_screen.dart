import '../../../models/featured_property_model.dart';
import '../../../utils/app_imports.dart';
import '../all_featured_properties_screen/widgets/afs_card_widget.dart';
import '../bottom_tab_screens/home_screen/home_screen_controller.dart';

class AllLuxuryPropertiesScreen extends StatefulWidget {
  const AllLuxuryPropertiesScreen({super.key});

  @override
  State<AllLuxuryPropertiesScreen> createState() =>
      _AllLuxuryPropertiesScreenState();
}

class _AllLuxuryPropertiesScreenState extends State<AllLuxuryPropertiesScreen> {
  final homeCon = Get.find<HomeScreenController>();
  final _api = ApiServices();

  final sc = ScrollController();

  final isLoading = true.obs;
  final featuredItems = <FeaturedProperty>[].obs;

  Future<void> _getData() async {
    final res = await _api.get(
      '/properties/luxury',
      queries: {
        'luxury': '1',
        'latitude': homeCon.position!.latitude.toString(),
        'longitude': homeCon.position!.longitude.toString(),
        'radius': '100',
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
      appBar: CustomAppbar(scrollController: sc, title: 'Luxury Properties'),
      body: Obx(
        () => isLoading.value
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
                  label: 'LUXURY',
                  property: featuredItems[index],
                ),
                separatorBuilder: (context, index) => heightSpace10,
              ),
      ),
    );
  }
}
