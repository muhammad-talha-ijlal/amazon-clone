// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazonclone/const/error_handl.dart';
import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/const/snackbar.dart';
import 'package:amazonclone/model/product.dart';
import 'package:amazonclone/providers/userproviders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsServices {
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
      httpsError(
          response: res,
          context: context,
          onSucces: () {
            snackbar(context, "Thank Your for Rating");
          });
    } catch (e) {
      snackbar(context, e.toString());
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
      httpsError(
          response: res,
          context: context,
          onSucces: () {
            //  stroing a neew instance of user provider
            var temp =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);

            // userProvider.user gives an instance of user stored in provider
            userProvider.setUserFrommodel(temp);
            snackbar(context, "Added to cart");
          });
    } catch (e) {
      snackbar(context, e.toString());
    }
  }

  void removeFromProduct({
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

      httpsError(
          response: res,
          context: context,
          onSucces: () {
            //  stroing a neew instance of user provider
            var temp =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);

            // userProvider.user gives an instance of user stored in provider
            userProvider.setUserFrommodel(temp);
          });
    } catch (e) {
      snackbar(context, e.toString());
    }
  }
}
