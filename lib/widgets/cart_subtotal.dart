import 'package:amazonclone/providers/userproviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class total_checkout extends StatefulWidget {
  const total_checkout({super.key});

  @override
  State<total_checkout> createState() => _total_checkoutState();
}

class _total_checkoutState extends State<total_checkout> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    num sum = 0;
    user.cart.map(
      (e) {
        sum += e['quantity'] * e['product']['price'];
      },
    ).toList();

    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(
        children: [
          const Text(
            'Subtotal  ',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '\$$sum',
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
