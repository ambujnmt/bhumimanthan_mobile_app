import '../../../utils/app_imports.dart';

class EventsScreenController extends GetxController {
  final _api = ApiServices();

  final isLoading = true.obs;

  final data = Rxn<String>();

  Future<void> _getData() async {
    final res = await _api.get('/events');
    // if (!res.success) return;
    data('abc');
  }

  Future<void> refreshData() async {
    isLoading(true);
    await _getData();
    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }
}
