import '../../../../controllers/user_controller.dart';
import '../../../../utils/app_imports.dart';
import 'menu_screen_controller.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with AutomaticKeepAliveClientMixin {
  final _con = Get.put(MenuScreenController());
  final sc = ScrollController();
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CustomAppbar(
        scrollController: sc,
        title: 'My Account',
        showLeading: false,
      ),
      body: Obx(
        () => ListView(
          controller: sc,
          padding: const EdgeInsets.all(16),
          children: [
            _profileCard(_con),
            const SizedBox(height: 24),

            _sectionTitle('ACCOUNT'),
            _menuCard([
              _MenuItem(
                icon: Icons.person_outline_rounded,
                title: 'Edit Profile',
                subtitle: 'Manage your personal information',
                onTap: () => _navigate(AppRoutes.editProfileScreen),
              ),
              _MenuItem(
                icon: Icons.home_work_outlined,
                title: 'My Properties',
                subtitle: 'View your saved or listed properties',
                onTap: () => _navigate('/my-properties'),
              ),
              _MenuItem(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                onTap: () => _navigate('/notifications'),
              ),
            ]),

            const SizedBox(height: 24),

            _sectionTitle('INFORMATION & SUPPORT'),
            _menuCard([
              _MenuItem(
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                onTap: () => _navigate(AppRoutes.termsAndConditions),
              ),
              _MenuItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () => _navigate(AppRoutes.privacyPolicy),
              ),
              _MenuItem(
                icon: Icons.support_agent_rounded,
                title: 'Contact Us',
                onTap: () => _navigate(AppRoutes.contactUs),
              ),
              _MenuItem(
                icon: Icons.info_outline_rounded,
                title: 'About Us',
                onTap: () => _navigate(AppRoutes.aboutUs),
              ),
            ]),

            const SizedBox(height: 24),

            _menuCard([
              _MenuItem(
                icon: Icons.logout_rounded,
                title: 'Logout',
                iconColor: Colors.red.shade600,
                titleColor: Colors.red.shade600,
                showArrow: false,
                onTap: () => UserController.logout(),
              ),
            ]),

            const SizedBox(height: 24),

            Center(
              child: CustomText.kText(
                'Bhumi Manthan',
                size: 13,
                color: Colors.grey.shade600,
                weight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: CustomText.kText(
                'Version 1.0.0',
                size: 11,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _profileCard(MenuScreenController con) {
    return AppContainer(
      child: Row(
        children: [
          AppContainer(
            height: 55,
            width: 55,
            clip: Clip.hardEdge,
            padding: EdgeInsets.zero,
            shape: BoxShape.circle,
            child: con.user.value?.profileImage == null
                ? Icon(
                    Icons.person_rounded,
                    size: 34,
                    color: AppColors.secondary,
                  )
                : AppNetworkImage(
                    imgUrl: con.user.value?.profileImage,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.kText(
                  con.user.value?.name ?? 'Welcome!',
                  size: 18,
                  weight: FontWeight.w700,
                ),
                const SizedBox(height: 5),
                CustomText.kText(
                  con.user.value?.email ?? 'Login to access your account',
                  size: 12,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: CustomText.kText(
        title,
        size: 12,
        weight: FontWeight.w700,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _menuCard(List<_MenuItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];

          return Column(
            children: [
              InkWell(
                onTap: item.onTap,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 15,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: (item.iconColor ?? Colors.blue.shade700)
                              .withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          item.icon,
                          color: item.iconColor ?? Colors.blue.shade700,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.kText(
                              item.title,
                              size: 14,
                              weight: FontWeight.w600,
                              color: item.titleColor ?? Colors.black87,
                            ),
                            if (item.subtitle != null) ...[
                              const SizedBox(height: 4),
                              CustomText.kText(
                                item.subtitle!,
                                size: 11,
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (item.showArrow)
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.grey.shade500,
                          size: 22,
                        ),
                    ],
                  ),
                ),
              ),
              if (index != items.length - 1)
                Divider(
                  height: 1,
                  thickness: 0.7,
                  indent: 72,
                  endIndent: 16,
                  color: Colors.grey.shade200,
                ),
            ],
          );
        }),
      ),
    );
  }

  void _navigate(String route) {
    Get.toNamed(route);
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? titleColor;
  final bool showArrow;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.iconColor,
    this.titleColor,
    this.showArrow = true,
  });
}
