import 'package:flutter/material.dart';

import '../../widgets/form_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const route = "/signuppage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
          )),
      body: _SignUpView(),
    );
  }
}

class _SignUpView extends StatelessWidget {
  _SignUpView({Key? key}) : super(key: key);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 170,
                child: Image.asset(
                  'assets/images/thunder.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 40),
              FormWidget(
                controller: firstNameController,
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.person,
                hintText: 'First Name',
              ),
              const SizedBox(height: 25),
              FormWidget(
                controller: secondNameController,
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.person,
                hintText: 'Second Name',
              ),
              const SizedBox(height: 25),
              FormWidget(
                controller: emailController,
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.email,
                hintText: 'Email',
              ),
              const SizedBox(height: 25),
              FormWidget(
                controller: passwordController,
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.vpn_key,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 25),
              FormWidget(
                controller: confirmpasswordController,
                textInputAction: TextInputAction.done,
                prefixIcon: Icons.vpn_key,
                hintText: 'Confirm Password',
                obscureText: true,
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
                    "Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )),
        ),
      )),
    );
  }
}
