import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rocket/backend.dart';

Future<void> main() async {
  await Firebase.initializeApp();
  final backend = Backend('https://api.spacexdata.com/v4');
  runApp(
    RocketGuideApp(
      backend: backend,
    ),
  );
}
