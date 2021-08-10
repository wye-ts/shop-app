import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      // wrap the child with a certain shape
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            // Navigator push will create a screen on the fly
            // better switch to route because it is easier to
            // understand
            // another downside of this is that we cannot pass
            // somthing we do not have to the constrcutor ex: price
            // since price is not available in this scope
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (ctx) => ProductDetailScreen(title)),
            // );

            // we only forward the id as an argument so we can fetch data on that widget
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          // leading: IconButton(
          //   icon: Icon(Icons.favorite),
          //   onPressed: () {},
          //   color: Theme.of(context).accentColor,
          // ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: Row(children: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
              },
              color: Theme.of(context).accentColor,
            ),
            IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
              color: Theme.of(context).accentColor,
            ),
          ]),
        ),
      ),
    );
  }
}
