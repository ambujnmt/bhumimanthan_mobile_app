class FcmDataModel {
  final String referenceId;
  final String? route;
  final String title;
  final String body;

  const FcmDataModel({
    required this.referenceId,
    this.route,
    required this.title,
    required this.body,
  });

  factory FcmDataModel.fromJson(Map<String, dynamic> json) {
    return FcmDataModel(
      referenceId: json['reference_id']?.toString() ?? '',
      route: json['route'],
      title: json['title']?.toString() ?? 'New Notification',
      body: json['body']?.toString() ?? 'Data not found',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reference_id': referenceId,
      'route': route,
      'title': title,
      'body': body,
    };
  }
}
