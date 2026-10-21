import 'package:bhumi_manthan/models/blog_model.dart';

import '../../../utils/app_imports.dart';
import '../bottom_tab_screens/home_screen/home_screen_controller.dart';

class AllBlogsScreen extends StatefulWidget {
  const AllBlogsScreen({super.key});

  @override
  State<AllBlogsScreen> createState() => _AllBlogsScreenState();
}

class _AllBlogsScreenState extends State<AllBlogsScreen> {
  final homeCon = Get.find<HomeScreenController>();
  final _api = ApiServices();

  final sc = ScrollController();

  final isLoading = true.obs;

  final items = <BlogModel>[].obs;

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
    items.value = (res.data['data']['properties'] as List)
        .map((json) => BlogModel.fromJson(json))
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
                  itemBuilder: (context, index) => AppContainer(
                    // label: 'LUXURY',
                    // property: featuredItems[index],
                  ),
                  separatorBuilder: (context, index) => heightSpace10,
                ),
        ),
      ),
    );
  }
}
