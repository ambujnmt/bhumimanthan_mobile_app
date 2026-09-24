import 'service_model.dart';

class VendorNearby {
  final int id;
  final int userId;
  final String businessName;
  final String businessType;
  final String registrationNumber;
  final String profileImage;
  final String taxId;
  final String businessEmail;
  final String businessPhone;
  final String website;
  final String yearsInBusiness;
  final String contactFirstName;
  final String contactLastName;
  final String contactEmail;
  final String contactPhone;
  final String contactPosition;
  final String businessLocation;
  final String serviceRadius;
  final String citiesServed;
  final bool onSiteService;
  final String? serviceAreaLocation;
  final String latitude;
  final String longitude;
  final DateTime? termsAcceptedAt;
  final String bio;
  final String status;
  final String commissionType;
  final String commissionValue;
  final String ratingAvg;
  final int totalReviews;
  final int strikesCount;
  final int approvedBy;
  final DateTime? approvedAt;
  final double distanceKm;
  final List<ServiceModel> services;

  VendorNearby({
    required this.id,
    required this.userId,
    required this.businessName,
    required this.businessType,
    required this.registrationNumber,
    required this.taxId,
    required this.profileImage,
    required this.businessEmail,
    required this.businessPhone,
    required this.website,
    required this.yearsInBusiness,
    required this.contactFirstName,
    required this.contactLastName,
    required this.contactEmail,
    required this.contactPhone,
    required this.contactPosition,
    required this.businessLocation,
    required this.serviceRadius,
    required this.citiesServed,
    required this.onSiteService,
    this.serviceAreaLocation,
    required this.latitude,
    required this.longitude,
    this.termsAcceptedAt,
    required this.bio,
    required this.status,
    required this.commissionType,
    required this.commissionValue,
    required this.ratingAvg,
    required this.totalReviews,
    required this.strikesCount,
    required this.approvedBy,
    this.approvedAt,
    required this.distanceKm,
    required this.services,
  });

  factory VendorNearby.fromJson(Map<String, dynamic> json) {
    return VendorNearby(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      businessName: json['business_name'] ?? '',
      businessType: json['business_type'] ?? '',
      registrationNumber: json['registration_number'] ?? '',
      taxId: json['tax_id'] ?? '',
      profileImage: json['profile_image'] ?? '',
      businessEmail: json['business_email'] ?? '',
      businessPhone: json['business_phone'] ?? '',
      website: json['website'] ?? '',
      yearsInBusiness: json['years_in_business'] ?? '',
      contactFirstName: json['contact_first_name'] ?? '',
      contactLastName: json['contact_last_name'] ?? '',
      contactEmail: json['contact_email'] ?? '',
      contactPhone: json['contact_phone'] ?? '',
      contactPosition: json['contact_position'] ?? '',
      businessLocation: json['business_location'] ?? '',
      serviceRadius: json['service_radius'] ?? '',
      citiesServed: json['cities_served'] ?? '',
      onSiteService: json['on_site_service'] ?? false,
      serviceAreaLocation: json['service_area_location'],
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      termsAcceptedAt: json['terms_accepted_at'] != null
          ? DateTime.tryParse(json['terms_accepted_at'])
          : null,
      bio: json['bio'] ?? '',
      status: json['status'] ?? '',
      commissionType: json['commission_type'] ?? '',
      commissionValue: json['commission_value'] ?? '',
      ratingAvg: json['rating_avg'] ?? '',
      totalReviews: json['total_reviews'] ?? 0,
      strikesCount: json['strikes_count'] ?? 0,
      approvedBy: json['approved_by'] ?? 0,
      approvedAt: json['approved_at'] != null
          ? DateTime.tryParse(json['approved_at'])
          : null,
      distanceKm: (json['distance_km'] as num?)?.toDouble() ?? 0.0,
      services:
          (json['services'] as List<dynamic>?)
              ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
