import 'package:catalog_app/bloc/cart_blac/carts_bloc.dart';
import 'package:catalog_app/bloc/cart_blac/carts_event.dart';
import 'package:catalog_app/bloc/cart_blac/carts_state.dart';
import 'package:catalog_app/models/cart_model.dart';
import 'package:catalog_app/models/item_model.dart';
import 'package:catalog_app/services/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartButton extends StatefulWidget {
  const CartButton({Key? key, required this.item}) : super(key: key);
  final ItemModel item;

  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  var cartBloc;
  bool isAdded = false;
  late CartModel cart;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   cartBloc = BlocProvider.of<CartsBloc>(context);
  //   cart = cartBloc.state.cart;

  //   logger.i("Inside Cart Button");
  //   logger.i(cart.items.length);

  //   if (cart.items.where((element) => element.id == widget.item.id).length >
  //       0) {
  //     setState(() {
  //       isAdded = true;
  //     });
  //   }

  //   logger.i(isAdded);

  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    cartBloc = BlocProvider.of<CartsBloc>(context);
    cart = cartBloc.state.cart;

    logger.i("Inside Cart Button");
    logger.i(cart.items.length);

    if (cart.items.where((element) => element.id == widget.item.id).length >
        0) {
      setState(() {
        isAdded = true;
      });
    } else {
      setState(() {
        isAdded = false;
      });
    }

    logger.i(isAdded);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).buttonColor,
        shape: StadiumBorder(),
      ),
      onPressed: () {
        if (!isAdded) {
          cartBloc.add(AddItemToCart(Product(
              id: widget.item.id,
              title: widget.item.title,
              quantity: 1,
              price: widget.item.price)));
          setState(() {
            isAdded = true;
          });
        }
      },
      child: BlocBuilder<CartsBloc, CartState>(
        builder: (context, state) {
          if (state is FetchingCartState) {
            return CircularProgressIndicator();
          }
          if (state is FetchedCartState) {
            if (state.cart.items
                    .where((element) => element.id == widget.item.id)
                    .length >
                0) {
              isAdded = true;
              return Text(
                'Added',
                style: TextStyle(color: Colors.white),
              );
            } else {
              isAdded = false;
              return Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white),
              );
            }
          } else {
            return Text(
              'Add to Cart',
              style: TextStyle(color: Colors.white),
            );
          }
        },
      ),
    );
  }
}
