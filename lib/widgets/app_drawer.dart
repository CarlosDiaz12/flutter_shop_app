import 'package:flutter/material.dart';
import 'package:flutter_shop_app/pages/orders_page.dart';
import 'package:flutter_shop_app/pages/products_overview_page.dart';
import 'package:flutter_shop_app/pages/user_products_page.dart';
import 'package:flutter_shop_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hi Mortal!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverViewPage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersPage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsPage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log Out'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logOut();
              //Navigator.of(context).pushReplacementNamed(AuthPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
