import 'package:food_delivery/contants/app_contants.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:get/get.dart';

class RecommededProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommededProductRepo({required this.apiClient});

  Future<Response> getRecommededProductList() async {
    return await apiClient.getData(AppConstants.RECOMMEND_PRODUCT_URI);
  }
}
