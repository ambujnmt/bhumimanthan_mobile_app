import 'package:bhumi_manthan/models/events_model.dart';

import '../../../utils/app_imports.dart';

class EventDetailsScreenController extends GetxController {
  final event = Rxn<EventsModel>();
  final isLoading = false.obs;

  int? eventId;

  @override
  void onInit() {
    super.onInit();

    eventId = Get.arguments['id'];

    if (eventId == null) return;

    refreshData();
  }

  Future<void> refreshData() async {
    isLoading(true);
    await _getEventDetails();
    isLoading(false);
  }

  Future<void> _getEventDetails() async {
    final res = await ApiServices().get('/events/$eventId');

    if (!res.success) return;

    event.value = JsonParser.tryParse<EventsModel>(
      res.data['data']['event'],
      (json) => EventsModel.fromJson(json),
    );
  }
}
