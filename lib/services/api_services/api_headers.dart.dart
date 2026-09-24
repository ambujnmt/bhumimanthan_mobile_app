import '../../shared_prefs/storage/user_storage.dart';

class ApiHeaders {
  static final _header = {
    // 'Connection': 'keep-alive',
    // 'Accept-Encoding': 'gzip',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> basicHeaders() => Map.from(_header);

  static Map<String, String> authHeaders() {
    final token = UserStorage.getToken();
    final headers = basicHeaders();
    headers['Authorization'] = 'Bearer $token';
    return headers;
  }

  static Map<String, String> authHeadersWithToken(String token) {
    // final token = UserStorage.getToken();
    final headers = basicHeaders();
    headers['Authorization'] = 'Bearer $token';
    return headers;
  }

  static Map<String, String> customHeaders({
    Map<String, String>? extraHeaders,
    bool includeAuth = false,
  }) {
    final headers = basicHeaders();

    if (includeAuth) {
      final token = UserStorage.getToken();
      headers['Authorization'] = 'Bearer $token';
    }

    if (extraHeaders != null) {
      headers.addAll(extraHeaders);
    }

    return headers;
  }
}
