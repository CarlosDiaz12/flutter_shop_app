import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/cart_item.dart';
import 'package:flutter_shop_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final String productId;
  CartItemWidget({
    Key? key,
    required this.item,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(item.id),
      onDismissed: (_) {
        var cart = Provider.of<CartProvider>(context, listen: false);
        cart.removeItem(productId);
      },
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content:
                      Text('Do you want to remove the item from the cart?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('No')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Yes'))
                  ],
                ));
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 24,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16.0),
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
      ),
      child: Card(
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
      ),
    );
  }
}
