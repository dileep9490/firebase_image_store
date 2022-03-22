import 'package:firebase_image_store/home/views/home_page.dart';
import 'package:firebase_image_store/login/views/login_page.dart';
import 'package:firebase_image_store/signup/views/signup_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(accentColor: Colors.green),
      title: 'Firebase_Image_Store',
      home: const LoginPage(),
      routes: {
        LoginPage.route: (context) => const LoginPage(),
        SignUpPage.route: (context) => const SignUpPage(),
        HomePage.route: (context) => const HomePage(),
      },
    );
  }
}
