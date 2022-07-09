import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import 'package:food_delivery/data/repository/recommeded_product_repo.dart';

class RecommendedProductController extends GetxController {
  final RecommededProductRepo recommededProductRepo;
  RecommendedProductController({
    required this.recommededProductRepo,
  });

  List<dynamic> _recommededProductList = [];
  List<dynamic> get recommedProductList => _recommededProductList;

  int _quantity = 1;
  int get quantity => _quantity;

  late CartController _cart;

  Future<void> getRecommendedProductList() async {
    Response response = await recommededProductRepo.getRecommededProductList();
    if (response.statusCode == 200) {
      _recommededProductList = [];
      _recommededProductList
          .addAll(Product.fromJson(response.body).products);
      update();
    } else {
      print("loi");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      if (_quantity == 20) {
        Get.snackbar('Item count', "You can't add more",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      } else {
        _quantity = _quantity + 1;
      }
    } else {
      if (_quantity == 0) {
        Get.snackbar('Item count', "You can't reduce more",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      } else if (_quantity > 0) {
        _quantity = _quantity - 1;
      }
    }
    update();
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 1;
    _cart = cart;
  }

  int get totalQuantity => _cart.getTotalQuantity();

  void addItem(ProductModel product) {
    if (_quantity > 0) {
      _cart.addItem(product, quantity);
      Get.snackbar('Success', "The product has been added to cart",
          backgroundColor: Colors.grey, colorText: Colors.white);
    } else if (_quantity == 0) {
      Get.snackbar('Failed', "You should add at least one item",
          backgroundColor: Colors.red[50], colorText: Colors.black);
    }
    update();
  }
}
