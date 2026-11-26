class AgentDataModel {
  final AgentProfileModel? agent;
  final RatingBreakdownModel? ratingBreakdown;
  final List<AgentPropertyModel> properties;
  final List<AgentReviewModel> reviews;
  final AgentReviewModel? myReview;

  const AgentDataModel({
    this.agent,
    this.ratingBreakdown,
    this.properties = const [],
    this.reviews = const [],
    this.myReview,
  });

  factory AgentDataModel.fromJson(Map<String, dynamic> json) {
    return AgentDataModel(
      agent: _parseMap(json['agent'], AgentProfileModel.fromJson),
      ratingBreakdown: _parseMap(
        json['rating_breakdown'],
        RatingBreakdownModel.fromJson,
      ),
      properties: _parseList(json['properties'], AgentPropertyModel.fromJson),
      reviews: _parseList(json['reviews'], AgentReviewModel.fromJson),
      myReview: _parseMap(json['my_review'], AgentReviewModel.fromJson),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'agent': agent?.toJson(),
      'rating_breakdown': ratingBreakdown?.toJson(),
      'properties': properties.map((e) => e.toJson()).toList(),
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'my_review': myReview?.toJson(),
    };
  }
}

class AgentProfileModel {
  final String? key;
  final String? name;
  final String? type;
  final String? phone;
  final String? experience;
  final String? image;
  final bool? verified;
  final List<String> cities;
  final int? propertiesCount;
  final double? distanceKm;
  final double? ratingAvg;
  final int? ratingCount;

  const AgentProfileModel({
    this.key,
    this.name,
    this.type,
    this.phone,
    this.experience,
    this.image,
    this.verified,
    this.cities = const [],
    this.propertiesCount,
    this.distanceKm,
    this.ratingAvg,
    this.ratingCount,
  });

