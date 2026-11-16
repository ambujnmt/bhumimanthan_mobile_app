class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final int sortOrder;
  final List<CategoryChildModel> children;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.sortOrder,
    required this.children,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      sortOrder: json['sort_order'] ?? 0,
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => CategoryChildModel.fromJson(e))
          .toList(),
    );
  }
}

class CategoryChildModel {
  final int id;
  final int parentId;
  final String name;
  final String slug;
  final bool isActive;
  final int sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CategoryChildModel({
    required this.id,
    required this.parentId,
    required this.name,
    required this.slug,
    required this.isActive,
    required this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryChildModel.fromJson(Map<String, dynamic> json) {
    return CategoryChildModel(
      id: json['id'] ?? 0,
      parentId: json['parent_id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      isActive: json['is_active'] ?? false,
      sortOrder: json['sort_order'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}
