class SummaryModel {
  final int id;
  final String bookingNumber;
  final int customerId;
  final int addressId;
  final String? customerLatitude;
  final String? customerLongitude;
  final DateTime bookingDate;
  final String bookingTime;
  final String? notes;
  final String status;
  final String basePrice;
  final String discountAmount;
  final String taxAmount;
  final String totalAmount;
  final String commissionAmount;
  final String vendorEarning;
  final String cancellationFee;
  final String? cancelledBy;
  final String? cancellationReason;
  final DateTime? vendorResponseDeadline;
  final bool autoDeclined;
  final DateTime? noShowReportedAt;
  final int? noShowReportedBy;

  final SummaryService service;
  final SummaryVendor vendor;
  final SummaryAddress address;

  SummaryModel({
    required this.id,
    required this.bookingNumber,
    required this.customerId,
    required this.addressId,
    this.customerLatitude,
    this.customerLongitude,
    required this.bookingDate,
    required this.bookingTime,
    this.notes,
    required this.status,
    required this.basePrice,
    required this.discountAmount,
    required this.taxAmount,
    required this.totalAmount,
    required this.commissionAmount,
    required this.vendorEarning,
    required this.cancellationFee,
    this.cancelledBy,
    this.cancellationReason,
    this.vendorResponseDeadline,
    required this.autoDeclined,
    this.noShowReportedAt,
    this.noShowReportedBy,
    required this.service,
    required this.vendor,
    required this.address,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      id: json['id'] ?? 0,
      bookingNumber: json['booking_number'] ?? '',
      customerId: json['customer_id'] ?? 0,
      addressId: json['address_id'] ?? 0,
      customerLatitude: json['customer_latitude'],
      customerLongitude: json['customer_longitude'],
      bookingDate: DateTime.parse(json['booking_date']),
      bookingTime: json['booking_time'] ?? '',
      notes: json['notes'],
      status: json['status'] ?? '',
      basePrice: json['base_price'] ?? '0.00',
      discountAmount: json['discount_amount'] ?? '0.00',
      taxAmount: json['tax_amount'] ?? '0.00',
      totalAmount: json['total_amount'] ?? '0.00',
      commissionAmount: json['commission_amount'] ?? '0.00',
      vendorEarning: json['vendor_earning'] ?? '0.00',
      cancellationFee: json['cancellation_fee'] ?? '0.00',
      cancelledBy: json['cancelled_by'],
      cancellationReason: json['cancellation_reason'],
      vendorResponseDeadline: json['vendor_response_deadline'] != null
          ? DateTime.parse(json['vendor_response_deadline'])
          : null,
      autoDeclined: json['auto_declined'] ?? false,
      noShowReportedAt: json['no_show_reported_at'] != null
          ? DateTime.parse(json['no_show_reported_at'])
          : null,
      noShowReportedBy: json['no_show_reported_by'],
      service: SummaryService.fromJson(json['service']),
      vendor: SummaryVendor.fromJson(json['vendor']),
      address: SummaryAddress.fromJson(json['address']),
    );
  }
}

class SummaryService {
  final int id;
  final int vendorId;
  final int subcategoryId;
  final String title;
  final String image;
  final String descriptionEn;
  final String descriptionFr;
  final String basePrice;
  final int durationMinutes;
  final int teamSize;
  final bool equipmentIncluded;
  final String status;
  final String rating;
  // final String durationMinutes;

  SummaryService({
    required this.id,
    required this.vendorId,
    required this.subcategoryId,
    required this.title,
    required this.descriptionEn,
    required this.descriptionFr,
    required this.basePrice,
    required this.durationMinutes,
    required this.teamSize,
    required this.equipmentIncluded,
    required this.status,
    required this.rating,
    required this.image,
    // required this.durationMinutes,
  });

  factory SummaryService.fromJson(Map<String, dynamic> json) {
    return SummaryService(
      id: json['id'] ?? 0,
      vendorId: json['vendor_id'] ?? 0,
      subcategoryId: json['subcategory_id'] ?? 0,
      title: json['title'] ?? '',
      descriptionEn: json['description_en'] ?? '',
      descriptionFr: json['description_fr'] ?? '',
      basePrice: json['base_price'] ?? '0.00',
      durationMinutes: json['duration_minutes'] ?? 0,
      teamSize: json['team_size'] ?? 0,
      equipmentIncluded: json['equipment_included'] ?? false,
      status: json['status'] ?? '',
      rating: json['rating'] ?? '0.00',
      image: json['image'] ?? '',
    );
  }
}

class SummaryVendor {
  final int id;
  final int userId;
  final String businessName;
  final String businessType;
  final String registrationNumber;
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
  final String profileImage;
  final SummaryUser user;

