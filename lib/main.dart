import 'package:flutter/material.dart';
import 'package:flutter_shop_app/config/app_theme.dart';
import 'package:flutter_shop_app/pages/auth_page.dart';
import 'package:flutter_shop_app/pages/cart_page.dart';
import 'package:flutter_shop_app/pages/edit_product_page.dart';
import 'package:flutter_shop_app/pages/orders_page.dart';
import 'package:flutter_shop_app/pages/product_detail_page.dart';
import 'package:flutter_shop_app/pages/products_overview_page.dart';
import 'package:flutter_shop_app/pages/splash_screen.dart';
import 'package:flutter_shop_app/pages/user_products_page.dart';
import 'package:flutter_shop_app/providers/auth_provider.dart';
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
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          update: (ctx, data, previousProvider) => ProductsProvider(
            authToken: data.token,
            userId: data.userId,
            products: previousProvider?.products ?? [],
          ),
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProxyProvider<Auth, OrdersProvider>(
          update: (ctx, data, previousProvider) => OrdersProvider(
            authToken: data.token,
            userId: data.userId,
            orders: previousProvider?.orders ?? [],
          ),
          create: (ctx) => OrdersProvider(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop App',
          theme: AppTheme.theme,
          home: authData.isLoggedIn
              ? ProductsOverViewPage()
              : FutureBuilder(
                  future: authData.tryAutoLoging(),
                  builder: (ctx, authResult) =>
                      authResult.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthPage(),
                ),
          // initialRoute: authData.isLoggedIn
          //     ? ProductsOverViewPage.routeName
          //     : AuthPage.routeName,
          routes: {
            ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
            CartPage.routeName: (ctx) => CartPage(),
            OrdersPage.routeName: (ctx) => OrdersPage(),
            UserProductsPage.routeName: (ctx) => UserProductsPage(),
            EditProductPage.routeName: (ctx) => EditProductPage(),
            AuthPage.routeName: (ctx) => AuthPage(),
            // ProductsOverViewPage.routeName: (ctx) => ProductsOverViewPage(),
          },
        ),
      ),
    );
  }
}
