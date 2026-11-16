import 'package:bhumi_manthan/utils/app_imports.dart';

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
          // SizedBox(
          //   width: Get.width,
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     padding: EdgeInsets.symmetric(
          //       horizontal: AppDimentions.defaultScreenPadding,
          //       vertical: 5,
          //     ),
          //     child: Row(
          //       spacing: 10,
          //       children:
          //           _con.category?.children
          //               .map((item) => Tab(text: item.name))
          //               .toList() ??
          //           [],
          //     ),
          //   ),
          // ),
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            controller: _con.tabController,
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
          heightSpace10,
          Expanded(
            child: TabBarView(
              controller: _con.tabController,
              children: _con.category!.children
                  .map((sc) => SizedBox(child: Center(child: Text(sc.name))))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
