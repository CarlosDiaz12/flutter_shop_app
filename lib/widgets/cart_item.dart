import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  CartItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FittedBox(child: Text('\$ ${item.price}')),
            ),
          ),
          title: Text(item.title),
          subtitle: Text('${(item.price * item.quantity)}'),
          trailing: Text('${item.quantity} x'),
        ),
      ),
    );
  }
}
