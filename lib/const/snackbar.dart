import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:flutter/material.dart';

void Snackbar(BuildContext context, String text) {
  // for above dialoge use alert dialoge
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black87,
      content: Text(
        text,
        style: const TextStyle(color: GlobalVariables.SecondaryColor),
      )));
}
