import 'package:bhumi_manthan/controllers/user_controller.dart';
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
