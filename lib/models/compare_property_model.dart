class CompareProperty {
  final int id;
  final String title;
  final String slug;
  final String image;
  final num price;
  final String city;
  final int? bedrooms;
  final int? bathrooms;
  final num? area;
  final num? pricePerSqft;
  final String propertyType;
  final String furnishing;
  final String? possession;

  CompareProperty({
    required this.id,
    required this.title,
    required this.slug,
    required this.image,
    required this.price,
    required this.city,
    this.bedrooms,
    this.bathrooms,
    this.area,
    this.pricePerSqft,
    required this.propertyType,
    required this.furnishing,
    this.possession,
  });

  factory CompareProperty.fromJson(Map<String, dynamic> json) {
    return CompareProperty(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] ?? 0,
      city: json['city'] ?? '',
      bedrooms: json['bedrooms'] as int?,
      bathrooms: json['bathrooms'] as int?,
      area: json['area'] as num?,
      pricePerSqft: json['price_per_sqft'] as num?,
      propertyType: json['property_type'] ?? '',
      furnishing: json['furnishing'] ?? '',
      possession: json['possession'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'image': image,
      'price': price,
      'city': city,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'price_per_sqft': pricePerSqft,
      'property_type': propertyType,
      'furnishing': furnishing,
      'possession': possession,
    };
  }
}
