import 'package:blog_application/screens/login_screen.dart';
import 'package:blog_application/screens/main_screen.dart';
import 'package:blog_application/screens/registration_screen.dart';
import 'package:blog_application/splash_screen.dart';
import 'package:blog_application/two_screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        MainScreen.id: (context) => MainScreen(),
        Screens.id: (context) => Screens(),
      },
    );
  }
}
