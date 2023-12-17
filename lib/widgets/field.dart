import 'package:flutter/material.dart';

class custome_field extends StatelessWidget {
  const custome_field(
      // default max line get one
      {super.key,
      required this.controller,
      required this.hint,
      this.maxlines = 1});

  final TextEditingController controller;
  final String hint;
  final int maxlines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38)),
          enabledBorder: const OutlineInputBorder(
              // set color of the field when not focused
              borderSide: BorderSide(color: Colors.black38)),
        ),
        validator: (val) {
          // validate the text field on here settled conditions
          if (val == null || val.isEmpty) {
            return 'Enter Your $hint';
          }
          return null;
        },
        maxLines: maxlines,
      ),
    );
  }
}
