import 'package:amazonclone/pages/auth_screen.dart';
import 'package:amazonclone/providers/userproviders.dart';
import 'package:amazonclone/widgets/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class home extends StatefulWidget {
  static const String routeName = '/home';
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      bottomNavigationBar: BottomBar(),
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
