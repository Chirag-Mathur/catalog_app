import 'package:catalog_app/models/item_model.dart';

import '../../models/cart_model.dart';

abstract class CartState {}

class InitialCartState extends CartState {
  InitialCartState();
}

class FetchingCartState extends CartState {
  FetchingCartState();
}

class FetchedCartState extends CartState {
  final CartModel cart;
  FetchedCartState(this.cart);
}