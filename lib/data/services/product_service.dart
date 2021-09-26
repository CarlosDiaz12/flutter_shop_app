import 'dart:convert';
import 'dart:io';

import 'package:flutter_shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final _url = Uri.https(
      'flutter-shop-app-4c34a-default-rtdb.firebaseio.com', '/products.json');
  Future<String> addProduct(Product product) async {
    try {
      var response = await http.post(_url, body: product.toJson());
      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> id = json.decode(response.body);
        return id['name'];
      }
      return DateTime.now().toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> fetchAllProducts() async {
    try {
      var response = await http.get(_url);
      if (response.statusCode == HttpStatus.ok) {
        var jsonData = json.decode(response.body) as Map<String, dynamic>;
        return jsonData.entries
            .map(
              (e) => Product.fromMap(e.value).copyWith(id: e.key),
            )
            .toList();
      }
      throw Exception("Error Fetching Products");
    } catch (e) {
      rethrow;
    }
  }
}
