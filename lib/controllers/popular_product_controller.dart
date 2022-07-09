import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import 'package:food_delivery/data/repository/popular_product_repo.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo productRepo;
  PopularProductController({
    required this.productRepo,
  });

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  late CartController _cart;

  bool isLoaded = false;

  int _quantity = 1;
  int get quantity => _quantity;

  int _inCartItem = 0;
  int get inCartItem => _cart.getTotalQuantity();

  Future<void> getPopularProductList() async {
    Response response = await productRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      // tell to UI
      isLoaded = true;
      update();
    } else {
      print("Error ${response.statusCode}");
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
    _inCartItem = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existCart(product);
    print(exist);
    if (exist) {
      _inCartItem = _cart.getQuantity(product);
      print('id ${product.id} with $_inCartItem');
    }
  }

  int get totalQuantity => _cart.getTotalQuantity();

  void addItem(ProductModel product) {
    if (_quantity > 0) {
      _inCartItem = _inCartItem + _quantity;

      _cart.addItem(product, _quantity);
      Get.snackbar('Success', "The product has been added to cart",
          backgroundColor: Colors.grey, colorText: Colors.white);
    } else {
      Get.snackbar('Item count', "You must select at least one item",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
    update();
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
