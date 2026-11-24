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
    events.value = _parseFromResponse(res.data['data']['events'] as List);
  }

  List<EventsModel> _parseFromResponse(List<dynamic> data) {
    final list = data.map((json) => EventsModel.fromJson(json)).toList();

    final now = DateTime.now();

    if (widget.filter == 'live') {
      return list
          .where(
            (t) =>
                DateTime.parse(t.eventDate!).isBefore(now) &&
                DateTime.parse(t.endDate!).isAfter(now),
          )
          .toList();
    }
    if (widget.filter == 'upcoming') {
      return list
          .where((t) => DateTime.parse(t.eventDate!).isAfter(now))
          .toList();
    }

    return list.where((t) => DateTime.parse(t.endDate!).isBefore(now)).toList();
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
      () => isLoading.value
          ? AppLoader.widget()
          : events.value == null
          ? ApiErrorWidget()
          : ListView.separated(
              itemCount: events.value!.length,
              padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
              itemBuilder: (context, index) =>
                  _eventCard(context, events.value![index]),
              separatorBuilder: (context, index) => heightSpace10,
            ),
    );
  }
}

Widget _eventCard(BuildContext context, EventsModel event) {
  return AppContainer(
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
