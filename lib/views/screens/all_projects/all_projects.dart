import 'package:bhumi_manthan/models/project_details_model.dart';

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
    items.value = (res.data['data']['properties'] as List)
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
    return const Placeholder();
  }
}
