import 'package:catalog_app/models/item_model.dart';
import 'package:catalog_app/widgets/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:morphable_shape/morphable_shape.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogDetail extends StatelessWidget {
  final ItemModel item;
  const CatalogDetail({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      bottomNavigationBar: Container(
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${item.price}',
                style: Theme.of(context).textTheme.headline6,
              ),
              CartButton(item: item,),
            ],
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(item.id.toString()),
              child: Container(
                width: double.infinity,
                height: cHeight * 0.33,
                child: Image.network(item.imageUrl),
              ),
            ),
            Expanded(
              child: VxArc(
                height: 30.0,
                arcType: VxArcType.CONVEY,
                edge: VxEdge.TOP,
                child: Container(
                  color: context.cardColor,
                  width: context.screenWidth,
                  child: Column(
                    children: [
                      item.title.text.xl4
                          .color(context.accentColor)
                          .bold
                          .make(),
                      Text(
                        item.description,
                        style: context.textTheme.caption,
                      ),
                      10.heightBox,
                      Text(
                        "Dolor sea takimata ipsum sea eirmod aliquyam est. Eos ipsum voluptua eirmod elitr, no dolor dolor amet eirmod dolor labore dolores magna. Amet vero vero vero kasd, dolore sea sed sit invidunt nonumy est sit clita. Diam aliquyam amet tempor diam no aliquyam invidunt. Elitr lorem eirmod dolore clita. Rebum.",
                        style: context.textTheme.caption,
                      ),
                    ],
                  ).py64(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
