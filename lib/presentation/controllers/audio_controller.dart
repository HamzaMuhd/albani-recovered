import 'dart:convert';
import 'package:albani/core/configs/constants/appkey.dart';
import 'package:albani/data/models/subcategories_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:albani/core/configs/constants/app_urls.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AudioController extends GetxController {
  final storage = GetStorage();

  final loadingCategories = <int>{}.obs;
  final subcategoriesByCategory = <int, List<Subcategory>>{}.obs;
  final failedCategoryIds = <int>{}.obs;
  final noInternet = false.obs;
  final selectedSubcategoryId = <int, int?>{}.obs;
  final RxInt currentTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    // Monitor network and retry
    Connectivity().onConnectivityChanged.listen((status) async {
      if (status != ConnectivityResult.none) {
        noInternet.value = false;
        for (final id in failedCategoryIds.toList()) {
          await loadSubcategories(id);
        }
      } else {
        noInternet.value = true;
      }
    });
  }

  void selectSubcategory(int categoryId, int subcategoryId) {
    selectedSubcategoryId[categoryId] = subcategoryId;
  }

  Future<void> loadSubcategories(int categoryId) async {
    final key = 'subcategories_$categoryId';
    final cached = storage.read(key);
    final hasConnection = await _hasInternet();

    loadingCategories.add(categoryId);
    failedCategoryIds.remove(categoryId);

    try {
      if (hasConnection) {
        final res = await http.get(
          Uri.parse('${AppUrls.getSubUrl}$categoryId'),
          headers: {
            "Content-Type": "application/json",
            "x-api-key": AppStrings.apiKey,
          },
        );

        if (res.statusCode == 200) {
          final List jsonData = json.decode(res.body);
          final result = jsonData.map((e) => Subcategory.fromJson(e)).toList();
          subcategoriesByCategory[categoryId] = result;
          storage.write(key, res.body);
        } else {
          _loadFallback(categoryId, cached);
        }
      } else {
        noInternet.value = true;
        failedCategoryIds.add(categoryId);
        _loadFallback(categoryId, cached);
      }
    } catch (_) {
      failedCategoryIds.add(categoryId);
      _loadFallback(categoryId, cached);
    } finally {
      loadingCategories.remove(categoryId);
    }
  }

  void _loadFallback(int categoryId, String? data) {
    if (data != null) {
      final List jsonData = json.decode(data);
      final List<Subcategory> result =
          jsonData.map((e) => Subcategory.fromJson(e)).toList();
      subcategoriesByCategory[categoryId] = result;
    } else {
      subcategoriesByCategory[categoryId] = [];
    }
  }

  Future<bool> _hasInternet() async {
    try {
      final res = await http.get(Uri.parse('https://www.google.com'));
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
