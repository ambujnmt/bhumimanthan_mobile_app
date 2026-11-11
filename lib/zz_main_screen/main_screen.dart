import 'dart:async';

import 'package:bhumi_manthan/views/screens/bottom_tab_screens/chat_history_screen/chat_history_screen.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/favorites_screen/favorites_screen.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/menu_screen/menu_screen.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/compare_screen/compare_screen.dart';
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
    return SafeArea(
      top: false,
      child: Scaffold(
        key: _con.scaffoldKey,
        endDrawer: Drawer(
          backgroundColor: AppColors.backgroundColor,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
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
                    label: CustomText.kText('Close', color: AppColors.subtitle),
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
            ChatHistoryScreen(),
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
                            e['title'] == 'Chat'
                                ? ChatWithBadge(isActive: isActive)
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
    );
  }
}

class ChatWithBadge extends StatefulWidget {
  final bool isActive;
  const ChatWithBadge({super.key, required this.isActive});

  @override
  State<ChatWithBadge> createState() => _ChatWithBadgeState();
}

class _ChatWithBadgeState extends State<ChatWithBadge> {
  final _con = Get.put(ChatIconController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final showLabel = _con.unreadChatIds.isNotEmpty;
      return Badge(
        isLabelVisible: showLabel,
        backgroundColor: red,
        label: CustomText.kText(
          _con.unreadChatIds.length.toString(),
          color: white,
        ),
        child: Image.asset(
          height: 22,
          width: 22,
          Images.chatIcon,
          color: widget.isActive ? AppColors.primary : AppColors.subtitle,
        ),
      );
    });
  }
}

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
