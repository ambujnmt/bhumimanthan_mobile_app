class ProjectDetailsModel {
  final int id;
  final String name;
  final String slug;
  final String builderName;
  final String location;
  final String city;
  final String state;
  final String latitude;
  final String longitude;
  final String startingPrice;
  final String? priceLabel;
  final String configuration;
  final String? description;
  final String image;
  final List<String> galleryImages;
  final String? link;
  final String launchStatus;
  final int sortOrder;
  final bool isActive;
  final int createdBy;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  const ProjectDetailsModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.builderName,
    required this.location,
    required this.city,
    required this.state,
    required this.latitude,
    required this.longitude,
    required this.startingPrice,
    this.priceLabel,
    required this.configuration,
    this.description,
    required this.image,
    this.galleryImages = const [],
    this.link,
    required this.launchStatus,
    required this.sortOrder,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ProjectDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProjectDetailsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      builderName: json['builder_name'] ?? '',
      location: json['location'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      latitude: json['latitude']?.toString() ?? '',
      longitude: json['longitude']?.toString() ?? '',
      startingPrice: json['starting_price']?.toString() ?? '0',
      priceLabel: json['price_label']?.toString(),
      configuration: json['configuration'] ?? '',
      description: json['description']?.toString(),
      image: json['image'] ?? '',
      galleryImages:
          (json['gallery_images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      link: json['link']?.toString(),
      launchStatus: json['launch_status'] ?? '',
      sortOrder: json['sort_order'] ?? 0,
      isActive: json['is_active'] ?? false,
      createdBy: json['created_by'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'builder_name': builderName,
      'location': location,
      'city': city,
      'state': state,
      'latitude': latitude,
      'longitude': longitude,
      'starting_price': startingPrice,
      'price_label': priceLabel,
      'configuration': configuration,
      'description': description,
      'image': image,
      'gallery_images': galleryImages,
      'link': link,
      'launch_status': launchStatus,
      'sort_order': sortOrder,
      'is_active': isActive,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
