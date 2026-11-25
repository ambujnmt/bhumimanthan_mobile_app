import 'dart:async';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/favorites_screen/favorites_screen.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/menu_screen/menu_screen.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/compare_screen/compare_screen.dart';
import 'package:bhumi_manthan/views/screens/events_screen/events_screen.dart';
import 'package:bhumi_manthan/views/screens/search_screen/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/app_imports.dart';
import '../views/screens/bottom_tab_screens/home_screen/home_screen.dart';
import 'main_screen_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _con = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _con.timer != null,
      onPopInvokedWithResult: (didPop, result) => _con.onBackPressed(),
      child: SafeArea(
        top: false,
        child: Scaffold(
          key: _con.scaffoldKey,
          endDrawer: Drawer(
            backgroundColor: AppColors.backgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text('Logout'),
                        onTap: () {
                          Get.back();
                          UserController.logout();
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(AppDimentions.screenPaddingS),
                    child: TextButton.icon(
                      onPressed: _con.closeDrawer,
                      label: CustomText.kText(
                        'Close',
                        color: AppColors.subtitle,
                      ),
                      icon: Icon(Icons.close, color: AppColors.subtitle),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: PageView(
            controller: _con.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              SearchScreen(),
              FavoritesScreen(),
              EventsScreen(),
              CompareScreen(),
              MenuScreen(),
            ],
          ),
          bottomNavigationBar: IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: grey[300]!, width: 1.5)),
              ),
              child: Row(
                children: List.generate(
                  _con.tabs.length,
                  (i) => Expanded(
                    child: InkWell(
                      onTap: () => _con.setCurrentIndex(i),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimentions.screenPaddingS,
                        ),
                        child: Obx(() {
                          final e = _con.tabs[i];
                          final isActive = i == _con.currentIndex.value;
                          return Column(
                            children: [
                              i == 3
                                  ? EventsIcon(isActive: isActive)
                                  : Image.asset(
                                      height: 22,
                                      width: 22,
                                      e['icon']!,
                                      color: isActive
                                          ? AppColors.primary
                                          : AppColors.subtitle,
                                    ),
                              heightSpace5,
                              CustomText.kText(
                                e['title']!,
                                size: 11,
                                lines: 1,
                                color: isActive
                                    ? AppColors.primary
                                    : AppColors.subtitle,
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EventsIcon extends StatefulWidget {
  final bool isActive;
  const EventsIcon({super.key, required this.isActive});

  @override
  State<EventsIcon> createState() => _EventsIconState();
}

class _EventsIconState extends State<EventsIcon> {
  final isLoading = true.obs;

  final isLive = Rxn<bool>();

  Future<void> _getData() async {
    isLoading(true);
    final res = await ApiServices().get('/events');
    if (!res.success) return;

    final today = DateUtils.dateOnly(DateTime.now());

    isLive.value = (res.data['data']['events'] as List).any((json) {
      final startDate = DateTime.tryParse(json['event_date'] ?? '');
      final endDate = DateTime.tryParse(json['end_date'] ?? '');

      if (startDate == null || endDate == null) return false;

      return !today.isBefore(DateUtils.dateOnly(startDate)) &&
          !today.isAfter(DateUtils.dateOnly(endDate));
    });
    isLoading(false);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Badge(
        isLabelVisible:
            (isLoading.value && isLive.value == null) || isLive.value == true,
        backgroundColor: grey.shade200,
        label: AppFadeAnimatedSwitcher(
          child: isLive.value == true ? LiveIndicator() : SizedBox.shrink(),
        ),
        child: Image.asset(
          height: 22,
          width: 22,
          Images.calendarIcon,
          color: widget.isActive ? AppColors.primary : AppColors.subtitle,
        ),
      ),
    );
  }
}

class LiveIndicator extends StatefulWidget {
  const LiveIndicator({super.key});

  @override
  State<LiveIndicator> createState() => _LiveIndicatorState();
}

class _LiveIndicatorState extends State<LiveIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeTransition(
          opacity: Tween<double>(begin: 0.3, end: 1).animate(_controller),
          child: Container(
            height: 7,
            width: 7,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
        widthSpace4,
        const Text(
          'LIVE',
          style: TextStyle(
            color: red,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

// class ChatWithBadge extends StatefulWidget {
//   final bool isActive;
//   const ChatWithBadge({super.key, required this.isActive});

//   @override
//   State<ChatWithBadge> createState() => _ChatWithBadgeState();
// }

// class _ChatWithBadgeState extends State<ChatWithBadge> {
//   final _con = Get.put(ChatIconController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final showLabel = _con.unreadChatIds.isNotEmpty;
//       return Badge(
//         isLabelVisible: showLabel,
//         backgroundColor: red,
//         label: CustomText.kText(
//           _con.unreadChatIds.length.toString(),
//           color: white,
//         ),
//         child: Image.asset(
//           height: 22,
//           width: 22,
//           Images.chatIcon,
//           color: widget.isActive ? AppColors.primary : AppColors.subtitle,
//         ),
//       );
//     });
//   }
// }

class ChatIconController extends GetxController {
  final currentUserId = UserController.user.value?.id.toString();

  final RxBool isLoading = true.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
  _unreadMessagesSubscription;

  final collectionName = 'chats';

  final unreadChatIds = <String>[].obs;

  void listenUnreadMessages() {
    _unreadMessagesSubscription?.cancel();

    _unreadMessagesSubscription = _firestore
        .collection(collectionName)
        .where('users', arrayContains: currentUserId)
        .snapshots()
        .listen((snapshot) {});
  }

  @override
  void onInit() {
    listenUnreadMessages();

    super.onInit();
  }
}
