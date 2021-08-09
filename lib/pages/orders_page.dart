import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/orders_provider.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:flutter_shop_app/widgets/order_item_widget.dart';
import 'package:provider/provider.dart';

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
      drawer: AppDrawer(),
      body: Consumer<OrdersProvider>(
        builder: (ctx, order, _) => ListView.builder(
          itemCount: order.orders.length,
          itemBuilder: (ctx, index) => OrderItemWidget(
            item: order.orders[index],
          ),
        ),
      ),
    );
  }
}
