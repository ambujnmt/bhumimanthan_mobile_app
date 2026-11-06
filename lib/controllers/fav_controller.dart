import 'package:bhumi_manthan/services/api_services/api_services.dart';

class FavController {
  static final _api = ApiServices();

  static Future<bool> add(int id) async {
    final res = await _api.post(
      '/wishlist/add',
      payload: {"property_id": id.toString()},
      skipLocation: true,
    );
    return res.success;
  }

  static Future<bool> remove(int id) async {
    final res = await _api.delete('/wishlist/remove/$id');
    return res.success;
  }
}
