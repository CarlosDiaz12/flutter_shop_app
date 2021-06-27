import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<ProductsProvider>(context);
    //final products = productsData.products;
    return Consumer<ProductsProvider>(builder: (ctx, provider, _) {
      return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: provider.products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) {
            return ProductItem(product: provider.products[index]);
          });
    });
  }
}
