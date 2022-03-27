import 'package:catalog_app/bloc/cart_blac/carts_bloc.dart';
import 'package:catalog_app/bloc/cart_blac/carts_event.dart';
import 'package:catalog_app/models/item_model.dart';
import 'package:catalog_app/screens/catalog_detail.dart';
import 'package:catalog_app/widgets/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogItem extends StatelessWidget {
  CatalogItem({Key? key, required this.catalog}) : super(key: key);
  final ItemModel catalog;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CatalogDetail(item: catalog);
            },
          ),
        );
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Hero(
                tag: Key(catalog.id.toString()),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(catalog.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      catalog.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      catalog.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${catalog.price}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        CartButton(item: catalog,),
                      ],
                    )
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
