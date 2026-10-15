import '../../../../utils/app_imports.dart';

class PdsAmenities extends StatelessWidget {
  const PdsAmenities({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Amenities',
      padding: EdgeInsets.zero,
      onViewAll: () => Get.to(() => AllAmennitiesScreen()),
      content: amenitiesGrid(amenities, maxToShow: 4),
    );
  }
}

class AllAmennitiesScreen extends StatefulWidget {
  const AllAmennitiesScreen({super.key});

  @override
  State<AllAmennitiesScreen> createState() => _AllAmennitiesScreenState();
}

class _AllAmennitiesScreenState extends State<AllAmennitiesScreen> {
  final sc = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(scrollController: sc, title: 'Amenities'),
      body: ListView(
        controller: sc,
        padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
        children: [amenitiesGrid(amenities)],
      ),
    );
  }
}

Widget amenitiesGrid(List<Map<String, dynamic>> amenities, {int? maxToShow}) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: maxToShow != null
        ? amenities.length.clamp(0, maxToShow)
        : amenities.length,
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 180,
      mainAxisExtent: 72,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    ),
    itemBuilder: (context, index) {
      final amenity = amenities[index];
      return AppContainer(
        color: fromHex('f3f7fc'),
        borderRadius: 3,
        padding: EdgeInsets.all(AppDimentions.screenPaddingXS),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              amenity['icon'] as IconData,
              size: 24,
              color: Colors.blueGrey.shade700,
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Center(
                child: CustomText.kText(
                  amenity['title'] as String,
                  lines: 2,
                  align: TextAlign.center,
                  size: 14,
                  weight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

final List<Map<String, dynamic>> amenities = [
  {'title': 'Swimming Pool', 'icon': Icons.pool},
  {'title': 'Gym', 'icon': Icons.fitness_center},
  {'title': 'Parking', 'icon': Icons.local_parking},
  {'title': '24/7 Security', 'icon': Icons.security},
  {'title': 'Power Backup', 'icon': Icons.bolt},
  {'title': 'Lift', 'icon': Icons.elevator},
  {'title': 'Garden', 'icon': Icons.grass},
  {'title': 'Children’s Play Area', 'icon': Icons.child_care},
  {'title': 'Clubhouse', 'icon': Icons.apartment},
  {'title': 'Jogging Track', 'icon': Icons.directions_run},
  {'title': 'CCTV', 'icon': Icons.videocam},
  {'title': 'Visitor Parking', 'icon': Icons.local_parking},
  {'title': 'Fire Safety', 'icon': Icons.fire_extinguisher},
  {'title': 'Water Supply', 'icon': Icons.water_drop},
  {'title': 'Wi-Fi', 'icon': Icons.wifi},
  {'title': 'Air Conditioning', 'icon': Icons.ac_unit},
  {'title': 'Balcony', 'icon': Icons.balcony},
  {'title': 'Terrace', 'icon': Icons.roofing},
  {'title': 'Rainwater Harvesting', 'icon': Icons.water},
  {'title': 'Solar Panels', 'icon': Icons.solar_power},
  {'title': 'Community Hall', 'icon': Icons.groups},
  {'title': 'Indoor Games', 'icon': Icons.sports_esports},
  {'title': 'Restaurant', 'icon': Icons.restaurant},
  {'title': 'Pet Friendly', 'icon': Icons.pets},
];
