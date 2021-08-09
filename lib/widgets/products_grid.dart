import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavorites;
  const ProductsGrid({
    Key? key,
    required this.showOnlyFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(builder: (ctx, provider, _) {
      var products =
          showOnlyFavorites ? provider.favoritesItems : provider.products;
      return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
              value: products[index],
              child: ProductItem(),
            );
          });
    });
  }
}
