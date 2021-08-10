import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_item.dart';
import '../providers/products.dart';


class ProductsGrid extends StatelessWidget {
  final bool showFavorite;

  ProductsGrid(this.showFavorite);

  @override
  Widget build(BuildContext context) {
    // sets up a direct communication channel behind the scenes
    // so we do not have to pass data through layers of constructor
    final productsData = Provider.of<Products>(context);  // we are setting the listener that we only interested in Products
    final products = showFavorite ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value( // set up global state for each product
        value: products[i], // build global state for each product 
        child: ProductItem(
          // products[i].id,
          // products[i].title,
          // products[i].imageUrl,
        ),
      ),

      // control how the grid should be structre
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ), // this will define a certain amount of columns
    );
  }
}
