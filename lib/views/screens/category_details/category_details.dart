import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/events_screen/events_screen.dart';

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
      body: _con.category == null
          ? ApiErrorWidget()
          : Column(
              children: [
                CustomTab(
                  controller: _con.tabController,
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
                        .map(
                          (sc) => SubCatTabScreen(
                            catSlug: _con.category!.slug,
                            subcatSlug: sc.slug,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
    );
  }
}

class SubCatTabScreen extends StatefulWidget {
  final String catSlug;
  final String subcatSlug;
  const SubCatTabScreen({
    super.key,
    required this.catSlug,
    required this.subcatSlug,
  });

  @override
  State<SubCatTabScreen> createState() => _SubCatTabScreenState();
}

class _SubCatTabScreenState extends State<SubCatTabScreen>
    with AutomaticKeepAliveClientMixin {
  final isLoading = true.obs;

  final items = <FeaturedProperty>[].obs;

  Future<bool> _getData() async {
    final res = await ApiServices().get(
      '/categories/${widget.catSlug}/properties',

      queries: {
        'sub_category': widget.subcatSlug,
        'page': (pagination.currentPage + 1).toString(),
        'per_page': pagination.perPage.toString(),
      },
    );
    if (!res.success) return false;
    items.addAll(
      JsonParser.parseList(
        res.data['data']['properties'],
        (json) => FeaturedProperty.fromJson(json),
      ),
    );
    final p = JsonParser.tryParse(
      res.data['data']['pagination'],
      (p) => PaginationModel.fromJson(p),
    );

    if (p != null) {
      pagination = p;
    }

    return true;
  }

  Future<void> refreshData() async {
    isLoading(true);
    await _getData();
    isLoading(false);
  }

  @override
  void initState() {
    super.initState();
    _startListener();
    refreshData();
  }

  final isLoadingMore = false.obs;
  final scrollController = ScrollController();
  final hasPaginationError = false.obs;
  var pagination = PaginationModel();

  Future<void> _loadMore() async {
    isLoadingMore(true);
    hasPaginationError.value = !await _getData();
    isLoadingMore(false);
  }

  void _startListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        _onScrollEnds();
      }
    });
  }

  void _onScrollEnds() {
    final currentPage = pagination.currentPage;
    final lastPage = pagination.lastPage;
    debugPrint('\nPagination:\ncurrent page:$currentPage\nlast page:$lastPage');

    if (isLoadingMore.value) {
      debugPrint('Pagination: Skip more loading, already loading more');
      return;
    }
    if (currentPage >= lastPage) {
      debugPrint('Pagination: Skip more loading, reached last page');
      return;
    }
    debugPrint('Pagination: Loading more...');
    _loadMore();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
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
                controller: scrollController,
                interactive: true,
                radius: Radius.circular(AppDimentions.defaultBoxRadius),
                child: ListView.separated(
                  controller: scrollController,
                  padding: EdgeInsets.fromLTRB(
                    AppDimentions.defaultScreenPadding,
                    AppDimentions.defaultScreenPadding,
                    AppDimentions.defaultScreenPadding,
                    100,
                  ),
                  itemCount: items.length + 1,
                  itemBuilder: (context, index) => index == items.length
                      ? PaginationPageEndWidget(
                          isLoadingMore: isLoadingMore,
                          hasError: hasPaginationError,
                          pagination: pagination,
                          enabled: items.length > 2,
                        )
                      : FeaturedPropertyCard(
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
