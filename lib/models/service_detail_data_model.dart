import 'available_date.dart';
import 'service_model.dart';

class ServiceDetailDataModel {
  final ServiceModel service;
  final ServiceDetailVendor vendor;
  final List<AvailableDate> availableDates;

  ServiceDetailDataModel({
    required this.service,
    required this.vendor,
    this.availableDates = const [],
  });

  factory ServiceDetailDataModel.fromJson(Map<String, dynamic> json) {
    return ServiceDetailDataModel(
      service: ServiceModel.fromJson(json['service']),
      vendor: ServiceDetailVendor.fromJson(json['vendor']),
      availableDates: (json['available_dates'] ?? []).isEmpty
          ? []
          : (json['available_dates'] as List)
                .map((e) => AvailableDate.fromJson(e))
                .toList(),
    );
  }
}

class ServiceDetailVendor {
  final int id;
  final String businessName;
  final String aboutUs;
  final String profileImage;
  final String ratingAvg;
  final int totalReviews;
  final bool? isVerified;
  final int? yearsExperience;
  final int totalBookings;
  final List<OtherService> otherServices;

  ServiceDetailVendor({
    required this.id,
    required this.businessName,
    required this.aboutUs,
    required this.profileImage,
    required this.ratingAvg,
    required this.totalReviews,
    this.isVerified,
    this.yearsExperience,
    required this.totalBookings,
    required this.otherServices,
  });

  factory ServiceDetailVendor.fromJson(Map<String, dynamic> json) {
    return ServiceDetailVendor(
      id: json['id'] ?? 0,
      businessName: json['business_name'] ?? '',
      aboutUs: json['about_us'] ?? '',
      profileImage: json['profile_image'] ?? '',
      ratingAvg: json['rating_avg'] ?? '0.00',
      totalReviews: json['total_reviews'] ?? 0,
      isVerified: json['is_verified'],
      yearsExperience: json['years_experience'],
      totalBookings: json['total_bookings'] ?? 0,
      otherServices:
          (json['other_services'] as List<dynamic>?)
              ?.map((e) => OtherService.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_name': businessName,
      'about_us': aboutUs,
      'profile_image': profileImage,
      'rating_avg': ratingAvg,
      'total_reviews': totalReviews,
      'is_verified': isVerified,
      'years_experience': yearsExperience,
      'total_bookings': totalBookings,
      'other_services': otherServices.map((e) => e.toJson()).toList(),
    };
  }
}

class OtherService {
  final int id;
  final String title;

  OtherService({required this.id, required this.title});

  factory OtherService.fromJson(Map<String, dynamic> json) {
    return OtherService(id: json['id'] ?? 0, title: json['title'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }
}
