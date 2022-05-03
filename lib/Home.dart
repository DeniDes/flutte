// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutterproject/HacerComanda.dart';
import 'package:flutterproject/VerComanda.dart';

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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox.fromSize(
              size: Size(56, 56),
              child: ClipOval(
                child: RaisedButton(
                  child: const Text('perfil'),
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  onPressed: (){

                  },
                ),
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            ClipOval(
              child: RaisedButton(
                child: const Text('crear comanda'),
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HacerComanda()),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            ClipOval(
            child: RaisedButton(
              child: const Text('ver comandas'),
              color: Colors.deepPurpleAccent,
              textColor: Colors.white,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VerComanda()),
                );
              },
            ),
            ),
          ],
        ),
      ),
    );
  }
}
