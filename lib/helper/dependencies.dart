import 'package:food_delivery/contants/app_contants.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/data/repository/recommeded_product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cart_controller.dart';
import '../data/repository/cart_repo.dart';

Future<void> init() async {
  // sharePreference
  final sharedPreferences = await SharedPreferences.getInstance();

  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl));
  Get.lazyPut(() => sharedPreferences);

  // repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommededProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  // controller
  Get.lazyPut(() => PopularProductController(productRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommededProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
