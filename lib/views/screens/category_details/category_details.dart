import 'package:bhumi_manthan/utils/app_imports.dart';

import '../../../models/featured_property_model.dart';
import '../all_featured_properties_screen/widgets/afs_card_widget.dart';
import 'category_details_controller.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final _con = Get.put(CategoryDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: _con.category?.name ?? 'Details'),
      body: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            controller: _con.tabController,
            indicatorColor: AppColors.primary,
            // indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: CustomText.kTextStyle(
              size: 16,
              weight: FontWeight.w600,
              color: AppColors.primary,
            ),
            unselectedLabelStyle: CustomText.kTextStyle(size: 16),
            tabs:
                _con.category?.children
                    .map((item) => Tab(text: item.name))
                    .toList() ??
                [],
          ),
          Expanded(
            child: TabBarView(
              controller: _con.tabController,
              children: _con.category!.children
                  .map((sc) => SubCatTabScreen(subcatId: sc.id))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class SubCatTabScreen extends StatefulWidget {
  final int subcatId;
  const SubCatTabScreen({super.key, required this.subcatId});

  @override
  State<SubCatTabScreen> createState() => _SubCatTabScreenState();
}

class _SubCatTabScreenState extends State<SubCatTabScreen>
    with AutomaticKeepAliveClientMixin {
  final isLoading = true.obs;
  final sc = ScrollController();

  final items = <FeaturedProperty>[].obs;

  Future<void> _getData() async {
    final res = await ApiServices().get('/properties/featured');
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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(
      () => AppRefreshIndicator(
        onRefresh: refreshData,
        child: isLoading.value
            ? AppLoader.widget()
            : items.isEmpty
            ? NoDataAvailable()
            : Scrollbar(
                controller: sc,
                interactive: true,
                radius: Radius.circular(AppDimentions.defaultBoxRadius),
                child: ListView.separated(
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
