import 'package:bhumi_manthan/utils/app_imports.dart';

import '../../../models/city_model.dart';

class AllCitiesScreenController extends GetxController {
  final isLoading = true.obs;

  final cities = Rxn<List<CityModel>>();
  final filteredCities = Rxn<List<CityModel>>();

  final fNode = FocusNode();

  Future<void> _getData() async {
    final res = await ApiServices().get('/cities', queries: {'popular': '1'});
    if (!res.success) return;
    cities.value = (res.data['data']['cities'] as List)
        .map((json) => CityModel.fromJson(json))
        .toList();
  }

  void searchCity(String query) {
    filteredCities.value = cities.value!.where((city) {
      return city.name.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();
  }

  Future<void> refreshData() async {
    isLoading(true);
    await _getData();
    isLoading(false);
  }

  void _startListemNode() {
    fNode.addListener(() {
      if (fNode.hasFocus) {
        filteredCities.value = [];
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    _startListemNode();
    refreshData();
  }
}
