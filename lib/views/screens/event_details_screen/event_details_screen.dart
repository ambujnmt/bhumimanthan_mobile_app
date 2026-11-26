import 'package:bhumi_manthan/models/events_model.dart';
import 'package:bhumi_manthan/views/screens/event_details_screen/event_details_screen_controller.dart';

import '../../../utils/app_imports.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final controller = Get.put(EventDetailsScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Event Details'),
      body: Obx(
        () => AppRefreshIndicator(
          onRefresh: controller.refreshData,
          child: controller.isLoading.value
              ? AppLoader.widget()
              : controller.event.value == null
              ? ApiErrorWidget()
              : _EventDetailsContent(event: controller.event.value!),
        ),
      ),
    );
  }
}

class _EventDetailsContent extends StatelessWidget {
  final EventsModel event;

  const _EventDetailsContent({required this.event});

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        event.image ??
        (event.images.isNotEmpty ? event.images.first.url : null);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null && imageUrl.isNotEmpty)
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: Icon(Icons.image_not_supported_outlined),
                  ),
                );
              },
            ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (event.eventTypeLabel != null)
                  Chip(label: Text(event.eventTypeLabel!)),

                const SizedBox(height: 8),

                Text(
                  event.title ?? '',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                _InfoTile(
                  icon: Icons.calendar_month,
                  title: 'Date',
                  value: _formatDateRange(event.eventDate, event.endDate),
                ),

                _InfoTile(
                  icon: Icons.access_time,
                  title: 'Time',
                  value: _formatTimeRange(event.startTime, event.endTime),
                ),

                _InfoTile(
                  icon: Icons.location_on_outlined,
                  title: 'Location',
                  value: [
                    event.location,
                    event.address,
                    event.city,
                    event.state,
                  ].whereType<String>().where((e) => e.isNotEmpty).join(', '),
                ),

                if (event.organizerName != null)
                  _InfoTile(
                    icon: Icons.person_outline,
                    title: 'Organizer',
                    value: event.organizerName!,
                  ),

                if (event.brandName != null)
                  _InfoTile(
                    icon: Icons.business_outlined,
                    title: 'Brand',
                    value: event.brandName!,
                  ),

                const SizedBox(height: 20),

                if (event.description != null &&
                    event.description!.isNotEmpty) ...[
                  Text(
                    'About Event',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(event.description!),
                  const SizedBox(height: 20),
                ],

                if (event.highlightLabels.isNotEmpty ||
                    event.highlights.isNotEmpty) ...[
                  Text(
                    'Highlights',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  ...((event.highlightLabels.isNotEmpty
                          ? event.highlightLabels
                          : event.highlights)
                      .map(
                        (highlight) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.check_circle_outline, size: 20),
                              const SizedBox(width: 8),
                              Expanded(child: Text(highlight)),
                            ],
                          ),
                        ),
                      )),

                  const SizedBox(height: 20),
                ],

                if (event.expectedFootfallLabel != null)
                  _InfoTile(
                    icon: Icons.people_outline,
                    title: 'Expected Footfall',
                    value: event.expectedFootfallLabel!,
                  ),

                if (event.buildersAttending != null &&
                    event.buildersAttending!.isNotEmpty)
                  _InfoTile(
                    icon: Icons.apartment,
                    title: 'Builders Attending',
                    value: event.buildersAttending!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    if (value.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 3),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _formatDateRange(String? start, String? end) {
  if (start == null || start.isEmpty) return '';

  final startDate = DateTime.tryParse(start);
  final endDate = end == null ? null : DateTime.tryParse(end);

  if (startDate == null) return start;

  final startText = _formatDate(startDate);

  if (endDate == null || _sameDay(startDate, endDate)) {
    return startText;
  }

  return '$startText - ${_formatDate(endDate)}';
}

String _formatDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return '${date.day} ${months[date.month - 1]} ${date.year}';
}

bool _sameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

String _formatTimeRange(String? start, String? end) {
  if (start == null || start.isEmpty) return '';

  if (end == null || end.isEmpty) {
    return _formatTime(start);
  }

  return '${_formatTime(start)} - ${_formatTime(end)}';
}

String _formatTime(String time) {
  final parts = time.split(':');

  if (parts.length < 2) return time;

  final hour = int.tryParse(parts[0]);
  final minute = int.tryParse(parts[1]);

  if (hour == null || minute == null) return time;

  final period = hour >= 12 ? 'PM' : 'AM';
  final displayHour = hour % 12 == 0 ? 12 : hour % 12;

  return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
}
