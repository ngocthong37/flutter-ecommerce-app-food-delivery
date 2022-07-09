import 'dart:convert';

import 'package:food_delivery/contants/app_contants.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({
    required this.sharedPreferences,
  });

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    cart = [];

    // convert object string bcs shareference only acp string

    cartList.forEach((element) {
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    getCartList();
  }

  List<CartModel> getCartList() {
    List<CartModel> _cartList = [];
    List<String> carts = [];

    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      // print("carts: ${carts.length}");
    }

    carts.forEach((element) {
      _cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return _cartList;
  }

  void addToCartHistoryList() {
    for (int i = 0; i < cart.length; i++) {
      print("item: ${cart[i]}");
      cartHistory.add(cart[i]);
    }
    removeCartItem();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY, cartHistory);
  }

  void removeCartItem() {
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
