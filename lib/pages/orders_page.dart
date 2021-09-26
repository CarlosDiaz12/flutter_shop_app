import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/orders_provider.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:flutter_shop_app/widgets/order_item_widget.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  static const routeName = '/orders-page';
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('My Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: Provider.of<OrdersProvider>(context, listen: false)
                .fetchOrders(),
            builder: (ctx, AsyncSnapshot data) {
              if (data.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.hasError) {
                return MaterialBanner(
                  content: Text(
                    data.error.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.error,
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        'Retry',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {});
                      },
                    )
                  ],
                );
              }
              return Consumer<OrdersProvider>(
                builder: (ctx, order, _) => ListView.builder(
                  itemCount: order.orders.length,
                  itemBuilder: (ctx, index) => OrderItemWidget(
                    item: order.orders[index],
                  ),
                ),
              );
            }));
  }
}
