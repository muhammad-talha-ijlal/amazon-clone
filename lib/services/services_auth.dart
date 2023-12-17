// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazonclone/const/error_handl.dart';
import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/const/snackbar.dart';
import 'package:amazonclone/model/user.dart';
import 'package:amazonclone/pages/home.dart';
import 'package:amazonclone/providers/userproviders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class auth_service {
  // sign up user
  void signupuser(
      {
      // get context
      required BuildContext context,
      required String email,
      required String pasword,
      required String name}) async {
    try {
      User user = User(
          id: '',
          email: email,
          name: name,
          password: pasword,
          address: '',
          type: '',
          cart: []);

      // sign up
      // remeber we set an api for /api/signup which gives json
      // body is set to give input to json file
      http.Response res = await http
          .post(Uri.parse('$uri/api/signup'), body: user.toJson(), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
      print(res.statusCode);

      // snack bar and https error
      // ignore: use_build_context_synchronously
      httpsError(
          response: res,
          context: context,
          onSucces: () {
            snackbar(context, "Account Creation Success");
          });
    } catch (e) {
      snackbar(context, e.toString());
    }
  }

  void signinuser(
      {
      // get context
      required BuildContext context,
      required String email,
      required String pasword,
      required String name}) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({'email': email, 'password': pasword}),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });
      print(res.statusCode);

      // snack bar and https error
      // ignore: use_build_context_synchronously
      httpsError(
          response: res,
          context: context,
          onSucces: () async {
            // shared prefernece will be used to store the token to signin
            // providers will be used to keep the user details
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // ignore: use_build_context_synchronously
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            prefs.setString("x-auth-token", jsonDecode(res.body)['token']);
            prefs.setString("x-auth-mail", jsonDecode(res.body)['email']);
            prefs.setString("x-auth-pass", jsonDecode(res.body)['password']);
            // ignore: use_build_context_synchronously
            Navigator.pushNamedAndRemoveUntil(
                context, home.routeName, (route) => false);
          });
    } catch (e) {
      snackbar(context, e.toString());
    }
  }

  void getUser({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString("x-auth-mail");
      String? pass = prefs.getString("x-auth-pass");
      print(email);
      print(pass);

      if (email != null && pass != null) {
        http.Response res = await http.post(Uri.parse('$uri/api/userdetails'),
            body: jsonEncode({
              'email': email,
            }),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            });

        Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      }
    } catch (e) {
      snackbar(context, e.toString());
    }
  }

  Future<void> turnSeller({required BuildContext context}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(Uri.parse('$uri/user/turn-seller'),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body: jsonEncode({'userId': userProvider.user.id}));

      httpsError(
          response: res,
          context: context,
          onSucces: () {
            snackbar(context, "Welcome Admin");
          });
    } catch (e) {
      snackbar(context, e.toString());
    }
  }

// function to save address
  void saveAddress({
    required BuildContext context,
    required String address,
  }) async {
    try {
      // gives isntance of userProver.user
      // to change userProvider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
          Uri.parse('$uri/user/save-user-address'),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body: jsonEncode(
              {'address': address, 'user_id': userProvider.user.id}));

      httpsError(
          response: res,
          context: context,
          onSucces: () {
            //  stroing a neew instance of user provider
            var temp = userProvider.user
                .copyWith(address: jsonDecode(res.body)['address']);

            // userProvider.user gives an instance of user stored in provider
            userProvider.setUserFrommodel(temp);

            snackbar(context, "Address Updated");
          });
    } catch (e) {
      snackbar(context, e.toString());
    }
  }

  void orderProduct(
      {required BuildContext context,
      required String address,
      required double totalSum}) async {
    try {
      // gives isntance of userProver.user
      // to change userProvider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
          Uri.parse(
              '$uri/user/order-product'), // api need user_id and id of product
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'user_id': userProvider.user.id,
            'address': address,
            'totalPrice': totalSum
          }));
      httpsError(
          response: res,
          context: context,
          onSucces: () {
            //  stroing a neew instance of user provider
            var temp = userProvider.user.copyWith(cart: []);

            // userProvider.user gives an instance of user stored in provider
            userProvider.setUserFrommodel(temp);
            snackbar(context, "Your Order is Placed");
            Future.delayed(const Duration(seconds: 4), () {
              Navigator.pop(context);
            });
          });
    } catch (e) {
      snackbar(context, e.toString());
    }
  }

  void logout(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("x-auth-token", "");
      prefs.setString("x-auth-mail", "");
      prefs.setString("x-auth-pass", "");
    } catch (e) {
      snackbar(context, e.toString());
    }
    // ignore: use_build_context_synchronously
  }
}
