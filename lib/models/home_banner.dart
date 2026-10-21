class HomeBanner {
  final int id;
  final String title;
  final String image;
  final String? link;
  final int sortOrder;
  final bool isActive;
  final int createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const HomeBanner({
    required this.id,
    required this.title,
    required this.image,
    this.link,
    required this.sortOrder,
    required this.isActive,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory HomeBanner.fromJson(Map<String, dynamic> json) {
    return HomeBanner(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      link: json['link']?.toString(),
      sortOrder: json['sort_order'] ?? 0,
      isActive: json['is_active'] ?? false,
      createdBy: json['created_by'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'link': link,
      'sort_order': sortOrder,
      'is_active': isActive,
      'created_by': createdBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
