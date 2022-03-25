import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image_store/login/views/login_page.dart';
import 'package:firebase_image_store/signup/model/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/homepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: _HomePageView(),
    );
  }
}

class _HomePageView extends StatefulWidget {
  _HomePageView({Key? key}) : super(key: key);

  @override
  State<_HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<_HomePageView> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> logout(BuildContext context) async {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          SizedBox(
            height: 150,
            child: Image.asset(
              'assets/images/thunder.png',
              fit: BoxFit.contain,
            ),
          ),
          const Text(
            "Welcome Back",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${loggedInUser.firstName} ${loggedInUser.secondName}",
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${loggedInUser.email}",
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 15,
          ),
          ActionChip(
              label: const Text("Logout"),
              onPressed: () {
                logout(context);
              })
        ]),
      ),
    );
  }
}
