import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = '/orders-page';
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Orders'),
      ),
      body: Center(
        child: Text('My orders page'),
      ),
    );
  }
}
