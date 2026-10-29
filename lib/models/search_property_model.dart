class SearchPropertyModel {
  final int id;
  final String propertyId;
  final String title;
  final String slug;
  final String propertyType;
  final String listingType;
  final String configuration;
  final String status;
  final bool isActive;
  final bool isFeatured;
  final bool isLuxury;
  final String? badge;
  final String price;
  final String pricePerSqft;
  final String location;
  final String city;
  final String state;
  final String description;
  final String superArea;
  final int bedrooms;
  final int bathrooms;
  final String parking;
  final String floor;
  final int totalFloors;
  final String facing;
  final String furnishing;
  final String? ageOfProperty;
  final String? ownership;
  final String balconies;
  final String project;
  final String agentName;
  final String agentType;
  final String agentExperience;
  final String agentImage;
  final String agentPhone;
  final bool agentVerified;
  final String mainImage;
  final List<String> galleryImages;
  final String floorPlanImage;
  final String? locationImage;
  final dynamic amenities;
  final String latitude;
  final String longitude;
  final String? rapidMetroDistance;
  final String? schoolDistance;
  final String? hospitalDistance;
  final int createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  SearchPropertyModel({
    required this.id,
    required this.propertyId,
    required this.title,
    required this.slug,
    required this.propertyType,
    required this.listingType,
    required this.configuration,
    required this.status,
    required this.isActive,
    required this.isFeatured,
    required this.isLuxury,
    this.badge,
    required this.price,
    required this.pricePerSqft,
    required this.location,
    required this.city,
    required this.state,
    required this.description,
    required this.superArea,
    required this.bedrooms,
    required this.bathrooms,
    required this.parking,
    required this.floor,
    required this.totalFloors,
    required this.facing,
    required this.furnishing,
    this.ageOfProperty,
    this.ownership,
    required this.balconies,
    required this.project,
    required this.agentName,
    required this.agentType,
    required this.agentExperience,
    required this.agentImage,
    required this.agentPhone,
    required this.agentVerified,
    required this.mainImage,
    required this.galleryImages,
    required this.floorPlanImage,
    this.locationImage,
    this.amenities,
    required this.latitude,
    required this.longitude,
    this.rapidMetroDistance,
    this.schoolDistance,
    this.hospitalDistance,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory SearchPropertyModel.fromJson(Map<String, dynamic> json) {
    return SearchPropertyModel(
      id: json['id'] ?? 0,
      propertyId: json['property_id'] ?? '',
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      propertyType: json['property_type'] ?? '',
      listingType: json['listing_type'] ?? '',
      configuration: json['configuration'] ?? '',
      status: json['status'] ?? '',
      isActive: json['is_active'] ?? false,
      isFeatured: json['is_featured'] ?? false,
      isLuxury: json['is_luxury'] ?? false,
      badge: json['badge'],
      price: json['price']?.toString() ?? '',
      pricePerSqft: json['price_per_sqft']?.toString() ?? '',
      location: json['location'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      description: json['description'] ?? '',
      superArea: json['super_area']?.toString() ?? '',
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      parking: json['parking'] ?? '',
      floor: json['floor']?.toString() ?? '',
      totalFloors: json['total_floors'] ?? 0,
      facing: json['facing'] ?? '',
      furnishing: json['furnishing'] ?? '',
      ageOfProperty: json['age_of_property']?.toString(),
      ownership: json['ownership']?.toString(),
      balconies: json['balconies']?.toString() ?? '',
      project: json['project'] ?? '',
      agentName: json['agent_name'] ?? '',
      agentType: json['agent_type'] ?? '',
      agentExperience: json['agent_experience'] ?? '',
      agentImage: json['agent_image'] ?? '',
      agentPhone: json['agent_phone'] ?? '',
      agentVerified: json['agent_verified'] ?? false,
      mainImage: json['main_image'] ?? '',
      galleryImages: List<String>.from(json['gallery_images'] ?? []),
      floorPlanImage: json['floor_plan_image'] ?? '',
      locationImage: json['location_image'],
      amenities: json['amenities'],
      latitude: json['latitude']?.toString() ?? '',
      longitude: json['longitude']?.toString() ?? '',
      rapidMetroDistance: json['rapid_metro_distance']?.toString(),
      schoolDistance: json['school_distance']?.toString(),
      hospitalDistance: json['hospital_distance']?.toString(),
      createdBy: json['created_by'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
    );
  }
}
