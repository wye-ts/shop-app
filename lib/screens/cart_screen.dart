import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart; // import Cart from cart.dart only
import '../widgets/cart_item.dart'; // as ci, add a prefix to the cart_item.dart to avoid naming conflix

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              // padding widget to add padding
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: TextStyle(fontSize: 20)),
                  Spacer(), // takes all the availble space
                  Chip(
                    label: Text('\$${cart.totalAmount}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                .color)),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text('ORDER NOW'),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          // expanded will get as much space it can get
          // listView along will not work here
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                // since cartItems is a map, and we are only interested in the values
                // so we do values.toList() to convert values to loopable list
                id: cartItems.values.toList()[i].id,
                title: cartItems.values.toList()[i].title,
                quantity: cartItems.values.toList()[i].quantity,
                price: cartItems.values.toList()[i].price,
              ),
            ),
          )
        ],
      ),
    );
  }
}
