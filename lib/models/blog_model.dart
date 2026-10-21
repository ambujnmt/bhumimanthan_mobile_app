class BlogModel {
  final int id;
  final String title;
  final String slug;
  final String category;
  final String image;
  final String excerpt;
  final String authorName;
  final int readTime;
  final String? publishedAt;
  final bool isActive;
  final int createdBy;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  const BlogModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.category,
    required this.image,
    required this.excerpt,
    required this.authorName,
    required this.readTime,
    this.publishedAt,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      excerpt: json['excerpt'] ?? '',
      authorName: json['author_name'] ?? '',
      readTime: json['read_time'] ?? 0,
      publishedAt: json['published_at'],
      isActive: json['is_active'] ?? false,
      createdBy: json['created_by'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'category': category,
      'image': image,
      'excerpt': excerpt,
      'author_name': authorName,
      'read_time': readTime,
      'published_at': publishedAt,
      'is_active': isActive,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
