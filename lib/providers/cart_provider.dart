import 'package:flutter/cupertino.dart';
import 'package:flutter_shop_app/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};
  Map<String, CartItem> get cartItems => {..._cartItems};

  int get itemCount {
    return _cartItems.length;
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItem(
      {required String productId,
      required String title,
      required double price}) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (cartItem) => CartItem(
            id: cartItem.id,
            title: cartItem.title,
            quantity: cartItem.quantity + 1,
            price: cartItem.price),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            quantity: 1,
            price: price),
      );
    }
    notifyListeners();
  }
}
