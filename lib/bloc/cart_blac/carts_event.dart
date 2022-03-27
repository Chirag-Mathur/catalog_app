import 'package:catalog_app/models/item_model.dart';
import 'package:logger/logger.dart';

import '../../models/cart_model.dart';

abstract class CartEvent {}

class AddItemToCart extends CartEvent {
  final Product item;
  
  AddItemToCart(this.item);
  
}

class DeleteItemFromCart extends CartEvent {
  final Product item;
  DeleteItemFromCart(this.item);
}

class FetchCart extends CartEvent {
  FetchCart();
}
