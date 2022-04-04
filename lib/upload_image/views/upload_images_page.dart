import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  UploadImage({Key? key, this.userId}) : super(key: key);

  String? userId;

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _image;
  final imagepicker = ImagePicker();
  String? downloadUrl;
  Future pickImage() async {
    final pick = await imagepicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar('no file selected', const Duration(microseconds: 400));
      }
    });
  }

  Future uploadImage() async {
    final postId = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${widget.userId}/images")
        .child('post_$postId');
    await ref.putFile(_image!);
    downloadUrl = await ref.getDownloadURL();
    await firebaseFirestore
        .collection('users')
        .doc(widget.userId)
        .collection("images")
        .add({"downloadURL": downloadUrl}).then((value) => showSnackBar(
            'Image Uploaded Successfully', const Duration(seconds: 2)));
  }

  showSnackBar(String text, Duration d) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Image")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 550,
              width: double.infinity,
              child: Column(
                children: [
                  const Text('Upload Image'),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: 320,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _image == null
                                ? const Center(child: Text("No Image Selected"))
                                : Image.file(_image!),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: const Text('Select Image'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_image != null) {
                                uploadImage();
                              } else {
                                showSnackBar('No image Selected',
                                    Duration(microseconds: 500));
                              }
                            },
                            child: const Text('Upload Image'),
                          ),
                        ],
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
