import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/data/dummy_products.dart';
import 'package:flutter_shop_app/providers/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = DUMMY_PRODUCTS;
  List<Product> get products => [..._products];

  void addProduct(Product newProduct) {
    _products.add(newProduct);
    notifyListeners();
  }

  Product getProductById(String productId) {
    return _products.firstWhere((p) => p.id == productId);
  }
}
