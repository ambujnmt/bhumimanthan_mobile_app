class SubCategoryModel {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final String? icon;
  final String? status;
  final String? iconUrl;
  final String bgColor;

  SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.name,
    this.icon,
    this.status,
    this.iconUrl,
    required this.bgColor,
    required this.description,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      icon: json['icon'],
      status: json['status'],
      iconUrl: json['icon_url'],
      bgColor: json['bg_color'],
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'icon': icon,
      'status': status,
      'icon_url': iconUrl,
      'bg_color': bgColor,
      'description': description,
    };
  }
}
