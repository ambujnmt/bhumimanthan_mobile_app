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
    return Scaffold(
      backgroundColor: black,
      body: SlidingUpPanel(
        minHeight: Get.height * .6 + AppDimentions.boxRadiusXL,
        maxHeight: Get.height * .95,
        parallaxEnabled: true,
        scrollController: sc,
        body: Align(
          alignment: Alignment.topCenter,
          child: Obx(
            () => Skeletonizer(
              enabled: _con.isLoading.value,
              child: AppNetworkImage(
                height: Get.height * .4,
                width: Get.width,
                imgUrl: _con.data.value?.image ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        color: transparent,
        panelBuilder: () => PrjctdsPanelWidget(sc: sc),
      ),
    );
  }
}
