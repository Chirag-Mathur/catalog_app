import 'package:catalog_app/bloc/cart_blac/carts_event.dart';
import 'package:catalog_app/models/cart_model.dart';
import 'package:catalog_app/services/api_handling.dart';

import '../repository/api_repository.dart';

class ApiRepository{

  ApiHandling _apiHandling = ApiHandling();

  getAllitems(){
    return _apiHandling.fetchItems();
  }

  fetchCart(){
    return _apiHandling.fetchCart();
  }

  updateCart(CartModel cart){
    return _apiHandling.updateCart(cart);
  }

}