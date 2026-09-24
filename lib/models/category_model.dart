class CategoryModel {
  final int id;
  final String name;
  final String iconUrl;
  final String bgColor;

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.bgColor,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      iconUrl: json['icon_url'],
      bgColor: json['bg_color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon_url': iconUrl, 'bg_color': bgColor};
  }
}
