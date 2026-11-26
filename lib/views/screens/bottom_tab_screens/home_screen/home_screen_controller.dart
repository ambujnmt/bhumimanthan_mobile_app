import 'package:bhumi_manthan/models/nearby_agent_model.dart';
import 'package:bhumi_manthan/models/blog_model.dart';
import 'package:bhumi_manthan/models/category_model.dart';
import 'package:bhumi_manthan/models/city_model.dart';
import 'package:bhumi_manthan/models/featured_property_model.dart';
import 'package:bhumi_manthan/models/home_banner.dart';
import 'package:bhumi_manthan/models/project_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

class HomeScreenController extends GetxController {
  final _api = ApiServices();
  final isLoading = true.obs;

  final location = LocationController.currentLocation;

  final categories = <CategoryModel>[].obs;
  final featuredItems = <FeaturedProperty>[].obs;
  final projects = <ProjectsModel>[].obs;
  final cities = <CityModel>[].obs;
  final luxuryItems = <FeaturedProperty>[].obs;
  final banners = <HomeBanner>[].obs;
  final blogs = <BlogModel>[].obs;
  final agents = <AgentModel>[].obs;

  Future<void> _getBanners() async {
    final res = await _api.get('/banners');
    if (!res.success) return;
    banners.value = JsonParser.parseList(
      res.data['data']['banners'],
      (json) => HomeBanner.fromJson(json),
    );
  }

  Future<void> _getCategories() async {
    final res = await _api.get('/property-categories');
    if (!res.success) return;
    categories.value = JsonParser.parseList(
      res.data['data']['categories'],
      (json) => CategoryModel.fromJson(json),
    );
  }

  Future<void> _getFeatured() async {
    final res = await _api.get(
      '/properties/featured',
      queries: {'limit': '15'},
    );
    if (!res.success) return;
    featuredItems.value = JsonParser.parseList(
      res.data['data']['properties'],
      (json) => FeaturedProperty.fromJson(json),
    );
  }

  Future<void> _getProjects() async {
    final res = await _api.get('/projects', queries: {'limit': '15'});
    if (!res.success) return;
    projects.value = JsonParser.parseList(
      res.data['data']['projects'],
      (json) => ProjectsModel.fromJson(json),
    );
  }

  Future<void> _getCities() async {
    final res = await _api.get(
      '/cities',
      queries: {'popular': '1', 'limit': '50'},
    );
    if (!res.success) return;
    cities.value = JsonParser.parseList(
      res.data['data']['cities'],
      (json) => CityModel.fromJson(json),
    );
  }

  Future<void> _getLuxury() async {
    final res = await _api.get('/properties/luxury', queries: {'limit': '15'});
    if (!res.success) return;
    luxuryItems.value = JsonParser.parseList(
      res.data['data']['properties'],
      (json) => FeaturedProperty.fromJson(json),
    );
  }

  Future<void> _getBlogs() async {
    final res = await _api.get('/blogs', queries: {'limit': '15'});
    if (!res.success) return;
    blogs.value = JsonParser.parseList(
      res.data['data']['blogs'],
      (json) => BlogModel.fromJson(json),
    );
  }

  Future<void> _getTopAgents() async {
    final res = await _api.get('/agents/nearby', queries: {'limit': '15'});
    if (!res.success) return;
    agents.value = JsonParser.parseList<AgentModel>(
      res.data['data']['agents'],
      (json) => AgentModel.fromJson(json),
    );
  }

  Future<void> refreshData() async {
    isLoading(true);
    await Future.wait([
      _getBanners(),
      _getCategories(),
      _getFeatured(),
      _getProjects(),
      _getCities(),
      _getLuxury(),
      _getBlogs(),
      _getTopAgents(),
    ]);
    isLoading(false);
  }

  Future<void> _ckeckLocation() async {
    final tc = location.value?.city;

    final success = await LocationController.getCityFromIp();

    if (!success) return;

    if (location.value == null || location.value?.city != tc) {
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
