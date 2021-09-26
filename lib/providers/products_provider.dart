import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/data/services/product_service.dart';
import 'package:flutter_shop_app/providers/product.dart';

class ProductsProvider with ChangeNotifier {
  ProductService _service = ProductService();
  List<Product> _products = [];
  List<Product> get products => [..._products];
  List<Product> get favoritesItems =>
      _products.where((p) => p.isFavorite).toList();

  Future<void> addProduct(Product newProduct) async {
    var res = await _service.addProduct(newProduct);
    final _newProduct = newProduct.copyWith(id: res);
    _products.add(_newProduct);
    notifyListeners();
  }

  Product getProductById(String productId) {
    return _products.firstWhere((p) => p.id == productId);
  }

  Future<void> fetchProducts() async {
    var response = await _service.fetchAllProducts();
    _products = response;
    notifyListeners();
  }

  Future<void> updateProduct(String id, Product product) async {
    var index = _products.indexWhere((element) => element.id == id);
    if (index >= 0) {
      product.copyWith(id: id);
      _products[index] = product;
      await _service.updateProduct(product);
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    await _service.deleteProduct(id);
    _products.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
