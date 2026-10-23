import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationHelper {
  static Future<bool> isLocationGranted() async {
    final permission = await Geolocator.checkPermission();

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Requests location permission if needed.
  static Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    // Request permission if denied.
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Handle permanently denied permission.
    if (permission == LocationPermission.deniedForever) {
      final openSettings = await _showDialog(
        Get.context!,
        title: 'Location permission required',
        message:
            'Location permission is permanently denied. '
            'Please allow it in app settings.',
        confirmText: 'Open settings',
      );

      if (openSettings) {
        await Geolocator.openAppSettings();
      }

      return false;
    }

    // Handle denied permission.
    if (permission == LocationPermission.denied) {
      final retry = await _showDialog(
        Get.context!,
        title: 'Allow location access',
        message:
            'We need your location to find nearby services. '
            'Would you like to try again?',
        confirmText: 'Try again',
      );

      if (!retry) return false;

      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Gets the current location after checking permission and GPS.
  static Future<Position?> getCurrentLocation() async {
    // 1. Request permission if required.
    final granted = await requestLocationPermission();

    if (!granted) return null;

    // 2. Check whether GPS/location services are enabled.
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      final enable = await _showDialog(
        Get.context!,
        title: 'Location is disabled',
        message: 'Please enable your device location to continue.',
        confirmText: 'Enable location',
      );

      if (enable) {
        await Geolocator.openLocationSettings();
      }

      // Call getCurrentLocation() again after returning
      // from device settings.
      return null;
    }

    // 3. Retrieve the current position.
    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
    } catch (e) {
      debugPrint('Unable to get current location: $e');
      return null;
    }
  }

  static Future<bool> _showDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
  }) async {
    if (!context.mounted) return false;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: Text(confirmText),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  static Future<String> getCityFromLatLng(LatLng latLng) async {
    final Geocoding geocoding = Geocoding();
    try {
      final placemarks = await geocoding.placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isEmpty) return 'Unknown';

      final place = placemarks.first;

      final city = place.locality?.trim();

      if (city != null && city.isNotEmpty) {
        debugPrint('City: $city');
        return city;
      }

      // Fallback for locations where locality is unavailable.
      final subLocality = place.subAdministrativeArea?.trim();

      if (subLocality != null && subLocality.isNotEmpty) {
        debugPrint('City fallback: $subLocality');
        return subLocality;
      }

      return place.administrativeArea ?? 'Unknown';
    } catch (e) {
      debugPrint('Error getting city from coordinates: $e');
      return 'Unknown';
    }
  }
}
