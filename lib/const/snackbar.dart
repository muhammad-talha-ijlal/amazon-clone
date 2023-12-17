import 'dart:io'; // to pick images

import 'package:amazonclone/const/global_var.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void snackbar(BuildContext context, String text) {
  // for above dialoge use alert dialoge
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black87,
      content: Text(
        text,
        style: const TextStyle(color: GlobalVariables.secondaryColor),
      )));
}

// to pick images from gallery
Future<List<File>> pickImages() async {
  List<File> images = []; // multiple product images will get selected

  try {
    // version 4.5.1
    var files_var = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (files_var != null && files_var.files.isNotEmpty) {
      for (var i = 0; i < files_var.files.length; i++) {
        images.add(File(files_var.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return images;
}
