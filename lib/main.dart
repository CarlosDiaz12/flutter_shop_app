import 'package:flutter/material.dart';
import 'package:flutter_shop_app/config/app_theme.dart';
import 'package:flutter_shop_app/pages/cart_page.dart';
import 'package:flutter_shop_app/pages/orders_page.dart';
import 'package:flutter_shop_app/pages/product_detail_page.dart';
import 'package:flutter_shop_app/pages/products_overview_page.dart';
import 'package:flutter_shop_app/providers/cart_provider.dart';
import 'package:flutter_shop_app/providers/orders_provider.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: AppTheme.theme,
        home: ProductsOverViewPage(),
        initialRoute: ProductsOverViewPage.routeName,
        routes: {
          ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
          CartPage.routeName: (ctx) => CartPage(),
          OrdersPage.routeName: (ctx) => OrdersPage(),
        },
      ),
    );
  }
}
