import 'package:flutter_shop_app/providers/orders_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class OrderService {
  final _url = Uri.https(
      'flutter-shop-app-4c34a-default-rtdb.firebaseio.com', '/orders.json');

  Future<String> addOrder(OrderItem orderItem) async {
    try {
      var response = await http.post(_url, body: orderItem.toJson());
      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> id = json.decode(response.body);
        return id['name'];
      }

      throw Exception("Error Saving Order");
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderItem>> fetchOrders() async {
    try {
      var response = await http.get(_url);
      if (response.statusCode == HttpStatus.ok) {
        var jsonData = json.decode(response.body) as Map<String, dynamic>;
        return jsonData.entries
            .map(
              (e) => OrderItem.fromMap(e.value).copyWith(id: e.key),
            )
            .toList();
      }
      throw Exception("Error Fetching Orders");
    } catch (e) {
      throw Exception("Error Fetching Orders");
    }
  }
}
