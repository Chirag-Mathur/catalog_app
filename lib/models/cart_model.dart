// To parse this JSON data, do
//
//     final cartModel = cartModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CartModel cartModelFromMap(String str) => CartModel.fromMap(json.decode(str));

String cartModelToMap(CartModel data) => json.encode(data.toMap());

class CartModel {
  CartModel({
    required this.items,
  });

  List<Product> items;

  // Get total cart value
  double get totalCartValue {
    double total = 0.0;
    items.forEach((item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  factory CartModel.fromMap(Map<String, dynamic> json) => CartModel(
        items:
            List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "products": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

Product returnProduct(Map<String, dynamic> json) => Product.fromMap(json);

class Product {
  Product({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });

  int id;
  String title;
  int quantity;
  double price;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "quantity": quantity,
        "price": price,
      };
}
