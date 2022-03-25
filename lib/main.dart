import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_image_store/app.dart';
import 'package:flutter/material.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}
