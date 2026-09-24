class UserModel {
  final int id;
  final String role;
  final String name;
  final String? userName;
  final String email;
  final String phone;
  final String? profileImage;
  final String languagePreference;
  final String? passportNumber;
  final String? dob;
  final String? website;
  final String? bio;
  final String? gender;
  final String? emailVerifiedAt;
  final String? phoneVerifiedAt;
  final String? otpExpiresAt;
  final int otpAttempts;
  final String? otpLockedUntil;
  final String? fcmToken;
  final int notifyPush;
  final int notifySms;
  final int notifyEmail;
  final int notifyPromotions;
  final String searchSortPreference;
  final int searchRadiusKm;
  final String status;
  final String? isVerified;
  final String? address;
  final String? zipCode;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  const UserModel({
    required this.id,
    required this.role,
    required this.name,
    this.userName,
    required this.email,
    required this.phone,
    this.profileImage,
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
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      role: json['role'] ?? '',
      name: json['name'] ?? '',
      userName: json['user_name'],
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profileImage: json['profile_image'],
      languagePreference: json['language_preference'] ?? 'en',
      passportNumber: json['passport_number'],
      dob: json['dob'],
      website: json['website'],
      bio: json['bio'],
      gender: json['gender'],
      emailVerifiedAt: json['email_verified_at'],
      phoneVerifiedAt: json['phone_verified_at'],
      otpExpiresAt: json['otp_expires_at'],
      otpAttempts: json['otp_attempts'] ?? 0,
      otpLockedUntil: json['otp_locked_until'],
      fcmToken: json['fcm_token'],
      notifyPush: json['notify_push'] ?? 0,
      notifySms: json['notify_sms'] ?? 0,
      notifyEmail: json['notify_email'] ?? 0,
      notifyPromotions: json['notify_promotions'] ?? 0,
      searchSortPreference: json['search_sort_preference'] ?? 'distance',
      searchRadiusKm: json['search_radius_km'] ?? 5,
      status: json['status'] ?? '',
      isVerified: json['is_verified'],
      address: json['address'],
      zipCode: json['zip_code'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'name': name,
      'user_name': userName,
      'email': email,
      'phone': phone,
      'profile_image': profileImage,
      'language_preference': languagePreference,
      'passport_number': passportNumber,
      'dob': dob,
      'website': website,
      'bio': bio,
      'gender': gender,
      'email_verified_at': emailVerifiedAt,
      'phone_verified_at': phoneVerifiedAt,
      'otp_expires_at': otpExpiresAt,
      'otp_attempts': otpAttempts,
      'otp_locked_until': otpLockedUntil,
      'fcm_token': fcmToken,
      'notify_push': notifyPush,
      'notify_sms': notifySms,
      'notify_email': notifyEmail,
      'notify_promotions': notifyPromotions,
      'search_sort_preference': searchSortPreference,
      'search_radius_km': searchRadiusKm,
      'status': status,
      'is_verified': isVerified,
      'address': address,
      'zip_code': zipCode,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
