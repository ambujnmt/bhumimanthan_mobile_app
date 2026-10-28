import 'dart:async';
import 'dart:convert';

import 'package:bhumi_manthan/utils/app_imports.dart';

class SearchScreenController extends GetxController {
  final _api = ApiServices();

  Map? jsonData;

  final isLoading = true.obs;

  final showFilters = false.obs;

  final textController = TextEditingController();

  final textNode = FocusNode();

  final cities = <String>[].obs;

  final localities = <String>[].obs;

  final tabs = <SearchTab>[].obs;

  late final selectedTab = Rxn<SearchTab>();

  final selectedTags = <SearchTag>[].obs;

  final suggestions = <SearchTag>[].obs;

  Future<void> _getCities() async {
    if (jsonData == null) {
      await _getSearchData();
    } else {
      _getSearchData();
    }

    cities.value = (jsonData!['data']['cities'] as List)
        .map((json) => json['name'].toString())
        .toList();
    tabs.value = (jsonData!['data']['tabs'] as List)
        .map(
          (json) => SearchTab(
            key: json['key'].toString(),
            label: json['label'].toString(),
          ),
        )
        .toList();
    if (tabs.isNotEmpty) {
      selectedTab.value = tabs.first;
    }
  }

  Future<void> _getSearchData() async {
    final res = await _api.get('/search/options');
    if (!res.success) return;
    await SearchStorage.setData(res.data);
    jsonData = SearchStorage.getData();
  }

  Future<void> _getLocalities() async {
    final res = await _api.get(
      '/search/city-localities',
      queries: {
        'city': selectedTags.firstWhere((t) => t.type == 'city').title,
        'type': selectedTab.value!.key,
      },
    );
    if (!res.success) return;
    localities.value = (res.data['data']['localities'] as List)
        .map((json) => json['name'].toString())
        .toList();
  }

  Timer? _searchDebounce;
  Future<void> getSuggesttions() async {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 200), () async {
      final old = textController.text.trim();

      if (old.isEmpty) {
        suggestions.clear();
        return;
      }
      final city = selectedTags.firstWhereOrNull((t) => t.type == 'city');

      final res = await _api.get(
        '/search/suggestions',
        queries: {
          'q': old,
          if (city != null) ...{'city': city.title},
        },
      );
      if (old != textController.text || !res.success) return;
      final list = (res.data['data']['suggestions'] as List)
          .map((json) => SearchTag(type: json['type'], title: json['name']))
          .toList();
      if (selectedTags.isNotEmpty) {
        list.removeWhere((k) => k.type == 'city');
      }
      suggestions(list);
    });
  }

  void addTag(SearchTag tag) {
    selectedTags.insert(0, tag);
    if (selectedTags.length == 1) {
      localities.clear();
      _getLocalities();
    }
  }

  void removeTag(SearchTag tag) {
    selectedTags.removeWhere((r) => r == tag);
  }

  Future<void> refreshData() async {
    isLoading(true);
    await _getCities();
    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    textNode.requestFocus();
    jsonData = SearchStorage.getData();
    refreshData();
  }
}

class SearchStorage {
  static final _apiDataKey = 'api-data-key';

  static Future<void> setData(Map data) async {
    SharedPrefs.setString(_apiDataKey, jsonEncode(data));
  }

  static Map? getData() {
    final str = SharedPrefs.getString(_apiDataKey);
    if (str == null) return null;
    return jsonDecode(str);
  }
}

class SearchTag {
  final String title;
  final String type;
  SearchTag({required this.title, required this.type});
}

class SearchTab {
  final String key;
  final String label;
  SearchTab({required this.key, required this.label});
}
