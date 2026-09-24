import 'package:bhumi_manthan/views/screens/bottom_tab_screens/chat_screen/chat_screen.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/favorites_screen/favorites_screen.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/menu_screen/menu_screen.dart';
import 'package:bhumi_manthan/views/screens/bottom_tab_screens/profile_screen/profile_screen.dart';
import 'package:bhumi_manthan/views/screens/search_screen/search_screen.dart';

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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => scaffoldKey.currentState?.openEndDrawer();
  void _closeDrawer() => scaffoldKey.currentState?.closeEndDrawer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: Drawer(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Column(
            children: [
              Expanded(child: ListView(children: [])),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(AppDimentions.screenPaddingS),
                  child: TextButton.icon(
                    onPressed: _closeDrawer,
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
            ChatScreen(),
            ProfileScreen(),
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
                _tabs.length,
                (i) => Expanded(
                  child: InkWell(
                    onTap: () {
                      if (i == _tabs.length - 1) {
                        _openDrawer();
                        return;
                      }
                      if (i == 1) {
                        Get.toNamed(AppRoutes.searchScreen);
                        return;
                      }
                      _con.setCurrentIndex(i);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimentions.screenPaddingS,
                      ),
                      child: Obx(() {
                        final e = _tabs[i];
                        final isActive = i == _con.currentIndex.value;
                        return Column(
                          children: [
                            Image.asset(
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

final List<Map<String, String>> _tabs = [
  {'title': 'Home', 'icon': Images.homeIcon},
  {'title': 'Search', 'icon': Images.searchIcon},
  {'title': 'Favorites', 'icon': Images.heartIcon},
  {'title': 'Chat', 'icon': Images.chatIcon},
  {'title': 'Profile', 'icon': Images.userIcon},
  {'title': 'Menu', 'icon': Images.menuIcon},
];
