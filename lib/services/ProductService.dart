// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazonclone/const/ErrorHandler.dart';
import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/const/Snackbar.dart';
import 'package:amazonclone/model/Product.dart';
import 'package:amazonclone/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductService {
  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating,
      required user}) async {
    try {
      http.Response res = await http.post(
          Uri.parse(
              '$uri/api/rate-product'), // by $category the qyery will be done from database
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body:
              jsonEncode({'id': product.id, 'rating': rating, 'userId': user}));
      HttpsError(
          response: res,
          context: context,
          onSucces: () {
            Snackbar(context, "Thank Your for Rating");
          });
    } catch (e) {
      Snackbar(context, e.toString());
    }
  }

  void addCart({
    required BuildContext context,
    required Product product,
  }) async {
    try {
      // gives isntance of userProver.user
      // to change userProvider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
          Uri.parse(
              '$uri/user/add-to-cart'), // api need user_id and id of product
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body:
              jsonEncode({'id': product.id, 'user_id': userProvider.user.id}));
      HttpsError(
          response: res,
          context: context,
          onSucces: () {
            //  stroing a neew instance of user provider
            var temp =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);

            // userProvider.user gives an instance of user stored in provider
            userProvider.setUserFromModel(temp);
            Snackbar(context, "Added to cart");
          });
    } catch (e) {
      Snackbar(context, e.toString());
    }
  }

  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    try {
      // gives isntance of userProver.user
      // to change userProvider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.delete(
          Uri.parse(
              '$uri/user/remove-from-cart'), // api need user_id and id of product
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body:
              jsonEncode({'id': product.id, 'user_id': userProvider.user.id}));

      HttpsError(
          response: res,
          context: context,
          onSucces: () {
            //  stroing a neew instance of user provider
            var temp =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);

            // userProvider.user gives an instance of user stored in provider
            userProvider.setUserFromModel(temp);
          });
    } catch (e) {
      Snackbar(context, e.toString());
    }
  }
}
