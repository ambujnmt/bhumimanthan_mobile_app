import 'package:bhumi_manthan/utils/app_imports.dart';

import 'events_screen_controller.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final _con = Get.put(EventsScreenController());

  final List<Map<String, dynamic>> events = const [
    {
      'title': 'Business Networking Event',
      'description': 'Connect with business owners and professionals.',
      'date': '20 Nov 2026',
      'time': '10:00 AM',
      'location': 'London, UK',
      'image': '',
    },
    {
      'title': 'Tax Planning Workshop',
      'description': 'Learn effective tax planning strategies.',
      'date': '25 Nov 2026',
      'time': '02:00 PM',
      'location': 'Manchester, UK',
      'image': '',
    },
    {
      'title': 'Accounting & Finance Seminar',
      'description': 'Explore the latest accounting practices.',
      'date': '02 Dec 2026',
      'time': '11:00 AM',
      'location': 'Birmingham, UK',
      'image': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Events'),
      body: Obx(
        () => _con.isLoading.value
            ? AppLoader.widget()
            : _con.data.value == null
            ? ApiErrorWidget()
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Upcoming Events',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Stay updated with our latest events and workshops.',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 20),

                  ...events.map((event) => _eventCard(context, event)),
                ],
              ),
      ),
    );
  }

  Widget _eventCard(BuildContext context, Map<String, dynamic> event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            width: double.infinity,
            color: Colors.grey.shade100,
            child: const Icon(Icons.event, size: 55, color: Colors.grey),
          ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),

                Text(
                  event['description'],
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 16),

                _eventInfo(Icons.calendar_month_outlined, event['date']),
                const SizedBox(height: 9),
                _eventInfo(Icons.access_time, event['time']),
                const SizedBox(height: 9),
                _eventInfo(Icons.location_on_outlined, event['location']),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate to event details screen
                    },
                    child: const Text('View Details'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventInfo(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 17, color: Colors.grey.shade600),
        const SizedBox(width: 9),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
      ],
    );
  }
}
