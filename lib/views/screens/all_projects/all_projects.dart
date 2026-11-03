import 'package:bhumi_manthan/models/project_details_model.dart';
import 'package:bhumi_manthan/views/screens/all_projects/widgets/aps_card_widget.dart';

import '../../../utils/app_imports.dart';

class AllProjects extends StatefulWidget {
  const AllProjects({super.key});

  @override
  State<AllProjects> createState() => _AllProjectsState();
}

class _AllProjectsState extends State<AllProjects> {
  final _api = ApiServices();

  final location = LocationController.currentLocation;

  final sc = ScrollController();

  final isLoading = true.obs;
  final items = <ProjectDetailsModel>[].obs;

  Future<void> _getData() async {
    final res = await _api.get('/projects');
    if (!res.success) return;
    items.value = (res.data['data']['projects'] as List)
        .map((json) => ProjectDetailsModel.fromJson(json))
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
      appBar: CustomAppbar(scrollController: sc, title: 'Projects'),
      body: Obx(
        () => AppRefreshIndicator(
          onRefresh: refreshData,
          child: isLoading.value
              ? AppLoader.widget()
              : items.isEmpty
              ? noDataAvailable()
              : ListView.separated(
                  controller: sc,
                  padding: EdgeInsets.fromLTRB(
                    AppDimentions.defaultScreenPadding,
                    AppDimentions.defaultScreenPadding,
                    AppDimentions.defaultScreenPadding,
                    100,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) =>
                      ApsCardWidget(item: items[index]),
                  separatorBuilder: (context, index) => heightSpace10,
                ),
        ),
      ),
    );
  }
}
