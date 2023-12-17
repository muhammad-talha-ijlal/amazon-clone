import 'dart:convert';

import 'package:amazonclone/const/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpsError(
    {
    // api  return the status code and that json coded in form of response
    required http.Response response,
    required BuildContext context,
    required VoidCallback onSucces // function

    }) {
  switch (response.statusCode) {
    case 200:
      onSucces();
      break;
    case 400:
      snackbar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      snackbar(context, jsonDecode(response.body)['error']);
      break;
    default:
      snackbar(context, jsonDecode(response.body));
  }
}
