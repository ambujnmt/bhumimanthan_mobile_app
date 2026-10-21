class CityModel {
  final int id;
  final int stateId;
  final String name;
  final String slug;
  final String image;
  final bool isPopular;
  final int sortOrder;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final int propertiesCount;
  final CityStateModel? state;

  const CityModel({
    required this.id,
    required this.stateId,
    required this.name,
    required this.slug,
    required this.image,
    required this.isPopular,
    required this.sortOrder,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.propertiesCount,
    this.state,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] ?? 0,
      stateId: json['state_id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
      isPopular: json['is_popular'] ?? false,
      sortOrder: json['sort_order'] ?? 0,
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      propertiesCount: json['properties_count'] ?? 0,
      state: json['state'] != null
          ? CityStateModel.fromJson(json['state'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state_id': stateId,
      'name': name,
      'slug': slug,
      'image': image,
      'is_popular': isPopular,
      'sort_order': sortOrder,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'properties_count': propertiesCount,
      'state': state?.toJson(),
    };
  }
}

class CityStateModel {
  final int id;
  final String name;
  final String slug;

  const CityStateModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory CityStateModel.fromJson(Map<String, dynamic> json) {
    return CityStateModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'slug': slug};
  }
}
