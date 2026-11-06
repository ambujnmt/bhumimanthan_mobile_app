import '../utils/app_imports.dart';

class CompareController {
  static final _api = ApiServices();

  static Future<bool> add(int id) async {
    final res = await _api.post(
      '/compare/add',
      payload: {'property_id': id.toString()},
    );
    if (res.code == 409) return true;
    if (!res.success) return false;
    return true;
  }

  static Future<bool> remove(int id) async {
    final res = await _api.delete('/compare/remove/$id', showErrorToast: true);
    if (!res.success) return false;
    return true;
  }
}
