import 'package:blog_application/constants.dart';
import 'package:blog_application/rounded_button.dart';
import 'package:blog_application/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  //const LoginScreen({Key key}) : super(key: key);
  static const String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> userLogin(String email, String pass) async {
    try {
      final newUser =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User? user = newUser.user;
      if (user!.emailVerified) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
        setState(() {
          showSpinner = false;
        });
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text("Email not verified"),
        //     action: SnackBarAction(
        //       label: 'Undo',
        //       onPressed: () {
        //         // Some code to undo the change.
        //       },
        //     ),
        //   ),
        // );
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Email not verified! Please verify your email address",
          ),
        );
      }
    } catch (e) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Incorrect password",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15.0,
        title: Text("Login Page"),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.teal,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        opacity: 0.4,
        //color: Colors.white,
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
                      "Login In",
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
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Enter your mail",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: "Enter your password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  RoundedButton(
                    colour: Colors.white,
                    text: "Log In",
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      final email = _emailController.text.toString().trim();
                      final password =
                          _passwordController.text.toString().trim();

                      await userLogin(email, password);
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
