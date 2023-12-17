import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/pages/admin_bottom_bar.dart';
import 'package:amazonclone/pages/auth_screen.dart';
import 'package:amazonclone/pages/home.dart';
import 'package:amazonclone/providers/userproviders.dart';
import 'package:amazonclone/router.dart';
import 'package:amazonclone/services/services_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//  in this project we created a const folder having const data like colors

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: ((settings) =>
          generateRoute(settings)), // create route when call pushnamed function
      theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme:
              // sets the primary color of every widget is golden
              const ColorScheme.light(primary: GlobalVariables.secondaryColor),
          appBarTheme: const AppBarTheme(
              // for whole project this app bar settings get applied to app bar
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black))),
      title: "Amazon",
      home: const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final auth_service authService = auth_service();
  late String? token = "";
  bool loading = true;
  @override
  void initState() {
    super.initState();
    // authService..getuserdata(context: context);
    token_shared();
  }

  void token_shared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('x-auth-token');
    authService.getUser(context: context);
    await Future.delayed(Duration(seconds: 4));
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return loading
        ? Scaffold(
            body: Center(
                child: Image.asset(
            "images/amazon.png",
            width: 270,
            color: Colors.black,
            fit: BoxFit.fitWidth,
          )))
        : token == null || token == ""
            ? const AuthScreen()
            : user.type == 'user'
                ? const home()
                : user.type != 'admin'
                    ? Scaffold(
                        body: Center(
                            child: Image.asset(
                          "images/amazon.png",
                          width: 270,
                          color: Colors.black,
                          fit: BoxFit.fitWidth,
                        )),
                      )
                    : const bottom_admin_bar();
  }
}
