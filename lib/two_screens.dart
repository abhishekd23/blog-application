import 'dart:core';

import 'package:blog_application/rounded_button.dart';
import 'package:blog_application/screens/login_screen.dart';
import 'package:blog_application/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class Screens extends StatefulWidget {
  static const String id = "two_screens";
  @override
  _ScreensState createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  // Future<bool> _onWillPop() {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Are you sure?'),
  //       content: Text('Do you want to exit an App'),
  //       actions: <Widget>[
  //         FlatButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: Text('No'),
  //         ),
  //         FlatButton(
  //           onPressed: () => exit(0),
  //           /*Navigator.of(context).pop(true)*/
  //           child: Text('Yes'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15.0,
        title: Text("Welcome Page"),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.teal,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 200, horizontal: 20),
          child: Row(
            children: [
              RoundedButton(
                colour: Colors.white,
                text: "Sign Up",
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              RoundedButton(
                colour: Colors.white,
                text: "Log in",
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
