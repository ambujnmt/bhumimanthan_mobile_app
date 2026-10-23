import '../utils/app_imports.dart';

class CompareController {
  static final _api = ApiServices();

  static Future<bool> addToCompare(int id) async {
    final res = await _api.post(
      '/compare/add',
      payload: {'property_id': id.toString()},
      showErrorToast: true,
    );
    if (!res.success) return false;
    return true;
  }

  static Future<bool> removeCompare(int id) async {
    final res = await _api.delete('/compare/remove/$id', showErrorToast: true);
    if (!res.success) return false;
    return true;
  }
}
