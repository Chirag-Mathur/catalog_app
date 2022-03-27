// To parse this JSON data, do
//
//     final itemModel = itemModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ItemModel itemModelFromMap(String str) => ItemModel.fromMap(json.decode(str));

String itemModelToMap(ItemModel data) => json.encode(data.toMap());

ItemModel returnItem(Map<String, dynamic> json) => ItemModel.fromMap(json);

class ItemModel {
  ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  int id;
  String title;
  String description;
  double price;
  String imageUrl;

  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        imageUrl: json["imageurl"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "imageurl": imageUrl,
      };
}