  SummaryVendor({
    required this.id,
    required this.userId,
    required this.businessName,
    required this.businessType,
    required this.registrationNumber,
    required this.taxId,
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
    required this.profileImage,
    required this.user,
  });

  factory SummaryVendor.fromJson(Map<String, dynamic> json) {
    return SummaryVendor(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      businessName: json['business_name'] ?? '',
      businessType: json['business_type'] ?? '',
      registrationNumber: json['registration_number'] ?? '',
      taxId: json['tax_id'] ?? '',
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
          ? DateTime.parse(json['terms_accepted_at'])
          : null,
      bio: json['bio'] ?? '',
      status: json['status'] ?? '',
      commissionType: json['commission_type'] ?? '',
      commissionValue: json['commission_value'] ?? '0.00',
      ratingAvg: json['rating_avg'] ?? '0.00',
      totalReviews: json['total_reviews'] ?? 0,
      strikesCount: json['strikes_count'] ?? 0,
      approvedBy: json['approved_by'] ?? 0,
      profileImage: json['profile_image'] ?? '',
      user: SummaryUser.fromJson(json['user']),
    );
  }
}

class SummaryUser {
  final int id;
  final String role;
  final String name;
  final String? userName;
  final String email;
  final String phone;
  final String profileImage;
  final String languagePreference;
  final String? passportNumber;
  final DateTime? dob;
  final String? website;
  final String? bio;
  final String? gender;
  final DateTime? emailVerifiedAt;
  final DateTime? phoneVerifiedAt;
  final DateTime? otpExpiresAt;
  final int otpAttempts;
  final DateTime? otpLockedUntil;
  final String? fcmToken;
  final int notifyPush;
  final int notifySms;
  final int notifyEmail;
  final int notifyPromotions;
  final String searchSortPreference;
  final int searchRadiusKm;
  final String status;
  final bool? isVerified;
  final String? address;
  final String? zipCode;

  SummaryUser({
    required this.id,
    required this.role,
    required this.name,
    this.userName,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.languagePreference,
    this.passportNumber,
    this.dob,
    this.website,
    this.bio,
    this.gender,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.otpExpiresAt,
    required this.otpAttempts,
    this.otpLockedUntil,
    this.fcmToken,
    required this.notifyPush,
    required this.notifySms,
    required this.notifyEmail,
    required this.notifyPromotions,
    required this.searchSortPreference,
    required this.searchRadiusKm,
    required this.status,
    this.isVerified,
    this.address,
    this.zipCode,
  });

  factory SummaryUser.fromJson(Map<String, dynamic> json) {
    return SummaryUser(
      id: json['id'] ?? 0,
      role: json['role'] ?? '',
      name: json['name'] ?? '',
      userName: json['user_name'],
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profileImage: json['profile_image'] ?? '',
      languagePreference: json['language_preference'] ?? 'en',
      passportNumber: json['passport_number'],
      dob: json['dob'] != null ? DateTime.tryParse(json['dob']) : null,
      website: json['website'],
      bio: json['bio'],
      gender: json['gender'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.tryParse(json['email_verified_at'])
          : null,
      phoneVerifiedAt: json['phone_verified_at'] != null
          ? DateTime.tryParse(json['phone_verified_at'])
          : null,
      otpExpiresAt: json['otp_expires_at'] != null
          ? DateTime.tryParse(json['otp_expires_at'])
          : null,
      otpAttempts: json['otp_attempts'] ?? 0,
      otpLockedUntil: json['otp_locked_until'] != null
          ? DateTime.tryParse(json['otp_locked_until'])
          : null,
      fcmToken: json['fcm_token'],
      notifyPush: json['notify_push'] ?? 0,
      notifySms: json['notify_sms'] ?? 0,
      notifyEmail: json['notify_email'] ?? 0,
      notifyPromotions: json['notify_promotions'] ?? 0,
      searchSortPreference: json['search_sort_preference'] ?? '',
      searchRadiusKm: json['search_radius_km'] ?? 0,
      status: json['status'] ?? '',
      isVerified: json['is_verified'],
      address: json['address'],
      zipCode: json['zip_code'],
    );
  }
}

class SummaryAddress {
  final int id;
  final int userId;
  final String label;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String? state;
  final String country;
  final String postalCode;
  final String latitude;
  final String longitude;
  final bool isDefault;

  SummaryAddress({
    required this.id,
    required this.userId,
    required this.label,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    this.state,
    required this.country,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
  });

  factory SummaryAddress.fromJson(Map<String, dynamic> json) {
    return SummaryAddress(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      label: json['label'] ?? '',
      addressLine1: json['address_line1'] ?? '',
      addressLine2: json['address_line2'],
      city: json['city'] ?? '',
      state: json['state'],
      country: json['country'] ?? '',
      postalCode: json['postal_code'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      isDefault: json['is_default'] ?? false,
    );
  }
}
