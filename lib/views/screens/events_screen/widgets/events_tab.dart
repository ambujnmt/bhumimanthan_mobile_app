import '../../../../models/events_model.dart';
import '../../../../utils/app_imports.dart';

class EventsTab extends StatefulWidget {
  final String filter;
  const EventsTab({super.key, required this.filter});

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab>
    with AutomaticKeepAliveClientMixin {
  final _api = ApiServices();

  final isLoading = true.obs;

  final events = Rxn<List<EventsModel>>();

  Future<void> _getData() async {
    final res = await _api.get('/events');
    if (!res.success) return;
    events.value = _parseFromResponse(res.data['data']['events']);
  }

  List<EventsModel> _parseFromResponse(dynamic data) {
    final List<EventsModel> list = JsonParser.parseList(
      data,
      (k) => EventsModel.fromJson(k),
    );

    final today = DateUtils.dateOnly(DateTime.now());

    if (widget.filter == 'live') {
      return list.where((t) {
        final startDate = DateTime.tryParse(t.eventDate ?? '');
        final endDate = DateTime.tryParse(t.endDate ?? '');

        if (startDate == null || endDate == null) return false;

        return !today.isBefore(DateUtils.dateOnly(startDate)) &&
            !today.isAfter(DateUtils.dateOnly(endDate));
      }).toList();
    }
    if (widget.filter == 'upcoming') {
      return list
          .where((t) => DateTime.parse(t.eventDate!).isAfter(today))
          .toList();
    }

    return list
        .where((t) => DateTime.parse(t.endDate!).isBefore(today))
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
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(
      () => AppRefreshIndicator(
        onRefresh: refreshData,
        child: isLoading.value
            ? AppLoader.widget()
            : events.value == null
            ? ApiErrorWidget()
            : events.value!.isEmpty
            ? NoDataAvailable()
            : ListView.separated(
                itemCount: events.value!.length,
                padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                itemBuilder: (context, index) =>
                    _eventCard(context, events.value![index]),
                separatorBuilder: (context, index) => heightSpace10,
              ),
      ),
    );
  }
}

Widget _eventCard(BuildContext context, EventsModel event) {
  return InkWell(
    onTap: () =>
        Get.toNamed(AppRoutes.eventDetailsScreen, arguments: {'id': event.id}),
    child: AppContainer(
      clip: Clip.antiAlias,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppNetworkImage(
            height: 160,
            width: double.infinity,
            imgUrl: event.image,
            fit: BoxFit.cover,
          ),

          Padding(
            padding: EdgeInsets.all(AppDimentions.screenPaddingS),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title ?? '',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),

                Text(
                  event.description ?? '',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 16),

                _eventInfo(
                  Icons.calendar_month_outlined,
                  '${formatDateTime(event.eventDate)}\nto\n${formatDateTime(event.endDate)}',
                ),
                const SizedBox(height: 9),
                _eventInfo(Icons.location_on_outlined, event.location ?? ''),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _eventInfo(IconData icon, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 17, color: Colors.grey.shade600),
      const SizedBox(width: 9),
      Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
    ],
  );
}
