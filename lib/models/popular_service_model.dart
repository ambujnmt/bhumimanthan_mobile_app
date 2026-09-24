import 'service_model.dart';
import 'sub_category_model.dart';

class PopularServiceModel {
  final int id;
  final int vendorId;
  final int subcategoryId;
  final String basePrice;
  final int durationMinutes;
  final int teamSize;
  final bool equipmentIncluded;
  final String status;
  final String rating;
  final String createdAt;
  final String updatedAt;
  final int completedBookingsCount;
  final double distanceKm;
  final String title;
  final String description;
  final String image;
  final List<String> gallery;
  final SubCategoryModel? subcategory;
  final VendorModel? vendor;

  PopularServiceModel({
    required this.id,
    required this.vendorId,
    required this.subcategoryId,
    required this.basePrice,
    required this.durationMinutes,
    required this.teamSize,
    required this.equipmentIncluded,
    required this.status,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.completedBookingsCount,
    required this.distanceKm,
    required this.title,
    required this.description,
    required this.image,
    required this.gallery,
    this.subcategory,
    this.vendor,
  });

  factory PopularServiceModel.fromJson(Map<String, dynamic> json) {
    return PopularServiceModel(
      id: json['id'] ?? 0,
      vendorId: json['vendor_id'] ?? 0,
      subcategoryId: json['subcategory_id'] ?? 0,
      basePrice: json['base_price']?.toString() ?? '0',
      durationMinutes: json['duration_minutes'] ?? 0,
      teamSize: json['team_size'] ?? 0,
      equipmentIncluded: json['equipment_included'] ?? false,
      status: json['status'] ?? '',
      rating: json['rating']?.toString() ?? '0',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      completedBookingsCount: json['completed_bookings_count'] ?? 0,
      distanceKm: (json['distance_km'] ?? 0).toDouble(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      gallery: List<String>.from(json['gallery'] ?? []),
      subcategory: json['subcategory'] != null
          ? SubCategoryModel.fromJson(json['subcategory'])
          : null,
      vendor: json['vendor'] != null
          ? VendorModel.fromJson(json['vendor'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor_id': vendorId,
      'subcategory_id': subcategoryId,
      'base_price': basePrice,
      'duration_minutes': durationMinutes,
      'team_size': teamSize,
      'equipment_included': equipmentIncluded,
      'status': status,
      'rating': rating,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'completed_bookings_count': completedBookingsCount,
      'distance_km': distanceKm,
      'title': title,
      'description': description,
      'image': image,
      'gallery': gallery,
      'subcategory': subcategory?.toJson(),
      'vendor': vendor?.toJson(),
    };
  }
}
