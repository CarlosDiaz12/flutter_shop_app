import 'package:flutter/material.dart';
import 'package:flutter_shop_app/config/app_theme.dart';
import 'package:flutter_shop_app/pages/product_detail_page.dart';
import 'package:flutter_shop_app/pages/products_overview_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      theme: AppTheme.theme,
      home: ProductsOverViewPage(),
      initialRoute: ProductsOverViewPage.routeName,
      routes: {ProductDetailPage.routeName: (ctx) => ProductDetailPage()},
    );
  }
}
