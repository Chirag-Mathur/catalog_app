import 'package:catalog_app/bloc/cart_blac/carts_bloc.dart';
import 'package:catalog_app/bloc/cart_blac/carts_event.dart';
import 'package:catalog_app/bloc/cart_blac/carts_state.dart';
import 'package:catalog_app/bloc/item_bloc/items_bloc.dart';
import 'package:catalog_app/bloc/item_bloc/items_event.dart';
import 'package:catalog_app/bloc/item_bloc/items_state.dart';
import 'package:catalog_app/models/cart_model.dart';
import 'package:catalog_app/models/item_model.dart';
import 'package:catalog_app/widgets/catalog_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_sreen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ItemModel> items = [];
    CartModel cart = CartModel(items: []);

    var itemsBloc = BlocProvider.of<ItemsBloc>(context);
    var cartsBloc = BlocProvider.of<CartsBloc>(context);
    itemsBloc.add(FetchAllItems());
    cartsBloc.add(FetchCart());

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      floatingActionButton: Container(
        child: FittedBox(
          child: Stack(
            alignment: Alignment(1.4, -1.5),
            children: [
              FloatingActionButton(
                // Your actual Fab
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                },
                backgroundColor: Theme.of(context).buttonColor,
                child: Icon(
                  CupertinoIcons.cart,
                  color: Colors.white,
                ),
              ),
              BlocBuilder<CartsBloc, CartState>(
                builder: (context, state) {
                  if (state is FetchingCartState) {
                    return Container(
                      // This is your Badge
                      child: Center(
                        // Here you can put whatever content you want inside your Badge
                        child: CircularProgressIndicator(),
                      ),
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(minHeight: 32, minWidth: 32),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors
                            .grey.shade200, // This would be color of the Badge
                      ),
                    );
                  }
                  if (state is FetchedCartState) {
                    return Container(
                      // This is your Badge
                      child: Center(
                        // Here you can put whatever content you want inside your Badge
                        child: Text(
                          state.cart.items.length.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(minHeight: 32, minWidth: 32),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors
                            .grey.shade200, // This would be color of the Badge
                      ),
                    );
                  }
                  return Container(
                      // This is your Badge
                      child: Center(
                        // Here you can put whatever content you want inside your Badge
                        child: Text(
                          0.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(minHeight: 32, minWidth: 32),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors
                            .grey.shade200, // This would be color of the Badge
                      ),
                    );
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          if (state is InitialItemsState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchingItemsState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchedItemsState) {
            items = state.items;
            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Catalog App',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Text(
                      "Trending Products",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return CatalogItem(
                            catalog: items[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
