import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/products_grid.dart';

enum FilterOption { Favorites, All }

class ProductsOverViewPage extends StatefulWidget {
  static const routeName = '/';
  const ProductsOverViewPage({Key? key}) : super(key: key);

  @override
  _ProductsOverViewPageState createState() => _ProductsOverViewPageState();
}

class _ProductsOverViewPageState extends State<ProductsOverViewPage> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Shopeer'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOption.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOption.All,
              )
            ],
            onSelected: (FilterOption option) {
              setState(() {
                switch (option) {
                  case FilterOption.Favorites:
                    _showOnlyFavorites = true;
                    break;
                  case FilterOption.All:
                    _showOnlyFavorites = false;
                    break;
                }
              });
            },
          ),
        ],
      ),
      body: ProductsGrid(showOnlyFavorites: _showOnlyFavorites),
    );
  }
}
