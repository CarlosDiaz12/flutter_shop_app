import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/products_grid.dart';

class ProductsOverViewPage extends StatelessWidget {
  static const routeName = '/';
  const ProductsOverViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Shopeer'),
      ),
      body: ProductsGrid(),
    );
  }
}
