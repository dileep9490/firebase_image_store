import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image_store/login/views/login_page.dart';
import 'package:firebase_image_store/signup/model/user_model.dart';
import 'package:firebase_image_store/upload_image/views/upload_images_page.dart';
import 'package:flutter/material.dart';

import '../../show_images/views/show_images_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/homepage';

  @override
  Widget build(BuildContext context) {
    Future<void> logout(BuildContext context) async {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: AppBar(
          title: const Text("Profile"),
          actions: [
            IconButton(
                onPressed: () {
                  logout(context);
                },
                icon: const Icon(Icons.logout_outlined))
          ],
        ),
      ),
      body: const _HomePageView(),
    );
  }
}

class _HomePageView extends StatefulWidget {
  const _HomePageView({Key? key}) : super(key: key);

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
      loggedInUser = UserModel.fromMap(value);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
              style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${loggedInUser.email}",
              style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "${loggedInUser.uid}",
              style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(onPressed: () {
               Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  UploadImage(userId: loggedInUser.uid,)));
            }, child: const Text("Upload Image")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ShowUploads(userId: loggedInUser.uid,)));
                },
                child: const Text("Show Image")),
          ],
        ),
      ),
    );
  }
}
