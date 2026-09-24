import 'package:bhumi_manthan/models/sub_category_model.dart';

class ServiceModel {
  final int? id;
  final int? vendorId;
  final int? subcategoryId;
  final String title;
  final String description;
  final double basePrice;
  final int? durationMinutes;
  final String? status;
  final double? rating;
  final VendorModel? vendor;
  final String image;
  final List<String> whatsIncluded;
  final List<String> gallery;
  final SubCategoryModel? subcategory;

  ServiceModel({
    this.id,
    this.vendorId,
    this.subcategoryId,
    required this.title,
    required this.description,
    required this.basePrice,
    this.durationMinutes,
    this.status,
    this.rating,
    this.vendor,
    this.gallery = const [],
    this.subcategory,
    required this.image,
    required this.whatsIncluded,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      vendorId: json['vendor_id'],
      subcategoryId: json['subcategory_id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      basePrice: double.tryParse('${json['base_price']}') ?? 0.0,
      durationMinutes: json['duration_minutes'],
      status: json['status'],
      rating: double.tryParse(json['rating']?.toString() ?? ''),
      image: json['image'] ?? '',
      vendor: json['vendor'] != null
          ? VendorModel.fromJson(json['vendor'])
          : null,
      gallery: ((json['gallery'] as List?) ?? []).isNotEmpty
          ? (json['gallery'] as List).map((e) => e.toString()).toList()
          : [],
      whatsIncluded: ((json['whats_included'] as List?) ?? []).isNotEmpty
          ? (json['whats_included'] as List).map((e) => e.toString()).toList()
          : [],
      subcategory: json['subcategory'] != null
          ? SubCategoryModel.fromJson(json['subcategory'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor_id': vendorId,
      'subcategory_id': subcategoryId,
      'title': title,
      'description': description,
      'base_price': basePrice.toString(),
      'duration_minutes': durationMinutes,
      'status': status,
      'rating': rating?.toString(),
      'vendor': vendor?.toJson(),
      'image': image,
      'gallery': gallery.map((e) => e).toList(),
      'subcategory': subcategory?.toJson(),
    };
  }
}

class VendorModel {
  final int id;
  final int userId;
  final String businessName;
  final String? businessType;
  final String? registrationNumber;
  final String? taxId;
  final String? businessEmail;
  final String? businessPhone;
  final String? website;
  final String? yearsInBusiness;
  final String? contactFirstName;
  final String? contactLastName;
  final String? contactEmail;
  final String? contactPhone;
  final String? contactPosition;
  final String? businessLocation;
  final String? serviceRadius;
  final String? citiesServed;
  final bool? onSiteService;
  final String? serviceAreaLocation;
  final DateTime? termsAcceptedAt;
  final String? bio;
  final String? status;
  final String? commissionType;
  final double? commissionValue;
  final double? ratingAvg;
  final int? totalReviews;
  final String profileImage;
  final String? aboutUs;
  final List<ServiceModel> services;

  VendorModel({
    required this.id,
    required this.userId,
    required this.businessName,
    this.businessType,
    this.registrationNumber,
    this.taxId,
    this.businessEmail,
    this.businessPhone,
    this.website,
    this.yearsInBusiness,
    this.contactFirstName,
    this.contactLastName,
    this.contactEmail,
    this.contactPhone,
    this.contactPosition,
    this.businessLocation,
    this.serviceRadius,
    this.citiesServed,
    this.onSiteService,
    this.serviceAreaLocation,
    this.termsAcceptedAt,
    this.bio,
    this.status,
    this.commissionType,
    this.commissionValue,
    this.ratingAvg,
    this.totalReviews,
    required this.profileImage,
    this.aboutUs,
    this.services = const [],
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      businessName: json['business_name'] ?? '',
      businessType: json['business_type'],
      registrationNumber: json['registration_number'],
      taxId: json['tax_id'],
      businessEmail: json['business_email'],
      businessPhone: json['business_phone'],
      website: json['website'],
      yearsInBusiness: json['years_in_business']?.toString(),
      contactFirstName: json['contact_first_name'],
      contactLastName: json['contact_last_name'],
      contactEmail: json['contact_email'],
      contactPhone: json['contact_phone'],
      contactPosition: json['contact_position'],
      businessLocation: json['business_location'],
      serviceRadius: json['service_radius'],
      citiesServed: json['cities_served'],
      onSiteService: json['on_site_service'],
      serviceAreaLocation: json['service_area_location'],
      termsAcceptedAt: json['terms_accepted_at'] != null
          ? DateTime.tryParse(json['terms_accepted_at'])
          : null,
      bio: json['bio'],
      status: json['status'],
      commissionType: json['commission_type'],
      commissionValue: double.tryParse(
        json['commission_value']?.toString() ?? '',
      ),
      ratingAvg: double.tryParse(json['rating_avg']?.toString() ?? ''),
      totalReviews: json['total_reviews'],
      profileImage: json['profile_image'] ?? '',
      aboutUs: json['about_us'],
      services: ((json['services'] as List?) ?? []).isNotEmpty
          ? (json['services'] as List)
                .map((e) => ServiceModel.fromJson(e))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'business_name': businessName,
      'business_type': businessType,
      'registration_number': registrationNumber,
      'tax_id': taxId,
      'business_email': businessEmail,
      'business_phone': businessPhone,
      'website': website,
      'years_in_business': yearsInBusiness,
      'contact_first_name': contactFirstName,
      'contact_last_name': contactLastName,
      'contact_email': contactEmail,
      'contact_phone': contactPhone,
      'contact_position': contactPosition,
      'business_location': businessLocation,
      'service_radius': serviceRadius,
      'cities_served': citiesServed,
      'on_site_service': onSiteService,
      'service_area_location': serviceAreaLocation,
      'terms_accepted_at': termsAcceptedAt?.toIso8601String(),
      'bio': bio,
      'status': status,
      'commission_type': commissionType,
      'commission_value': commissionValue?.toString(),
      'rating_avg': ratingAvg?.toString(),
      'total_reviews': totalReviews,
    };
  }
}

// class ServiceImageModel {
//   final int? id;
//   final int? serviceId;
//   final String? imagePath;
//   final String? imageUrl;

//   ServiceImageModel({this.id, this.serviceId, this.imagePath, this.imageUrl});

//   factory ServiceImageModel.fromJson(Map<String, dynamic> json) {
//     return ServiceImageModel(
//       id: json['id'],
//       serviceId: json['service_id'],
//       imagePath: json['image_path'],
//       imageUrl: json['image_url'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'service_id': serviceId,
//       'image_path': imagePath,
//       'image_url': imageUrl,
//     };
//   }
// }
