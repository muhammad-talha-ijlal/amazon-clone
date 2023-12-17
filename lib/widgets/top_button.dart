import 'package:flutter/material.dart';

class TopButton extends StatefulWidget {
  TopButton({super.key, required this.name, required this.onTap});

  String name;
  Function()? onTap;

  @override
  State<TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.circular(50),
            color: Colors.white),
        child: OutlinedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.black12.withOpacity(0.03),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                )),
            onPressed: widget.onTap,
            child: Text(
              widget.name,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
            )),
      ),
    );
  }
}
