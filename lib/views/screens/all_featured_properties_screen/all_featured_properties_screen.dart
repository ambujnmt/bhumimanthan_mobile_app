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

  Future<bool> _getData() async {
    final res = await _api.get(
      '/properties/featured',
      queries: {'featured': '1'},
    );
    if (!res.success) return false;
    featuredItems.addAll(
      JsonParser.parseList<FeaturedProperty>(
        res.data['data']['properties'],
        (json) => FeaturedProperty.fromJson(json),
      ),
    );
    // final lastPage = res.data['data']['pagination']['last_page'];
    // isLastPage.value = _currentPage >= lastPage;
    return true;
  }

  // final isLastPage = false.obs;
  // final isLoadingMore = false.obs;
  // final _perPage = '12';
  // int _currentPage = 1;

  // Future<void> loadMore() async {
  //   if (isLoadingMore.value) {
  //     debugPrint('skip more loading, wait for running loader');
  //     return;
  //   }

  //   if (isLastPage.value) {
  //     debugPrint('skip more loading, reached last page');
  //     return;
  //   }

  //   _currentPage++;
  //   isLoadingMore(true);
  //   final success = await _getData();
  //   isLoadingMore(false);
  //   if (success) return;
  //   _currentPage--;
  // }

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
