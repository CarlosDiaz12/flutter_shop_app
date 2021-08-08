import 'package:flutter/cupertino.dart';

import 'package:flutter_shop_app/models/cart_item.dart';

class OrdersProvider extends ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders => [..._orders];

  void addOrder(List<CartItem> cartProducts, double totalAmount) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        products: cartProducts,
        amount: totalAmount,
        orderDate: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}

class OrderItem {
  String id;
  double amount;
  List<CartItem> products;
  DateTime orderDate;
  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.orderDate,
  });
}
