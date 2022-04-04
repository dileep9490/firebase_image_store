import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ShowUploads extends StatefulWidget {
  ShowUploads({Key? key, this.userId}) : super(key: key);

  String? userId;

  @override
  State<ShowUploads> createState() => _ShowUploadsState();
}

class _ShowUploadsState extends State<ShowUploads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Images'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.userId)
            .collection('images')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
          if (!snapShot.hasData) {
            return const Center(
              child: Text("No Image Uploaded"),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                String url = snapShot.data!.docs[index]['downloadURL'];
                return Image.network(
                  url,
                  height: 300,
                  fit: BoxFit.cover,
                );
              },
              itemCount: snapShot.data!.docs.length,
            );
          }
        },
      ),
    );
  }
}
