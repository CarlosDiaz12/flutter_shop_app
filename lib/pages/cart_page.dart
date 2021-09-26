import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/cart_provider.dart';
import 'package:flutter_shop_app/providers/orders_provider.dart';
import 'package:flutter_shop_app/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart-page';
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      label: Text(
                        '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  _OrderButton(
                    cart: cart,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (ctx, index) => CartItemWidget(
                item: cart.cartItems.values.toList()[index],
                productId: cart.cartItems.keys.toList()[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _OrderButton extends StatefulWidget {
  final CartProvider cart;
  const _OrderButton({Key? key, required this.cart}) : super(key: key);

  @override
  State<_OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<_OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: (widget.cart.cartItems.length <= 0 || _isLoading)
          ? null
          : () async {
              try {
                setState(() {
                  _isLoading = true;
                });
                var orders =
                    Provider.of<OrdersProvider>(context, listen: false);
                await orders.addOrder(
                  widget.cart.cartItems.values.toList(),
                  widget.cart.totalAmount,
                );
                widget.cart.clearCart();
                setState(() {
                  _isLoading = false;
                });
              } catch (e) {
                setState(() {
                  _isLoading = false;
                });
                final snackBar = SnackBar(
                    content: Text(e.toString()),
                    backgroundColor: Theme.of(context).colorScheme.error);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
      child: Text('ORDER NOW'),
    );
  }
}