  factory AgentProfileModel.fromJson(Map<String, dynamic> json) {
    return AgentProfileModel(
      key: json['key']?.toString(),
      name: json['name']?.toString(),
      type: json['type']?.toString(),
      phone: json['phone']?.toString(),
      experience: json['experience']?.toString(),
      image: json['image']?.toString(),
      verified: json['verified'] as bool?,
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

class RatingBreakdownModel {
  final int five;
  final int four;
  final int three;
  final int two;
  final int one;

  const RatingBreakdownModel({
    this.five = 0,
    this.four = 0,
    this.three = 0,
    this.two = 0,
    this.one = 0,
  });

  factory RatingBreakdownModel.fromJson(Map<String, dynamic> json) {
    return RatingBreakdownModel(
      five: (json['5'] as num?)?.toInt() ?? 0,
      four: (json['4'] as num?)?.toInt() ?? 0,
      three: (json['3'] as num?)?.toInt() ?? 0,
      two: (json['2'] as num?)?.toInt() ?? 0,
      one: (json['1'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'5': five, '4': four, '3': three, '2': two, '1': one};
  }

  int get total => five + four + three + two + one;
}

class AgentReviewModel {
  final int? id;
  final int? rating;
  final String? review;
  final String? userName;
  final DateTime? updatedAt;

  const AgentReviewModel({
    this.id,
    this.rating,
    this.review,
    this.userName,
    this.updatedAt,
  });

  factory AgentReviewModel.fromJson(Map<String, dynamic> json) {
    return AgentReviewModel(
      id: (json['id'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toInt(),
      review: json['review']?.toString(),
      userName: json['user_name']?.toString(),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'review': review,
      'user_name': userName,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class AgentPropertyModel {
  final int? id;
  final String? propertyId;
  final String? title;
  final String? slug;
  final String? propertyType;
  final String? listingType;
  final String? configuration;
  final String? status;

  final bool? isActive;
  final bool? isFeatured;
  final bool? isLuxury;

  final String? badge;
  final double? price;
  final double? pricePerSqft;
  final double? securityDeposit;
  final double? maintenanceCharges;

  final String? location;
  final String? city;
  final String? state;
  final String? description;

  final double? superArea;
  final double? carpetArea;
  final double? plotArea;

  final int? bedrooms;
  final int? bathrooms;

  final String? parking;
  final String? floor;
  final int? totalFloors;
  final String? facing;
  final String? furnishing;

  final String? agentName;
  final String? agentType;
  final String? agentExperience;
  final String? agentImage;
  final String? agentPhone;
  final bool? agentVerified;

  final String? mainImage;
  final List<String> amenities;

  final double? latitude;
  final double? longitude;

  final Map<String, dynamic> raw;

  const AgentPropertyModel({
    this.id,
    this.propertyId,
    this.title,
    this.slug,
    this.propertyType,
    this.listingType,
    this.configuration,
    this.status,
    this.isActive,
    this.isFeatured,
    this.isLuxury,
    this.badge,
    this.price,
    this.pricePerSqft,
    this.securityDeposit,
    this.maintenanceCharges,
    this.location,
    this.city,
    this.state,
    this.description,
    this.superArea,
    this.carpetArea,
    this.plotArea,
    this.bedrooms,
    this.bathrooms,
    this.parking,
    this.floor,
    this.totalFloors,
    this.facing,
    this.furnishing,
    this.agentName,
    this.agentType,
    this.agentExperience,
    this.agentImage,
    this.agentPhone,
    this.agentVerified,
    this.mainImage,
    this.amenities = const [],
    this.latitude,
    this.longitude,
    this.raw = const {},
  });

  factory AgentPropertyModel.fromJson(Map<String, dynamic> json) {
    double? toDouble(dynamic value) {
      if (value == null) return null;
      return double.tryParse(value.toString());
    }

    return AgentPropertyModel(
      id: (json['id'] as num?)?.toInt(),
      propertyId: json['property_id']?.toString(),
      title: json['title']?.toString(),
      slug: json['slug']?.toString(),
      propertyType: json['property_type']?.toString(),
      listingType: json['listing_type']?.toString(),
      configuration: json['configuration']?.toString(),
      status: json['status']?.toString(),
      isActive: json['is_active'] as bool?,
      isFeatured: json['is_featured'] as bool?,
      isLuxury: json['is_luxury'] as bool?,
      badge: json['badge']?.toString(),
      price: toDouble(json['price']),
      pricePerSqft: toDouble(json['price_per_sqft']),
      securityDeposit: toDouble(json['security_deposit']),
      maintenanceCharges: toDouble(json['maintenance_charges']),
      location: json['location']?.toString(),
      city: json['city']?.toString(),
      state: json['state']?.toString(),
      description: json['description']?.toString(),
      superArea: toDouble(json['super_area']),
      carpetArea: toDouble(json['carpet_area']),
      plotArea: toDouble(json['plot_area']),
      bedrooms: (json['bedrooms'] as num?)?.toInt(),
      bathrooms: (json['bathrooms'] as num?)?.toInt(),
      parking: json['parking']?.toString(),
      floor: json['floor']?.toString(),
      totalFloors: (json['total_floors'] as num?)?.toInt(),
      facing: json['facing']?.toString(),
      furnishing: json['furnishing']?.toString(),
      agentName: json['agent_name']?.toString(),
      agentType: json['agent_type']?.toString(),
      agentExperience: json['agent_experience']?.toString(),
      agentImage: json['agent_image']?.toString(),
      agentPhone: json['agent_phone']?.toString(),
      agentVerified: json['agent_verified'] as bool?,
      mainImage: json['main_image']?.toString(),
      amenities:
          (json['amenities'] as List?)?.map((e) => e.toString()).toList() ?? [],
      latitude: toDouble(json['latitude']),
      longitude: toDouble(json['longitude']),
      raw: Map<String, dynamic>.from(json),
    );
  }

  Map<String, dynamic> toJson() => raw;
}

T? _parseMap<T>(dynamic json, T Function(Map<String, dynamic>) fromJson) {
  if (json is! Map) return null;

  try {
    return fromJson(Map<String, dynamic>.from(json));
  } catch (_) {
    return null;
  }
}

List<T> _parseList<T>(dynamic json, T Function(Map<String, dynamic>) fromJson) {
  if (json is! List) return [];

  return json
      .map((item) => _parseMap<T>(item, fromJson))
      .whereType<T>()
      .toList();
}
