import 'package:amazonclone/widgets/BottomNavBar.dart';
import 'package:amazonclone/pages/AuthPage.dart';
import 'package:amazonclone/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
        title: const Text("hello"),
      ),
      body: Center(
        child: Builder(builder: (context) {
          return ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AuthScreen.routeName);
              },
              child: Text(user.toJson().toString()));
        }),
      ),
    );
  }
}
