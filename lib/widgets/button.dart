import 'package:flutter/material.dart';

class custom_btn extends StatelessWidget {
  const custom_btn(
      {super.key, required this.text, required this.onTap, this.color});

  final String text;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(double.infinity, 50),
          primary: color), // size
      child: Text(
        text,
        style: TextStyle(color: color == null ? Colors.white : Colors.black),
      ),
    );
  }
}
