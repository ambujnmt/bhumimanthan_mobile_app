import '../../../../models/propertiy_details_model.dart';
import '../../../../utils/app_imports.dart';

class FavoritesScreenController extends GetxController {
  final isLoading = true.obs;

  final favorites = <PropertyDetailsModel>[].obs;

  Future<void> _getData() async {
    final res = await ApiServices().get('endPoint');

    if (!res.success) return;
  }

  void removeFavorite(PropertyDetailsModel property) {
    favorites.removeWhere((item) => item.id == property.id);

    AppToast.success('Removed from favorites');
  }

  Future<void> refreshData() async {
    favorites.value = _items
        .map((json) => PropertyDetailsModel.fromJson(json))
        .toList();
    isLoading(true);
    await _getData();
    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    refreshData();
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
