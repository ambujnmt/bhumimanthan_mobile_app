import 'package:bhumi_manthan/zz_main_screen/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../geo_location/location_controller.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  bool isLoading = false;
  Position? position;

  final _con = Get.find<MainScreenController>();
  Future<void> requestLocationPermission() async {
    setState(() => isLoading = true);

    try {
      final success = await LocationHelper.requestLocationPermission();

      if (!mounted || !success) return;
      _con.isLocationGranted(true);
    } catch (e) {
      if (mounted) {
        Get.snackbar('Error', 'Unable to get your location.');
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Permission')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                'Enable Location',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Allow location access to find services '
                'near your current location.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : requestLocationPermission,
                  child: isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Allow Location Access'),
                ),
              ),
              if (position != null) ...[
                const SizedBox(height: 20),
                Text('Latitude: ${position!.latitude}'),
                Text('Longitude: ${position!.longitude}'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
