import 'dart:async';

import 'package:blog_application/constants.dart';
import 'package:blog_application/rounded_button.dart';
import 'package:blog_application/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegistrationScreen extends StatefulWidget {
  //const RegistrationScreen({Key key}) : super(key: key);
  static const String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? loggedInUser;

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  String? mail;
  String? pass;
  String? confirm_pass;
  bool showSpinner = false;

  Future<void> userRegister(String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = await _auth.currentUser;
      if (!user!.emailVerified) {
        // var actionCodeSettings = ActionCodeSettings(
        //   url: 'https://www.example.com/?email=${user.email}',
        //   dynamicLinkDomain: "example.page.link",
        //   iOS: {"bundleId": "com.abhi.ios"},
        //   android: {
        //     "packageName": "com.abhi.android",
        //     "installApp": true,
        //     "minimumVersion": "12"
        //   },
        //   handleCodeInApp: true,
        // );
        await user.sendEmailVerification();
      }
      if (newUser != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: "Registered successfully!",
          ),
        );
        Navigator.pushNamed(context, LoginScreen.id);
        setState(() {
          showSpinner = false;
        });
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
  }

  void getCurrenUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getCurrenUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15.0,
        title: Text("Sign-up Page"),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.teal,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        opacity: 0.4,
        color: Colors.white,
        progressIndicator: CircularProgressIndicator(),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    // onChanged: (value) {
                    //   mail = value;
                    // },
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: "Enter your mail",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _passController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    // onChanged: (value) {
                    //   pass = value;
                    // },
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: "Enter your password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _confirmPassController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: "Confirm your password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    // onChanged: (value) {
                    //   confirm_pass = value;
                    // },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  RoundedButton(
                    colour: Colors.white,
                    text: "Sign up",
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      final email = _emailController.text.toString().trim();
                      final password = _passController.text.toString().trim();
                      final confirm =
                          _confirmPassController.text.toString().trim();
                      if (confirm == password) {
                        userRegister(email, password);
                      } else {
                        showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message: "Please enter the correct password",
                            ));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
