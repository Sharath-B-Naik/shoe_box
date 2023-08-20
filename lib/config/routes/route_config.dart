import 'package:shoe_box/all_product_page.dart';
import 'package:shoe_box/navigation_screen.dart';
import 'package:shoe_box/screens/AddProduct/add_product_page.dart';
import 'package:shoe_box/screens/Auth/auth_page.dart';
import 'package:shoe_box/screens/Home/home_page.dart';
import 'package:shoe_box/widgets/app_text.dart';
import 'package:flutter/material.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthPage.routename:
      return MaterialPageRoute(builder: (_) => const AuthPage());

    case HomePage.routename:
      return MaterialPageRoute(builder: (_) => const HomePage());

    case AddProductPage.routename:
      return MaterialPageRoute(builder: (_) => const AddProductPage());

    case NavigationPage.routename:
      return MaterialPageRoute(builder: (_) => const NavigationPage());

    case AllProductPage.routename:
      return MaterialPageRoute(builder: (_) => const AllProductPage());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Column(
              children: [
                AppText('Route name ${settings.name} is not found'),
              ],
            ),
          ),
        ),
      );
  }
}
