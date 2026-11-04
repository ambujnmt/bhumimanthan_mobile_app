import 'package:bhumi_manthan/utils/app_imports.dart';

import 'project_details_screen_controller.dart';
import 'widgets/prjctds_panel_widget.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  final sc = ScrollController();
  final _con = Get.put(ProjectDetailsScreenController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _con.isLoading.value
          ? Scaffold(
              appBar: CustomAppbar(title: 'Details'),
              body: AppLoader.widget(),
            )
          : Scaffold(
              extendBodyBehindAppBar: true,
              appBar: CustomAppbar1(
                error: _con.data.value == null,
                scrollController: sc,
                title: _con.data.value == null
                    ? 'Details'
                    : _con.data.value!.name,
              ),
              body: Obx(
                () => _con.data.value == null
                    ? AppRefreshIndicator(
                        onRefresh: _con.refreshData,
                        child: ApiErrorWidget(),
                      )
                    : ListView(
                        controller: sc,
                        padding: EdgeInsets.zero,
                        children: [
                          // AppFadeAnimatedSwitcher(
                          //   child: _con.isLoading.value
                          //       ? AppNetworkImage(
                          //           imgUrl: _con.data.value?.mainImage ?? '',
                          //           height: Get.height * .4,
                          //           width: Get.width,
                          //           fit: BoxFit.cover,
                          //         )
                          //       : PdsImageWidget(con: _con),
                          // ),
                          AppNetworkImage(
                            height: Get.height * .4,
                            width: Get.width,
                            imgUrl: _con.data.value?.image ?? '',
                            fit: BoxFit.cover,
                          ),
                          Transform.translate(
                            offset: const Offset(0, -AppDimentions.boxRadiusXL),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimentions.defaultScreenPadding,
                              ),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                    AppDimentions.boxRadiusXL,
                                  ),
                                ),
                              ),
                              child: PrjctdsPanelWidget(sc: sc),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
    );
  }
}
