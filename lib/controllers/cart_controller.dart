import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:get/get.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({
    required this.cartRepo,
  });

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get item => _items;

  List<CartModel> storageItem = [];

  void addItem(ProductModel product, int quantity) {
    // them vao neu chua co
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (value) {
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product);
      });
    } else {
      _items.putIfAbsent(product.id, () {
        return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product);
      });
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  // check item da co trong cart chua
  bool existCart(ProductModel product) {
    // check trong list items va so sanh voi produc id
    // product.id la unique
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  void removeProduct(int id, int index) {
    _items.remove(getItems[index].id);
    update();
  }

  void removeItem(int index) {
    var item = getItems[index];
    if (item.quantity! > 0) {
      item.quantity = item.quantity! - 1;
    }
    update();
  }

  void addNumItem(int index) {
    var item = getItems[index];
    item.quantity = item.quantity! + 1;
    update();
  }

  // lay so luong da dat co trong tung item
  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int getTotalQuantity() {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  double getTotalMoney() {
    double totalMoney = 0;
    _items.forEach((key, value) {
      if (value.quantity! > 0) {
        totalMoney += value.price! * value.quantity!;
      }
    });
    return totalMoney;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItem;
  }

  set setCart(List<CartModel> items) {
    storageItem = items;
    for (int i = 0; i < storageItem.length; i++) {
      _items.putIfAbsent(storageItem[i].product!.id, () => storageItem[i]);
    }
  }

  void saveToStorage() {
    cartRepo.addToCartList(getItems);
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    _items.clear();
    update();
  }
}
