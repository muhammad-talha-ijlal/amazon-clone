// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazonclone/const/ErrorHandler.dart';
import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/const/Snackbar.dart';
import 'package:amazonclone/model/Order.dart';
import 'package:amazonclone/model/product.dart';
import 'package:amazonclone/providers/userproviders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class home_back_services {
  // function to get category wise products
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse(
            '$uri/api/cat-product?category=$category'), // by $category the qyery will be done from database
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
      );
      HttpsError(
          response: res,
          context: context,
          onSucces: () {
            // we will get list products
            // json decode convert it into list format
            List temp = jsonDecode(res.body);
            temp.forEach((element) {
              productList.add(Product.fromJson(jsonEncode(element)));
            });
          });
    } catch (e) {
      Snackbar(context, e.toString());
    }
    return productList;
  }

// function to get searchde products
  Future<List<Product>> fetchSearchProducts(
      {required BuildContext context, required String query}) async {
    List<Product> productList = [];
    try {
      http.Response res;
      if (query == "" || query == " ") {
        res = await http.get(
          Uri.parse(
              '$uri/admin/get-product'), // by $category the qyery will be done from database
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
        );
      } else {
        res = await http.get(
          Uri.parse(
              '$uri/api/search-product/$query'), // by $category the qyery will be done from database
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
        );
      }

      HttpsError(
          response: res,
          context: context,
          onSucces: () {
            // we will get list products
            // json decode convert it into list format
            List temp = jsonDecode(res.body);
            temp.forEach((element) {
              productList.add(Product.fromJson(jsonEncode(element)));
            });
          });
    } catch (e) {
      Snackbar(context, e.toString());
    }
    return productList;
  }

// deal of the day is based on the highest rating recieved by an product
  Future<Product> fetchDealOfDay({
    required BuildContext context,
  }) async {
    Product product = Product(
        name: "",
        description: "",
        quantity: 0,
        images: [],
        category: "",
        price: 0);

    try {
      http.Response res = await http.get(
        Uri.parse(
            '$uri/api/deal-of-day'), // by $category the qyery will be done from database
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
      );

      HttpsError(
          response: res,
          context: context,
          onSucces: () {
            List prd =
                jsonDecode(res.body); // decode from the server json return
            var max = 0; // var declare
            prd.forEach((element) {
              List rtm = element["ratings"]; // get list of jsn map product
              rtm.forEach((elm) {
                // gett compare rating
                if (elm["rating"] > max) {
                  max = elm["rating"];
                  product = Product.fromMap(element);
                }
              });
            });
          });
    } catch (e) {
      Snackbar(context, e.toString());
    }
    return product;
  }

  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Order> productlist = [];

    try {
      http.Response res = await http.post(
          Uri.parse(
              '$uri/api/orders/me'), // by $category the qyery will be done from database
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body: jsonEncode({"userId": userProvider.user.id}));

      HttpsError(
          response: res,
          context: context,
          onSucces: () {
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              productlist
                  .add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      print(e.toString());
      Snackbar(context, e.toString());
    }
    return productlist;
  }
}
