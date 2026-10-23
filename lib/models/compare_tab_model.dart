class ComparedTab {
  final String propertyType;
  final int count;
  final int max;
  final bool canAdd;
  final bool canCompare;
  final List<ComparedProperty> properties;

  ComparedTab({
    required this.propertyType,
    required this.count,
    required this.max,
    required this.canAdd,
    required this.canCompare,
    required this.properties,
  });

  factory ComparedTab.fromJson(Map<String, dynamic> json) {
    return ComparedTab(
      propertyType: json['property_type'] ?? '',
      count: json['count'] ?? 0,
      max: json['max'] ?? 0,
      canAdd: json['can_add'] ?? false,
      canCompare: json['can_compare'] ?? false,
      properties: (json['properties'] as List<dynamic>? ?? [])
          .map(
            (item) =>
                ComparedProperty.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'property_type': propertyType,
      'count': count,
      'max': max,
      'can_add': canAdd,
      'can_compare': canCompare,
      'properties': properties.map((item) => item.toJson()).toList(),
    };
  }
}

class ComparedProperty {
  final int id;
  final String title;
  final String slug;
  final String mainImage;
  final num price;
  final String propertyType;
  final String listingType;
  final String configuration;
  final int? bedrooms;
  final num? superArea;
  final String location;
  final String city;

  ComparedProperty({
    required this.id,
    required this.title,
    required this.slug,
    required this.mainImage,
    required this.price,
    required this.propertyType,
    required this.listingType,
    required this.configuration,
    this.bedrooms,
    this.superArea,
    required this.location,
    required this.city,
  });

  factory ComparedProperty.fromJson(Map<String, dynamic> json) {
    return ComparedProperty(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      mainImage: json['main_image'] ?? '',
      price: json['price'] ?? 0,
      propertyType: json['property_type'] ?? '',
      listingType: json['listing_type'] ?? '',
      configuration: json['configuration'] ?? '',
      bedrooms: json['bedrooms'] as int?,
      superArea: json['super_area'] as num?,
      location: json['location'] ?? '',
      city: json['city'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'main_image': mainImage,
      'price': price,
      'property_type': propertyType,
      'listing_type': listingType,
      'configuration': configuration,
      'bedrooms': bedrooms,
      'super_area': superArea,
      'location': location,
      'city': city,
    };
  }
}
