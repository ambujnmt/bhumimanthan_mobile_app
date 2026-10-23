import 'package:bhumi_manthan/models/propertiy_details_model.dart';

import '../../../../utils/app_imports.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final sc = ScrollController();

  final favorites = <PropertyDetailsModel>[].obs;

  @override
  void initState() {
    super.initState();
    favorites.value = _items
        .map((json) => PropertyDetailsModel.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        scrollController: sc,
        title: 'My Account',
        showLeading: false,
      ),
      body: Obx(() {
        if (favorites.isEmpty) {
          return _emptyState();
        }

        return ListView.separated(
          controller: sc,
          padding: const EdgeInsets.all(16),
          itemCount: favorites.length,
          separatorBuilder: (_, _) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final property = favorites[index];

            return _favoriteCard(property);
          },
        );
      }),
    );
  }

  Widget _favoriteCard(PropertyDetailsModel property) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: AppNetworkImage(
                    imgUrl: property.mainImage,
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomText.kText(
                      property.listingType,
                      size: 11,
                      weight: FontWeight.w700,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: IconButton(
                      onPressed: () => _removeFavorite(property),
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 21,
                      ),
                      tooltip: 'Remove from favorites',
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.kText(
                    property.title,
                    size: 16,
                    weight: FontWeight.w700,
                    lines: 2,
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: CustomText.kText(
                          [property.location, property.city]
                              .whereType<String>()
                              .where((e) => e.isNotEmpty)
                              .join(', '),
                          size: 12,
                          color: Colors.grey.shade600,
                          lines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  CustomText.kText(
                    _formatPrice(property.price),
                    size: 20,
                    weight: FontWeight.w800,
                    color: Colors.blue.shade800,
                  ),
                  const SizedBox(height: 14),
                  Divider(color: Colors.grey.shade200, height: 1),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      _propertyFeature(
                        Icons.bed_outlined,
                        property.configuration,
                      ),
                      _propertyFeature(
                        Icons.square_foot,
                        '${property.superArea} sq.ft.',
                      ),
                      _propertyFeature(
                        Icons.verified_outlined,
                        property.status,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _propertyFeature(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 5),
        CustomText.kText(value, size: 11, color: Colors.grey.shade700),
      ],
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 48,
                color: Colors.red.shade300,
              ),
            ),
            const SizedBox(height: 24),
            CustomText.kText(
              'No Favorites Yet',
              size: 20,
              weight: FontWeight.w700,
            ),
            const SizedBox(height: 10),
            CustomText.kText(
              'Save properties you love by tapping the heart icon. '
              'They will appear here for easy access.',
              size: 13,
              color: Colors.grey.shade600,
              align: TextAlign.center,
              lines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.explore_outlined),
              label: const Text('Explore Properties'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeFavorite(PropertyDetailsModel property) {
    favorites.removeWhere((item) => item.id == property.id);

    AppToast.success('Removed from favorites');
  }

  String _formatPrice(String? price) {
    final amount = double.tryParse(price ?? '');

    if (amount == null) return 'Price on request';

    if (amount >= 10000000) {
      return '₹${(amount / 10000000).toStringAsFixed(2)} Cr';
    }

    if (amount >= 100000) {
      return '₹${(amount / 100000).toStringAsFixed(2)} Lac';
    }

    return '₹${amount.toStringAsFixed(0)}';
  }
}

final _items = [
  {
    "id": 1,
    "property_id": "PROP-NRMH0CNB",
    "title": "3 BHK Luxury Apartment",
    "slug": "3-bhk-luxury-apartment",
    "type": "Apartment",
    "listing_type": "Sale",
    "configuration": "3 BHK",
    "status": "Ready to Move",
    "is_active": true,
    "is_featured": true,
    "is_luxury": true,
    "price": "8500000.00",
    "price_per_sqft": "7500.00",
    "location": "Sector 50",
    "city": "Gurgaon",
    "state": "Haryana",
    "description":
        "A spacious luxury apartment with modern amenities and excellent connectivity.",
    "super_area": "1250.00",
    "bedrooms": 3,
    "bathrooms": 2,
    "parking": "1 Covered",
    "floor": "8",
    "total_floors": 20,
    "facing": "East",
    "furnishing": "Semi Furnished",
    "age_of_property": null,
    "ownership": null,
    "balconies": "2",
    "project_name": "ABC Heights",
    "agent_name": "Rahul Sharma",
    "agent_phone": "9876543210",
    "image": "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c",
    "gallery_images": [],
    "floor_plan_image":
        "https://images.unsplash.com/photo-1600210492486-724fe5c67fb0",
    "location_image": null,
    "amenities": null,
    "distances": null,
    "latitude": "28.4595",
    "longitude": "77.0266",
    "created_at": "2026-10-20T10:00:00.000000Z",
    "updated_at": "2026-10-20T10:00:00.000000Z",
    "deleted_at": null,
  },
  {
    "id": 2,
    "property_id": "PROP-DLHF2K8P",
    "title": "Premium 2 BHK Apartment",
    "slug": "premium-2-bhk-apartment",
    "type": "Apartment",
    "listing_type": "Sale",
    "configuration": "2 BHK",
    "status": "Ready to Move",
    "is_active": true,
    "is_featured": false,
    "is_luxury": false,
    "price": "6200000.00",
    "price_per_sqft": "6888.89",
    "location": "Sector 62",
    "city": "Noida",
    "state": "Uttar Pradesh",
    "description":
        "A well-designed apartment suitable for small families, close to metro connectivity and shopping centres.",
    "super_area": "900.00",
    "bedrooms": 2,
    "bathrooms": 2,
    "parking": "1 Covered",
    "floor": "5",
    "total_floors": 14,
    "facing": "North",
    "furnishing": "Furnished",
    "age_of_property": "2 years",
    "ownership": "Freehold",
    "balconies": "1",
    "project_name": "Green Valley Residency",
    "agent_name": "Amit Verma",
    "agent_phone": "9876543211",
    "image": "https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea",
    "gallery_images": [],
    "floor_plan_image": null,
    "location_image": null,
    "amenities": null,
    "distances": null,
    "latitude": "28.6139",
    "longitude": "77.3730",
    "created_at": "2026-10-19T08:30:00.000000Z",
    "updated_at": "2026-10-19T08:30:00.000000Z",
    "deleted_at": null,
  },
  {
    "id": 3,
    "property_id": "PROP-GGN8L4QW",
    "title": "Luxury 4 BHK Independent Villa",
    "slug": "luxury-4-bhk-independent-villa",
    "type": "Villa",
    "listing_type": "Sale",
    "configuration": "4 BHK",
    "status": "Under Construction",
    "is_active": true,
    "is_featured": true,
    "is_luxury": true,
    "price": "18500000.00",
    "price_per_sqft": "10277.78",
    "location": "Sector 57",
    "city": "Gurugram",
    "state": "Haryana",
    "description":
        "An elegant villa with spacious interiors, premium fittings and a private outdoor area.",
    "super_area": "1800.00",
    "bedrooms": 4,
    "bathrooms": 4,
    "parking": "2 Covered",
    "floor": "Ground",
    "total_floors": 3,
    "facing": "East",
    "furnishing": "Semi Furnished",
    "age_of_property": null,
    "ownership": "Freehold",
    "balconies": "3",
    "project_name": "Palm Estate",
    "agent_name": "Neha Kapoor",
    "agent_phone": "9876543212",
    "image": "https://images.unsplash.com/photo-1600607687920-4e2a09cf159d",
    "gallery_images": [],
    "floor_plan_image": null,
    "location_image": null,
    "amenities": null,
    "distances": null,
    "latitude": "28.4239",
    "longitude": "77.1050",
    "created_at": "2026-10-18T12:00:00.000000Z",
    "updated_at": "2026-10-18T12:00:00.000000Z",
    "deleted_at": null,
  },
  {
    "id": 4,
    "property_id": "PROP-NOI5R7TX",
    "title": "Affordable 1 BHK Studio",
    "slug": "affordable-1-bhk-studio",
    "type": "Studio",
    "listing_type": "Rent",
    "configuration": "1 BHK",
    "status": "Ready to Move",
    "is_active": true,
    "is_featured": false,
    "is_luxury": false,
    "price": "18000.00",
    "price_per_sqft": "45.00",
    "location": "Sector 137",
    "city": "Noida",
    "state": "Uttar Pradesh",
    "description":
        "A compact, furnished studio apartment with essential facilities and easy access to public transport.",
    "super_area": "400.00",
    "bedrooms": 1,
    "bathrooms": 1,
    "parking": "Open Parking",
    "floor": "9",
    "total_floors": 22,
    "facing": "West",
    "furnishing": "Furnished",
    "age_of_property": "1 year",
    "ownership": "Leasehold",
    "balconies": "1",
    "project_name": "Urban Nest",
    "agent_name": "Karan Singh",
    "agent_phone": "9876543213",
    "image": "https://images.unsplash.com/photo-1600607687644-c7171b42498f",
    "gallery_images": [],
    "floor_plan_image": null,
    "location_image": null,
    "amenities": null,
    "distances": null,
    "latitude": "28.5091",
    "longitude": "77.4100",
    "created_at": "2026-10-17T09:15:00.000000Z",
    "updated_at": "2026-10-17T09:15:00.000000Z",
    "deleted_at": null,
  },
];
