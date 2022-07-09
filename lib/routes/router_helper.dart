import 'package:food_delivery/screens/check_out/check_out.dart';
import 'package:food_delivery/screens/food/popular_food_detail.dart';
import 'package:food_delivery/screens/food/recommended_food_detail.dart';
import 'package:food_delivery/screens/home/home_page.dart';
import 'package:food_delivery/screens/splash_page/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splash = '/splash';
  static const String initial = '/';
  static const popularFood = '/popular_food';
  static const recommendedDetail = '/recommeded_food_detail';
  static const checkOut = '/check_out';

  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getInitial() => initial;
  static String getRecommededFood(int pageId, String page) =>
      '$recommendedDetail?pageId=$pageId&page=$page';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedDetail,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetai(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: checkOut,
        page: () {
          return CheckOutPage();
        })
  ];
}
