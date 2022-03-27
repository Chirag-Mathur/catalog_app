import 'package:catalog_app/models/item_model.dart';
import 'package:catalog_app/repository/api_repository.dart';
import 'package:catalog_app/services/api_handling.dart';
import 'package:catalog_app/services/logger.dart';

import '../../models/cart_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'carts_event.dart';
import 'carts_state.dart';

class CartsBloc extends Bloc<CartEvent, CartState> {
  final ApiRepository apiRepository;

  CartsBloc(this.apiRepository) : super(InitialCartState()) {
    on<AddItemToCart>((event, emit) async {
      CartModel cart = await apiRepository.fetchCart();
      logger.d("Adding Item Bloc");
      logger.i(event.item.id);

      // logger.i("Items-->", cart == null);
      if (cart.items.where((element) => element.id == event.item.id).length ==
          0) {
        cart.items.add(event.item);
        await apiRepository.updateCart(cart);
      } else {
        cart.items
            .firstWhere((element) => element.id == event.item.id)
            .quantity++;
        await apiRepository.updateCart(cart);
      }

      logger.i(cart.items.length);

      cart = await apiRepository.fetchCart();

      emit(FetchedCartState(cart));
    });

    on<DeleteItemFromCart>((event, emit) async {
      CartModel cart = await apiRepository.fetchCart();
      // cart.items.removeWhere((item) => item.id == event.item.id);
      // cart = await apiRepository.updateCart(cart);

      if (cart.items.firstWhere((element) => element.id == event.item.id) !=
          null) {
        cart.items
            .firstWhere((element) => element.id == event.item.id)
            .quantity--;
        if (cart.items
                .firstWhere((element) => element.id == event.item.id)
                .quantity ==
            0) {
          cart.items.removeWhere((element) => element.id == event.item.id);
        }
        await apiRepository.updateCart(cart);
      } else {
        cart.items.removeWhere((element) => element.id == event.item.id);
        await apiRepository.updateCart(cart);
      }

      cart = await apiRepository.fetchCart();

      emit(FetchedCartState(cart));
    });

    on<FetchCart>((event, emit) async {
      emit(FetchingCartState());
      CartModel cart = await apiRepository.fetchCart();
      emit(FetchedCartState(cart));
    });
  }
}
