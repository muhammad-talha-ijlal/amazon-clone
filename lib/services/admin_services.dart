// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:amazonclone/const/ErrorHandler.dart';
import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/const/Snackbar.dart';
import 'package:amazonclone/model/Order.dart';
import 'package:amazonclone/model/product.dart';
import 'package:amazonclone/model/Sales.dart';
import 'package:amazonclone/providers/userproviders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class adminServices {
  void sellproduct(
      {required BuildContext context, // to show errors
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    final _firebaseStorage = FirebaseStorage.instance;
    List<String> imageUrl = [];
    for (var i = 0; i < images.length; i++) {
      File file = File(images[i].path);
      String imageName = 'image_$i';
      TaskSnapshot uploadTask = await _firebaseStorage
          .ref()
          .child('images/$name/$imageName')
          .putFile(file);
      String downloadUrl = await uploadTask.ref.getDownloadURL();
      imageUrl.add(downloadUrl);
    }

    try {
      // final cloudinary = CloudinaryPublic("dhbyfjouq",
      //     "nc3gdx5y"); // it creates a cloud link to store iamges at cloudinary
      // List<String> imageUrl = [];
      // for (var i = 0; i < images.length; i++) {
      //   CloudinaryResponse res = await cloudinary.uploadFile(
      //       CloudinaryFile.fromFile(images[i].path,
      //           folder:
      //               name)); // uploading file in the folder of the product name for amnagement purspose
      //   imageUrl.add(res.secureUrl); // link to upload at mongo db
      // }

// a product object is created
      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrl,
          category: category,
          price: price);

      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body: product.toJson());

      HttpsError(
          response: res,
          context: context,
          onSucces: () {
            Snackbar(context, "Product Added Successfully");
            Navigator.pop(context);
          });

      // post api server
    } catch (e) {
      Navigator.pop(context);
      Snackbar(context, e.toString());
    }
  }

// function to get admin products
  Future<List<Product>> fetchAllproduct(BuildContext context) async {
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-product'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
      );
// .fromJson acept only the string so first res.body gives the raw which we decode so we get map list then we used index to access particular item and then that item get encodeed to string
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

  Future<bool> deleteProduct(
      {required BuildContext context,
      required Product product,
      // ignore: use_function_type_syntax_for_parameters
      required onSuccess()}) async {
    try {
      http.Response res =
          await http.post(Uri.parse('$uri/admin/delete-product'),
              headers: <String, String>{
                'Content-Type': 'application/json', // charset removed
              },
              body: jsonEncode({"id": product.id})); // encoding

      HttpsError(
          response: res,
          context: context,
          onSucces: () {
            onSuccess;
          });

      Snackbar(context, "Product deleted");
      return true;
    } catch (e) {
      Snackbar(context, e.toString());
      return false;
    }
  }

  Future<List<Order>> fetchorderedProdcuts(BuildContext context) async {
    List<Order> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-order-product'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
      );
// .fromJson acept only the string so first res.body gives the raw which we decode so we get map list then we used index to access particular item and then that item get encodeed to string
      HttpsError(
          response: res,
          context: context,
          onSucces: () {
            // we will get list products
            // json decode convert it into list format

            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      Snackbar(context, e.toString());
    }
    return productList;
  }

  Future<bool> updateOrder({
    required BuildContext context,
    required Order order,
    required int status,
    // ignore: use_function_type_syntax_for_parameters
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/admin/update-order'),
          headers: <String, String>{
            'Content-Type': 'application/json', // charset removed
          },
          body: jsonEncode({"id": order.id, "status": status})); // encoding

      HttpsError(response: res, context: context, onSucces: () {});
      return true;
    } catch (e) {
      Snackbar(context, e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>> fetchEarnings(BuildContext context) async {
    List<Sales> sales = [];
    double totalEarning = 0;

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/analytics'),
        headers: <String, String>{
          'Content-Type': 'application/json', // charset removed
        },
      );

      HttpsError(
          response: res,
          context: context,
          onSucces: () {
            var resp = jsonDecode(res.body);
            totalEarning = resp['totalEarning'];
            sales = [
              Sales(label: 'Mobiles', earning: resp["MobilesEarning"]),
              Sales(label: 'Essentials', earning: resp["EssentialsEarning"]),
              Sales(label: 'Books', earning: resp["BooksEarning"]),
              Sales(label: 'Appliances', earning: resp["AppliancesEarning"]),
              Sales(label: 'Fashion', earning: resp["FashionEarning"])
            ];
          });
    } catch (e) {
      Snackbar(context, e.toString());
    }

    return {'sales': sales, 'totalEarnings': totalEarning};
  }

  Future<void> turnUser({required BuildContext context}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(Uri.parse('$uri/user/turn-user'),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body: jsonEncode({'userId': userProvider.user.id}));

      HttpsError(
          response: res,
          context: context,
          onSucces: () {
            Snackbar(context, "Welcome ${userProvider.user.name}");
          });
    } catch (e) {
      Snackbar(context, e.toString());
    }
  }
}
