import 'dart:async';

import 'package:blog_application/screens/main_screen.dart';
import 'package:blog_application/two_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

User? loggedInUser;

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() async {
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        Navigator.pushNamed(context, MainScreen.id);
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
    startTimer();
    getCurrentUser();
  }

  route() {
    Navigator.pushNamedAndRemoveUntil(
        context, Screens.id, ModalRoute.withName(SplashScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SpinKitCircle(
        color: Colors.white,
      ),
    );
  }
}
