class AddressModel {
  final int id;
  final int userId;
  final String label;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String? state;
  final String country;
  final String? postalCode;
  final String latitude;
  final String longitude;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.userId,
    required this.label,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    this.state,
    required this.country,
    this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      userId: json['user_id'],
      label: json['label'],
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postal_code'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isDefault: json['is_default'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'label': label,
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'city': city,
      'state': state,
      'country': country,
      'postal_code': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'is_default': isDefault,
    };
  }
}
