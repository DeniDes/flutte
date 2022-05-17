import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterproject/Inici.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var options = const FirebaseOptions(
      apiKey: "AIzaSyA-ps_RkX3RKKvRS4uOefABuW6yi3XT8zY",
      authDomain: "flutter-a7d90.firebaseapp.com",
      projectId: "flutter-a7d90",
      storageBucket: "flutter-a7d90.appspot.com",
      messagingSenderId: "922131752042",
      appId: "1:922131752042:web:68d56c4d13924fb2cb9613",
      measurementId: "G-VSN5Z9J7NC"
  );
  if (kIsWeb) {
    await Firebase.initializeApp(options: options);
  }else {
    await Firebase.initializeApp(options: null);
  }
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      canvasColor: Colors.brown,
    ),
    home: inici(),
    debugShowCheckedModeBanner: false,
  ));
}
