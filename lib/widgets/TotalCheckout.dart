import 'package:amazonclone/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalCheckout extends StatefulWidget {
  const TotalCheckout({super.key});

  @override
  State<TotalCheckout> createState() => _TotalCheckoutState();
}

class _TotalCheckoutState extends State<TotalCheckout> {
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
