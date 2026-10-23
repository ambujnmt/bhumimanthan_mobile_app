import 'package:bhumi_manthan/controllers/compare_controller.dart';
import 'package:bhumi_manthan/models/compare_tab_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/compare_screen/compare_screen_controller.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  final _con = Get.put(CompareScreenController());
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: CustomAppbar(title: 'Compare'),
    //   body: Obx(
    //     () => DefaultTabController(
    //       length: tabs.length,
    //       child: Column(
    //         children: [
    //           SizedBox(
    //             height: 40,
    //             child: TabBar(
    //               isScrollable: true,
    //               tabAlignment: TabAlignment.start,
    //               indicatorSize: TabBarIndicatorSize.tab,
    //               indicatorColor: AppColors.primary,
    //               indicatorWeight: 4,
    //               dividerColor: AppColors.hint1,
    //               dividerHeight: 2,
    //               labelStyle: CustomText.kTextStyle(
    //                 weight: FontWeight.w600,
    //                 size: 16,
    //                 color: AppColors.primary,
    //               ),
    //               splashFactory: NoSplash.splashFactory,
    //               tabs: tabs.map((e) => Tab(text: e.propertyType.tr)).toList(),
    //             ),
    //           ),
    //           Expanded(
    //             child: Obx(
    //               () => isLoading.value
    //                   ? AppLoader.widget()
    //                   : TabBarView(
    //                       children: tabs
    //                           .map((tab) => _TabsScreen(tab: tab))
    //                           .toList(),
    //                     ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: CustomAppbar(title: 'Compare'),
      body: Obx(
        () => AppRefreshIndicator(
          onRefresh: _con.refreshData,
          child: _con.isLoading.value
              ? AppLoader.widget()
              : _con.tabs.isEmpty
              ? noDataAvailable()
              : ListView.separated(
                  padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                  itemCount: _con.tabs.length,
                  itemBuilder: (context, index) => ComparedTabCard(
                    comparedTab: _con.tabs[index],
                    onCompare: () {},
                  ),
                  separatorBuilder: (context, index) => heightSpace10,
                ),
        ),
      ),
    );
  }
}

class ComparedTabCard extends StatefulWidget {
  final ComparedTab comparedTab;
  final VoidCallback onCompare;

  const ComparedTabCard({
    super.key,
    required this.comparedTab,
    required this.onCompare,
  });

  @override
  State<ComparedTabCard> createState() => _ComparedTabCardState();
}

class _ComparedTabCardState extends State<ComparedTabCard> {
  Future<void> onDelete(int id) async {
    final index = widget.comparedTab.properties.indexWhere((i) => i.id == id);
    if (index == -1) return;

    final old = widget.comparedTab.properties[index];

    setState(() {
      widget.comparedTab.properties.removeAt(index);
    });

    final success = await CompareController.removeCompare(id);

    if (success) {
      if (widget.comparedTab.properties.isEmpty) {
        findController<CompareScreenController>()?.refreshData();
      }
      return;
    }

    if (!mounted) return;

    setState(() {
      widget.comparedTab.properties.insert(
        index.clamp(0, widget.comparedTab.properties.length),
        old,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final canCompare = widget.comparedTab.properties.length > 1;

    return widget.comparedTab.properties.isEmpty
        ? SizedBox.shrink()
        : AppContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.comparedTab.propertyType,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${widget.comparedTab.count}/${widget.comparedTab.max}',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Property list
                ...widget.comparedTab.properties.map(
                  (property) => _propertyItem(
                    property,
                    onDelete: () => onDelete(property.id),
                  ),
                ),

                const SizedBox(height: 12),

                // Compare button
                canCompare
                    ? CustomButton(height: 40, text: 'View Compare')
                    : CustomButton(
                        height: 40,
                        text: 'View Compare',
                        color: grey.shade400,
                        textColor: AppColors.hint,
                      ),
              ],
            ),
          );
  }

  Widget _propertyItem(ComparedProperty property, {VoidCallback? onDelete}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              onTap: () => Get.toNamed(
                AppRoutes.propertyDetailsScreen,
                arguments: {'id': property.id},
              ),
              child: AppNetworkImage(
                imgUrl: property.mainImage,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomText.kText(
                        property.title,
                        lines: 1,
                        size: 14,
                        weight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: onDelete,
                      child: Icon(Icons.delete_outline, color: red, size: 22),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '${property.location}, ${property.city}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 5),
                Text(
                  formatPrice(property.price),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${property.configuration}'
                  '${property.superArea != null ? ' • ${property.superArea} sq.ft.' : ''}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class _TabsScreen extends StatefulWidget {
//   final ComparedTab tab;
//   const _TabsScreen({required this.tab});

//   @override
//   State<_TabsScreen> createState() => __TabsScreenState();
// }

// class __TabsScreenState extends State<_TabsScreen> {
//   final _api = ApiServices();
//   final isLoading = true.obs;

//   final tabs = <ComparedTab>[].obs;

//   Future<void> _getData() async {
//     final res = await _api.get(
//       '/compare',
//       queries: {
//         'property_type': widget.tab.propertyType,
//         'ids': widget.tab.propertyIds.join(','),
//       },
//     );
//     if (!res.success) return;
//     tabs.value = (res.data['data']['groups'] as List)
//         .map((json) => ComparedTab.fromJson(json))
//         .toList();
//   }

//   Future<void> refreshData() async {
//     isLoading(true);
//     await _getData();
//     isLoading(false);
//   }

//   @override
//   void initState() {
//     super.initState();
//     refreshData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
