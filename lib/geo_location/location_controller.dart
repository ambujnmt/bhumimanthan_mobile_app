import 'dart:convert';

import 'package:bhumi_manthan/models/ip_details_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

class LocationController {
  static final _api = ApiServices();

  static final currentLocation = Rxn<SavedLocation>(_LocationStorage.get());

  static void getSavedLocation() =>
      currentLocation.value = _LocationStorage.get();

  static Future<void> setLocation(SavedLocation location) async {
    await _LocationStorage.set(location);
    currentLocation.value = _LocationStorage.get();
    debugPrint('location set to: ${currentLocation.value?.toJson()}');
  }

  static Future<bool> getCityFromIp() async {
    final res = await _api.get(
      '/location/detect',
      // uri: Uri.parse('https://free.freeipapi.com/api/json/'),
    );
    if (!res.success) return false;

    final ipd = IpDetailsModel.fromJson(res.data['data']);
    // final ipd = IpDetailsModel.fromJson(res.data);

    if ([ipd.latitude, ipd.longitude, ipd.city].any((r) => r == null)) {
      return false;
    }

    await setLocation(
      SavedLocation(
        lat: ipd.latitude.toString(),
        lng: ipd.longitude.toString(),
        city: ipd.city!,
      ),
    );

    return true;
  }
}

class _LocationStorage {
  static final _storageKey = 'location_storage';

  static Future<void> set(SavedLocation location) async {
    await SharedPrefs.setString(_storageKey, jsonEncode(location.toJson()));
  }

  static SavedLocation? get() {
    try {
      final str = SharedPrefs.getString(_storageKey);
      if (str == null) return null;

      return SavedLocation.fromJson(jsonDecode(str));
    } catch (e) {
      return null;
    }
  }
}

class SavedLocation {
  final String lat;
  final String lng;
  final String city;

  const SavedLocation({
    required this.lat,
    required this.lng,
    required this.city,
  });

  factory SavedLocation.fromJson(Map<String, dynamic> json) {
    return SavedLocation(
      lat: json['lat'],
      lng: json['lng'],
      city: json['city'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lng': lng, 'city': city};
  }
}
