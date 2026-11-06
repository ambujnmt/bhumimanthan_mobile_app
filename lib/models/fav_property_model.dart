class FavPropertyModel {
  final int id;
  final String propertyId;
  final String title;
  final String slug;
  final String propertyType;
  final int? categoryId;
  final int? subCategoryId;
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
  final int? bedrooms;
  final int? bathrooms;
  final String? parking;
  final String? floor;
  final int? totalFloors;
  final String? facing;
  final String? furnishing;
  final String? ageOfProperty;
  final String? ownership;
  final String? balconies;
  final String? project;
  final String? agentName;
  final String? agentType;
  final String? agentExperience;
  final String? agentImage;
  final String? agentPhone;
  final bool agentVerified;
  final String? mainImage;
  final List<String> galleryImages;
  final String? floorPlanImage;
  final String? locationImage;
  final List<String> amenities;
  final String? latitude;
  final String? longitude;
  final String? rapidMetroDistance;
  final String? schoolDistance;
  final String? hospitalDistance;
  final int createdBy;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String? videoFile;
  final String? videoUrl;
  final String? metaTitle;
  final String? metaDescription;
  final String? metaKeywords;
  final dynamic category;
  final dynamic subCategory;

  FavPropertyModel({
    required this.id,
    required this.propertyId,
    required this.title,
    required this.slug,
    required this.propertyType,
    this.categoryId,
    this.subCategoryId,
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
    this.bedrooms,
    this.bathrooms,
    this.parking,
    this.floor,
    this.totalFloors,
    this.facing,
    this.furnishing,
    this.ageOfProperty,
    this.ownership,
    this.balconies,
    this.project,
    this.agentName,
    this.agentType,
    this.agentExperience,
    this.agentImage,
    this.agentPhone,
    required this.agentVerified,
    this.mainImage,
    this.galleryImages = const [],
    this.floorPlanImage,
    this.locationImage,
    this.amenities = const [],
    this.latitude,
    this.longitude,
    this.rapidMetroDistance,
    this.schoolDistance,
    this.hospitalDistance,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.videoFile,
    this.videoUrl,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.category,
    this.subCategory,
  });

  factory FavPropertyModel.fromJson(Map<String, dynamic> json) {
    return FavPropertyModel(
      id: json['id'] ?? 0,
      propertyId: json['property_id'] ?? '',
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      propertyType: json['property_type'] ?? '',
      categoryId: json['category_id'],
      subCategoryId: json['sub_category_id'],
      listingType: json['listing_type'] ?? '',
      configuration: json['configuration'] ?? '',
      status: json['status'] ?? '',
      isActive: json['is_active'] ?? false,
      isFeatured: json['is_featured'] ?? false,
      isLuxury: json['is_luxury'] ?? false,
      badge: json['badge'],
      price: json['price']?.toString() ?? '0',
      pricePerSqft: json['price_per_sqft']?.toString() ?? '0',
      location: json['location'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      description: json['description'] ?? '',
      superArea: json['super_area']?.toString() ?? '0',
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      parking: json['parking'],
      floor: json['floor']?.toString(),
      totalFloors: json['total_floors'],
      facing: json['facing'],
      furnishing: json['furnishing'],
      ageOfProperty: json['age_of_property']?.toString(),
      ownership: json['ownership'],
      balconies: json['balconies'],
      project: json['project'],
      agentName: json['agent_name'],
      agentType: json['agent_type'],
      agentExperience: json['agent_experience'],
      agentImage: json['agent_image'],
      agentPhone: json['agent_phone'],
      agentVerified: json['agent_verified'] ?? false,
      mainImage: json['main_image'],
      galleryImages: List<String>.from(json['gallery_images'] ?? []),
      floorPlanImage: json['floor_plan_image'],
      locationImage: json['location_image'],
      amenities: List<String>.from(json['amenities'] ?? []),
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      rapidMetroDistance: json['rapid_metro_distance'],
      schoolDistance: json['school_distance'],
      hospitalDistance: json['hospital_distance'],
      createdBy: json['created_by'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
      videoFile: json['video_file'],
      videoUrl: json['video_url'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
      category: json['category'],
      subCategory: json['sub_category'],
    );
  }
}
