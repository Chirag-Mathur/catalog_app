import 'dart:convert';
import 'dart:ffi';

import 'package:catalog_app/models/cart_model.dart';
import 'package:catalog_app/services/logger.dart';

import '../models/item_model.dart';
import 'package:dio/dio.dart';

class ApiHandling {
  static const String url =
      "https://apni-dukaan-405bb-default-rtdb.firebaseio.com/";

  Future<List<ItemModel>> fetchItems() async {
    logger.d("Fetching Items");
    List<ItemModel> items = [];
    try {
      Response<String> response = await Dio().get(url + "products.json");

      final parsed = json.decode(response.data ?? "") as Map<String, dynamic>;

      logger.i(parsed);

      parsed.forEach((key, value) {
        // logger.i(value);
        items.add(returnItem(value));
      });

      return items;
    } catch (e) {
      print(e);
      return items;
    }
  }

  Future<CartModel> fetchCart() async {
    logger.d("Fetching Cart");
    CartModel cart = CartModel(items: []);
    try {
      Response<String> response = await Dio().get(url + "cart.json");
      logger.d(response);
      logger.i(response.data);
      logger.i(response.statusMessage);

      final parsed = json.decode(response.data ?? "") as Map<String, dynamic>;

      logger.d(parsed);

      // parsed.forEach((key, value) {
      //   logger.d(key);
      //   logger.i(value);
      //   cart.items.add(returnItem(value));
      // });
      parsed["products"].forEach((items) {
        cart.items.add(returnProduct(items));
      });

      logger.d(cart.items.length);

      return cart;
    } catch (e) {
      print(e);
      return cart;
    }
  }

  Future<void> updateCart(CartModel cartModel) async {
    logger.d("Adding Item to Cart");
    try {
      Response<String> response = await Dio().patch(
        url + "cart.json",
        data: cartModelToMap(cartModel),
      );
      logger.d(response);
      logger.i(response.data);
      logger.i(response.statusMessage);
    } catch (e) {
      print(e);
    }
    return;
  }
}
