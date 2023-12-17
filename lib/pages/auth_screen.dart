import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/services/services_auth.dart';
import 'package:amazonclone/widgets/CustomButton.dart';
import 'package:amazonclone/widgets/CustomField.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName =
      '/auth-screen'; // will pass to the main function
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormkey = GlobalKey<FormState>();
  final _signInFormkey = GlobalKey<FormState>();
  final auth_service auth = auth_service();

  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController pass = TextEditingController();

  void signupuser() {
    auth.signupuser(
        context: context,
        email: email.text,
        pasword: pass.text,
        name: username.text);
  }

  void signinuser() {
    auth.signinuser(
        context: context, email: email.text, pasword: pass.text, name: "");
  }

  @override
  Widget build(BuildContext context) {
    void dispose() {
      super.dispose();
      email.dispose();
      username.dispose();
      pass.dispose();
    }

    return Scaffold(
      backgroundColor: GlobalVariables.GreyBackgroundColor,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.GreyBackgroundColor,
                title: const Text(
                  "Create Account",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  groupValue: _auth,
                  activeColor: GlobalVariables.SecondaryColor,
                  value: Auth.signup,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              _auth == Auth.signup
                  ? Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      padding: const EdgeInsets.all(8),
                      child: Form(
                          // form requires a key
                          key: _signUpFormkey,
                          child: Column(
                            children: [
                              CustomField(
                                controller: email,
                                hint: "Email",
                              ),
                              CustomField(
                                  controller: username, hint: "Username"),
                              CustomField(
                                controller: pass,
                                hint: "Password",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                  text: "Sign up",
                                  onTap: () {
                                    // here we check whole form is valid or not if yes sign up user function get runs
                                    if (_signUpFormkey.currentState!
                                        .validate()) {
                                      signupuser();
                                    }
                                  },
                                  color: GlobalVariables.ButtonColor)
                            ],
                          )),
                    )
                  : Container(),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.GreyBackgroundColor,
                title: const Text(
                  "Sign in",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  groupValue: _auth, // these are the possible set of the value
                  activeColor: GlobalVariables.SecondaryColor,
                  value: Auth
                      .signin, // particular button get selectd on this value
                  onChanged: (Auth? val) {
                    // gives another val
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              _auth == Auth.signin
                  ? Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      padding: const EdgeInsets.all(8),
                      child: Form(
                          key: _signInFormkey,
                          child: Column(
                            children: [
                              CustomField(
                                controller: email,
                                hint: "Email",
                              ),
                              CustomField(
                                controller: pass,
                                hint: "Password",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                  text: "Sign In",
                                  onTap: () {
                                    if (_signInFormkey.currentState!
                                        .validate()) {
                                      signinuser();
                                    }
                                  },
                                  color: GlobalVariables.ButtonColor)
                            ],
                          )),
                    )
                  : Container(),
            ],
          ),
        ),
      )),
    );
  }
}
