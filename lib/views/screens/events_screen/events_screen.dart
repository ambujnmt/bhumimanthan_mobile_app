import 'package:bhumi_manthan/utils/app_imports.dart';

import 'events_screen_controller.dart';
import 'widgets/events_tab.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final _con = Get.put(EventsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Events'),
      body: Column(
        children: [
          CustomTab(
            isScrollable: false,
            controller: _con.tabController,
            tabs: [
              Tab(text: 'Live'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Past Events'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _con.tabController,
              children: [
                EventsTab(filter: 'live'),
                EventsTab(filter: 'upcoming'),
                EventsTab(filter: 'past'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final TabController controller;
  final List<Tab> tabs;
  final bool isScrollable;
  final EdgeInsetsGeometry? labelPadding;
  const CustomTab({
    super.key,
    required this.controller,
    required this.tabs,
    this.isScrollable = true,
    this.labelPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: isScrollable,
      tabAlignment: isScrollable ? TabAlignment.start : null,
      controller: controller,
      indicatorColor: AppColors.primary,
      indicatorSize: isScrollable ? null : TabBarIndicatorSize.tab,
      dividerHeight: 1.2,
      labelPadding: labelPadding,
      labelStyle: CustomText.kTextStyle(
        size: 16,
        weight: FontWeight.w600,
        color: AppColors.primary,
      ),
      unselectedLabelStyle: CustomText.kTextStyle(size: 16),
      tabs: tabs,
    );
  }
}
