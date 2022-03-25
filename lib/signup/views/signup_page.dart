import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image_store/home/views/home_page.dart';
import 'package:firebase_image_store/mixins/input_validators_mixin.dart';
import 'package:firebase_image_store/signup/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

class _SignUpView extends StatelessWidget with InputValidators {
  _SignUpView({Key? key}) : super(key: key);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    postDetailsToFireStore() async {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;
      UserModel userModel = UserModel();

      userModel.email = user!.email;
      userModel.uid = user.uid;
      userModel.firstName = firstNameController.text;
      userModel.secondName = secondNameController.text;

      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toMap());
      Fluttertoast.showToast(msg: "Account created successfully");

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    }

    void signUp(String email, String password) async {
      if (_formKey.currentState!.validate()) {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          postDetailsToFireStore();
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "First Name cannot be Empty";
                      }
                      if (!isNameValid(value)) {
                        return 'Enter Valid Name(Min. 3 characters)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  FormWidget(
                    controller: secondNameController,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.person,
                    hintText: 'Second Name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "First Name cannot be Empty";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
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
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.vpn_key,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required ';
                      }
                      if (!isPasswordValid(value)) {
                        return 'Enter a valid password(Min. 6 characters)';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  FormWidget(
                    controller: confirmpasswordController,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icons.vpn_key,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    validator: (value) {
                      if (passwordController.text !=
                          confirmpasswordController.text) {
                        return "Password don't match";
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
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onPressed: () {
                        signUp(emailController.text, passwordController.text);
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
