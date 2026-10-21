import 'package:bhumi_manthan/geo_location/location_controller.dart';
import 'package:bhumi_manthan/models/featured_property_model.dart';
import 'package:bhumi_manthan/models/home_banner.dart';
import 'package:bhumi_manthan/models/project_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreenController extends GetxController {
  final _api = ApiServices();
  final isLoading = true.obs;

  Position? position;

  final featuredItems = <FeaturedProperty>[].obs;
  final projects = <ProjectsModel>[].obs;
  final luxuryItems = <FeaturedProperty>[].obs;
  final banners = <HomeBanner>[].obs;

  Future<void> _getBanners() async {
    final res = await _api.get('/banners');
    if (!res.success) return;
    banners.value = (res.data['data']['banners'] as List)
        .map((json) => HomeBanner.fromJson(json))
        .toList();
  }

  Future<void> _getFeatured() async {
    final res = await _api.get(
      '/properties/featured',
      queries: {
        'limit': '5',
        'latitude': position!.latitude.toString(),
        'longitude': position!.longitude.toString(),
        'radius': '100',
      },
    );
    if (!res.success) return;
    featuredItems.value = (res.data['data']['properties'] as List)
        .map((json) => FeaturedProperty.fromJson(json))
        .toList();
  }

  Future<void> _getProjects() async {
    final res = await _api.get(
      '/projects',
      queries: {
        'limit': '5',
        'latitude': position!.latitude.toString(),
        'longitude': position!.longitude.toString(),
        'radius': '100',
      },
    );
    if (!res.success) return;
    projects.value = (res.data['data']['projects'] as List)
        .map((json) => ProjectsModel.fromJson(json))
        .toList();
  }

  Future<void> _getLuxury() async {
    final res = await _api.get(
      '/properties/luxury',
      queries: {
        'limit': '5',
        'latitude': position!.latitude.toString(),
        'longitude': position!.longitude.toString(),
        'radius': '100',
      },
    );
    if (!res.success) return;
    luxuryItems.value = (res.data['data']['properties'] as List)
        .map((json) => FeaturedProperty.fromJson(json))
        .toList();
  }

  Future<void> refreshData() async {
    isLoading(true);
    if (position == null) {
      position = await LocationHelper.getCurrentLocation();
      if (position == null) {
        isLoading(false);
        return;
      }
    }
    await Future.wait([
      _getBanners(),
      _getFeatured(),
      _getProjects(),
      _getLuxury(),
    ]);
    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }
}
