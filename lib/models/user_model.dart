class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String? profileImage;
  final bool termsAccepted;
  final bool isVerified;
  final String status;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.termsAccepted,
    required this.isVerified,
    required this.status,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      termsAccepted: json['terms_accepted'] ?? false,
      isVerified: json['is_verified'] ?? false,
      status: json['status'] ?? '',
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'terms_accepted': termsAccepted,
      'is_verified': isVerified,
      'status': status,
      'profile_image': profileImage,
    };
  }
}
