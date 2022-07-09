import 'package:food_delivery/models/product_model.dart';

class CartModel {
  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.img,
    required this.quantity,
    required this.isExist,
    required this.time,
    required this.product
  });

  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      img: json["img"],
      quantity: json["quantity"],
      isExist: json["isExist"],
      time: json["time"],
      product: ProductModel.fromJson(json['product']));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "img": img,
        "quantity": quantity,
        "isExist": isExist,
        "time": time,
        "product": product!.toJson()
      };
}
