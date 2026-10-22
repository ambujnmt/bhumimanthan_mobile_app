import 'package:bhumi_manthan/models/blog_model.dart';
import 'package:bhumi_manthan/models/city_model.dart';
import 'package:bhumi_manthan/models/featured_property_model.dart';
import 'package:bhumi_manthan/models/home_banner.dart';
import 'package:bhumi_manthan/models/project_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

class HomeScreenController extends GetxController {
  final _api = ApiServices();
  final isLoading = true.obs;

  final location = LocationController.currentLocation;

  final featuredItems = <FeaturedProperty>[].obs;
  final projects = <ProjectsModel>[].obs;
  final cities = <CityModel>[].obs;
  final luxuryItems = <FeaturedProperty>[].obs;
  final banners = <HomeBanner>[].obs;
  final blogs = <BlogModel>[].obs;

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
        'radius': '100',
        if (location.value != null) ...{
          'latitude': location.value!.lat,
          'longitude': location.value!.lng,
        },
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
        'radius': '100',
        if (location.value != null) ...{
          'latitude': location.value!.lat,
          'longitude': location.value!.lng,
        },
      },
    );
    if (!res.success) return;
    projects.value = (res.data['data']['projects'] as List)
        .map((json) => ProjectsModel.fromJson(json))
        .toList();
  }

  Future<void> _getCities() async {
    final res = await _api.get(
      '/cities',
      queries: {
        'popular': '1',
        'limit': '100',
        if (location.value != null) ...{
          'latitude': location.value!.lat,
          'longitude': location.value!.lng,
        },
      },
    );
    if (!res.success) return;
    cities.value = (res.data['data']['cities'] as List)
        .map((json) => CityModel.fromJson(json))
        .toList();
  }

  Future<void> _getLuxury() async {
    final res = await _api.get(
      '/properties/luxury',
      queries: {
        'limit': '5',
        'radius': '100',
        if (location.value != null) ...{
          'latitude': location.value!.lat,
          'longitude': location.value!.lng,
        },
      },
    );
    if (!res.success) return;
    luxuryItems.value = (res.data['data']['properties'] as List)
        .map((json) => FeaturedProperty.fromJson(json))
        .toList();
  }

  Future<void> _getBlogs() async {
    final res = await _api.get(
      '/blogs',
      queries: {
        'limit': '5',
        if (location.value != null) ...{
          'latitude': location.value!.lat,
          'longitude': location.value!.lng,
        },
      },
    );
    if (!res.success) return;
    blogs.value = (res.data['data']['blogs'] as List)
        .map((json) => BlogModel.fromJson(json))
        .toList();
  }

  Future<void> refreshData() async {
    location.value = LocationController.currentLocation.value;
    isLoading(true);
    await Future.wait([
      _getBanners(),
      _getFeatured(),
      _getProjects(),
      _getCities(),
      _getLuxury(),
      _getBlogs(),
    ]);
    isLoading(false);
  }

  Future<void> _ckeckLocation() async {
    final tc = location.value?.city;
    final success = await LocationController.getCityFromIp();

    if (success & (location.value == null || location.value?.city != tc)) {
      refreshData();
    }
  }

  @override
  void onInit() {
    super.onInit();
    _ckeckLocation();
    refreshData();
  }
}
