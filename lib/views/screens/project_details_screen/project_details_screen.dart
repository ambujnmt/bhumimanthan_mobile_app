import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/project_details_screen/widgets/pds_detail.dart';

import 'project_details_screen_controller.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  final _con = Get.put(ProjectDetailsScreenController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _con.isLoading.value
          ? Scaffold(
              appBar: CustomAppbar(title: 'Project Details'),
              body: AppLoader.widget(),
            )
          : _con.data.value == null
          ? Scaffold(
              appBar: CustomAppbar(title: 'Project Details'),
              body: errorLoadingData(),
            )
          : PdsDetail(project: _con.data.value!),
    );
  }
}
