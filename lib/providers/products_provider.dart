import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/data/dummy_products.dart';
import 'package:flutter_shop_app/data/services/product_service.dart';
import 'package:flutter_shop_app/providers/product.dart';

class ProductsProvider with ChangeNotifier {
  ProductService _service = ProductService();
  List<Product> _products = DUMMY_PRODUCTS;
  List<Product> get products => [..._products];
  List<Product> get favoritesItems =>
      _products.where((p) => p.isFavorite).toList();

  void addProduct(Product newProduct) async {
    var res = await _service.addProduct(newProduct);
    final _newProduct = newProduct.copyWith(id: res);
    _products.add(_newProduct);
    notifyListeners();
  }

  Product getProductById(String productId) {
    return _products.firstWhere((p) => p.id == productId);
  }

  void updateProduct(String id, Product product) {
    var index = _products.indexWhere((element) => element.id == id);
    if (index >= 0) {
      _products[index] = product;
    }
    notifyListeners();
  }

  void deleteProduct(String id) {
    _products.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
