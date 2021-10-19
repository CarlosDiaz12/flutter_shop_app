import 'dart:convert';
import 'dart:io';

import 'package:flutter_shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final _url = Uri.https(
      'flutter-shop-app-4c34a-default-rtdb.firebaseio.com', '/products.json');
  Future<String> addProduct(Product product, String? token) async {
    try {
      var response = await http.post(
          _url.replace(queryParameters: {
            'auth': token,
          }),
          body: product.toJson());
      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> id = json.decode(response.body);
        return id['name'];
      }
      return DateTime.now().toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> fetchAllProducts(String? token, String? userId,
      [bool filter = false]) async {
    try {
      var _params = {
        'auth': token,
      };

      var filterParams = {
        'orderBy': '"creatorId"',
        'equalTo': '"$userId"',
      };
      if (filter) {
        _params.addAll(filterParams);
      }

      var editedUrl = _url.replace(queryParameters: _params);
      var response = await http.get(editedUrl);
      if (response.statusCode == HttpStatus.ok) {
        var jsonData = json.decode(response.body) as Map<String, dynamic>?;
        if (jsonData == null) return [];
        var favoriteData = {};
        var favoriteResponse = await http.get(
            _url.replace(path: '/userFavorites/$userId.json', queryParameters: {
          'auth': token,
        }));

        if (favoriteResponse.statusCode == HttpStatus.ok) {
          favoriteData =
              json.decode(favoriteResponse.body) as Map<String, dynamic>;
        }
        return jsonData.entries
            .map(
              (e) => Product.fromMap(e.value).copyWith(
                id: e.key,
                isFavorite: favoriteData.containsKey(e.key)
                    ? favoriteData[e.key]
                    : false,
              ),
            )
            .toList();
      }
      throw Exception("Error Fetching Products");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(Product product, String? token) async {
    try {
      var response = await http.patch(
          _url.replace(path: '/products/${product.id}.json', queryParameters: {
            'auth': token,
          }),
          body: product.toJson());
      if (response.statusCode != HttpStatus.ok) {
        throw Exception("Error Updating Product");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(String id, String? token) async {
    try {
      var response = await http.delete(
        _url.replace(path: '/products/$id.json', queryParameters: {
          'auth': token,
        }),
      );
      if (response.statusCode != HttpStatus.ok) {
        throw Exception("Error Deleting Product");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleFavorite(
      String id, bool value, String? token, String? userId) async {
    try {
      var response = await http.put(
          _url.replace(
              path: '/userFavorites/$userId/$id.json',
              queryParameters: {
                'auth': token,
              }),
          body: json.encode(
            value,
          ));
      if (response.statusCode != HttpStatus.ok) {
        throw Exception("Error Updating Product");
      }
    } catch (e) {
      rethrow;
    }
  }
}
