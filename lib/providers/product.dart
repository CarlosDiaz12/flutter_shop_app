import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_shop_app/data/services/product_service.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  String? creatorId;
  double price;
  String imageUrl;
  bool isFavorite;
  Product({
    this.creatorId,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
  ProductService _service = ProductService();
  Future<void> toggleFavoriteStatus(String? token, String? userId) async {
    try {
      isFavorite = !isFavorite;
      notifyListeners();
      await _service.toggleFavorite(id, isFavorite, token, userId);
    } catch (e) {
      isFavorite = !isFavorite;
      notifyListeners();
      rethrow;
    }
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavorite,
    String? creatorId,
  }) {
    return Product(
      creatorId: creatorId ?? this.creatorId,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'title': title,
      'description': description,
      'price': price.toString(),
      'imageUrl': imageUrl,
      'creatorId': creatorId,
      //'isFavorite': isFavorite.toString(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      creatorId: map['creatorId'],
      id: "",
      title: map['title'],
      description: map['description'],
      price: map['price'] != null ? double.parse(map['price']) : 0.0,
      imageUrl: map['imageUrl'],
      //isFavorite: map['isFavorite'].toString().toLowerCase() == 'true',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, price: $price, imageUrl: $imageUrl, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        isFavorite.hashCode;
  }
}
