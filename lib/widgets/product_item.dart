import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/cart_provider.dart';
import 'package:flutter_shop_app/providers/product.dart';
import 'package:flutter_shop_app/pages/product_detail_page.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Material(
      elevation: 8.0,
      borderRadius: BorderRadius.circular(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailPage.routeName,
                  arguments: product.id);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                color: Theme.of(context).accentColor,
                onPressed: product.toggleFavoriteStatus,
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined),
              ),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(
                    productId: product.id,
                    title: product.title,
                    price: product.price);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ),
      ),
    );
  }
}
