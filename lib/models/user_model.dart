class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final bool termsAccepted;
  final bool isVerified;
  final String status;
  final int isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.termsAccepted,
    required this.isVerified,
    required this.status,
    required this.isDeleted,
    this.createdAt,
    this.updatedAt,
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
      isDeleted: json['is_deleted'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
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
      'is_deleted': isDeleted,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
