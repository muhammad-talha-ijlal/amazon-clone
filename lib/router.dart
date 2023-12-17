import 'package:amazonclone/model/Order.dart';
import 'package:amazonclone/model/Product.dart';
import 'package:amazonclone/pages/AddProduct.dart';
import 'package:amazonclone/pages/Address.dart';
import 'package:amazonclone/pages/AuthPage.dart';
import 'package:amazonclone/pages/Category.dart';
import 'package:amazonclone/pages/Home.dart';
import 'package:amazonclone/pages/OrderDetail.dart';
import 'package:amazonclone/pages/ProductPage.dart';
import 'package:amazonclone/pages/SearchedProduct.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings rs) {
  switch (rs.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: rs, builder: (_) => const AuthScreen());

    case Home.routeName:
      return MaterialPageRoute(settings: rs, builder: (_) => const Home());

    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: rs, builder: (_) => const AddProductScreen());

    case CategoryScreen.routeName:
      var category = rs.arguments
          as String; // argument which will be given to the CategoryScreen()
      return MaterialPageRoute(
          settings: rs, builder: (_) => CategoryScreen(category: category));

    case SearchedScreen.routeName:
      var searchQuery = rs.arguments
          as String; // argument which will be given to the SearchScreen()
      return MaterialPageRoute(
          settings: rs,
          builder: (_) => SearchedScreen(searchquery: searchQuery));
    case ProductDetailScreen.routeName:
      var product = rs.arguments
          as Product; // argument which will be given to the SearchScreen()
      return MaterialPageRoute(
          settings: rs, builder: (_) => ProductDetailScreen(product: product));

    case AddressScreen.routeName:
      var ispay = rs.arguments as bool;
      return MaterialPageRoute(
          settings: rs,
          builder: (_) => AddressScreen(
                isPay: ispay,
              ));
    case OrderDetails.routeName:
      var order = rs.arguments as Order;
      return MaterialPageRoute(
          settings: rs, builder: (_) => OrderDetails(order: order));
    default:
      return MaterialPageRoute(
          settings: rs,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen does not exist '),
                ),
              ));
  }
}
