import 'package:flutter/material.dart';
import 'package:flutter_shop_app/helpers/custom_route.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.deepOrange,
    fontFamily: 'Lato',
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
      },
    ),
  );
}
