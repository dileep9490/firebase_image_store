import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image_store/home/views/home_page.dart';

import 'package:firebase_image_store/signup/views/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../mixins/input_validators_mixin.dart';
import '../../widgets/form_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = "/loginpage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _LoginPageView(),
    );
  }
}

class _LoginPageView extends StatelessWidget with InputValidators {
  _LoginPageView({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void signIn(String email, String password) async {
      if (_formKey.currentState!.validate()) {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) {
          Fluttertoast.showToast(msg: "Login Successful");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }).catchError((e) {
          Fluttertoast.showToast(msg: e.toString());
        });
      }
    }

    return Center(
      child: SingleChildScrollView(
          child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/thunder.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 45),
                  FormWidget(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.email,
                    hintText: 'Email',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your email";
                      }
                      if (!isEmailValid(value)) {
                        return "Please Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  FormWidget(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icons.vpn_key,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required for login ';
                      }
                      if (!isPasswordValid(value)) {
                        return 'Enter a valid password(Min. 6 characters)';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 35),
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      child: const Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onPressed: () {
                        signIn(emailController.text, passwordController.text);
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't Have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpPage.route);
                        },
                        child: const Text(
                          "SignUp",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.green),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
      )),
    );
  }
}
