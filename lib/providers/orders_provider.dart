import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_shop_app/data/services/order_service.dart';

import 'package:flutter_shop_app/models/cart_item.dart';

class OrdersProvider extends ChangeNotifier {
  OrderService _service = OrderService();
  List<OrderItem> _orders = [];
  List<OrderItem> get orders => [..._orders];
  String? authToken;
  String? userId;
  OrdersProvider({
    this.authToken,
    this.userId,
    List<OrderItem> orders = const [],
  }) : _orders = orders;
  Future<void> addOrder(List<CartItem> cartProducts, double totalAmount) async {
    var order = OrderItem(
      id: '',
      products: cartProducts,
      amount: totalAmount,
      orderDate: DateTime.now(),
    );
    var response = await _service.addOrder(order, authToken, userId);
    order.copyWith(id: response);
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    var response = await _service.fetchOrders(authToken, userId);
    _orders = response.reversed.toList();
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

  OrderItem copyWith({
    String? id,
    double? amount,
    List<CartItem>? products,
    DateTime? orderDate,
  }) {
    return OrderItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'amount': amount.toString(),
      'products': products.map((x) => x.toMap()).toList(),
      'orderDate': orderDate.toIso8601String(),
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: '',
      amount: double.parse(map['amount']),
      products:
          List<CartItem>.from(map['products']?.map((x) => CartItem.fromMap(x))),
      orderDate: DateTime.parse(map['orderDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderItem(id: $id, amount: $amount, products: $products, orderDate: $orderDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderItem &&
        other.id == id &&
        other.amount == amount &&
        listEquals(other.products, products) &&
        other.orderDate == orderDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        products.hashCode ^
        orderDate.hashCode;
  }
}
