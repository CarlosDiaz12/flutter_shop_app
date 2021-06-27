import 'package:flutter/material.dart';
import 'package:flutter_shop_app/data/dummy_products.dart';
import 'package:flutter_shop_app/models/product.dart';
import 'package:flutter_shop_app/widgets/product_item.dart';

class ProductsOverViewPage extends StatelessWidget {
  static const routeName = '/';
  final List<Product> _products = DUMMY_PRODUCTS;
  const ProductsOverViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Shopeer'),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) {
            return ProductItem(product: _products[index]);
          }),
    );
  }
}
