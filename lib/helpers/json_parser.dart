import '../utils/app_imports.dart';

class JsonParser {
  JsonParser._();

  static T? tryParse<T>(
    dynamic json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (json is! Map) return null;

    try {
      return fromJson(Map<String, dynamic>.from(json));
    } catch (e) {
      debugPrint('error parsing json: $e');
      return null;
    }
  }

  static List<T> parseList<T>(
    dynamic data,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (data == null || data is! List) return [];

    return data
        .map((item) => tryParse<T>(item, fromJson))
        .whereType<T>()
        .toList();
  }
}
