// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String Nodeuno = "";
  // ignore: non_constant_identifier_names
  String Nodedos = "";

  // ignore: use_key_in_widget_constructors
  Home(String text1, String text2) {
    Nodeuno = text1;
    Nodedos = text2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      body: Center(
        child: Text(Nodeuno + " " + Nodedos),
      ),
    );
  }
}
