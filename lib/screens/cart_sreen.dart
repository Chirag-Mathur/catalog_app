import 'package:catalog_app/bloc/cart_blac/carts_bloc.dart';
import 'package:catalog_app/bloc/cart_blac/carts_event.dart';
import 'package:catalog_app/bloc/cart_blac/carts_state.dart';
import 'package:catalog_app/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartBloc = BlocProvider.of<CartsBloc>(context);
    cartBloc.add(FetchCart());
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: BlocBuilder<CartsBloc, CartState>(
        builder: (context, state) {
          if (state is FetchingCartState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is FetchedCartState) {
            return state.cart.items.length > 0
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.cart.items.length,
                          itemBuilder: (context, index) {
                            final item = state.cart.items[index];
                            return CartItem(cartItem: item);
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total: \$ ${state.cart.totalCartValue}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            ElevatedButton(
                              child: Text('Checkout'),
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).buttonColor,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text('Checkout is not implemented yet'),
                                ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text('Cart is empty'),
                  );
          } else {
            return Center(
              child: Text('No Items in Cart'),
            );
          }
        },
      ),
    );
  }
}
