import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:flutter_shop_app/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

import 'edit_product_page.dart';

class UserProductsPage extends StatelessWidget {
  static const routeName = '/user-products-page';
  const UserProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductPage.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, productsData, _) => RefreshIndicator(
          onRefresh: () => productsData.fetchProducts(true),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView.separated(
              separatorBuilder: (_, index) => Divider(),
              itemCount: productsData.products.length,
              itemBuilder: (_, index) => UserProductItem(
                id: productsData.products[index].id,
                title: productsData.products[index].title,
                imageUrl: productsData.products[index].imageUrl,
                onDelete: (id) async {
                  try {
                    productsData.deleteProduct(id);
                  } catch (e) {
                    final snackBar = SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Theme.of(context).colorScheme.error);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
