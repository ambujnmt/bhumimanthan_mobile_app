class AgentModel {
  final String? key;
  final String? name;
  final String? type;
  final String? phone;
  final String? experience;
  final String? image;
  final bool verified;
  final List<String> cities;
  final int? propertiesCount;
  final double? distanceKm;
  final double? ratingAvg;
  final int? ratingCount;

  const AgentModel({
    this.key,
    this.name,
    this.type,
    this.phone,
    this.experience,
    this.image,
    this.verified = false,
    this.cities = const [],
    this.propertiesCount,
    this.distanceKm,
    this.ratingAvg,
    this.ratingCount,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) {
    return AgentModel(
      key: json['key']?.toString(),
      name: json['name']?.toString(),
      type: json['type']?.toString(),
      phone: json['phone']?.toString(),
      experience: json['experience']?.toString(),
      image: json['image']?.toString(),
      verified: json['verified'] ?? false,
      cities:
          (json['cities'] as List?)?.map((e) => e.toString()).toList() ?? [],
      propertiesCount: (json['properties_count'] as num?)?.toInt(),
      distanceKm: (json['distance_km'] as num?)?.toDouble(),
      ratingAvg: (json['rating_avg'] as num?)?.toDouble(),
      ratingCount: (json['rating_count'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'name': name,
      'type': type,
      'phone': phone,
      'experience': experience,
      'image': image,
      'verified': verified,
      'cities': cities,
      'properties_count': propertiesCount,
      'distance_km': distanceKm,
      'rating_avg': ratingAvg,
      'rating_count': ratingCount,
    };
  }
}
