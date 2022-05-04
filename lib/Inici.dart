// ignore_for_file: deprecated_member_use, file_names

import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Home.dart';
import 'Registre.dart';

// ignore: camel_case_types, must_be_immutable, use_key_in_widget_constructors
class inici extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;

  final myController = TextEditingController();
  final myController2 = TextEditingController();
  String text1 = "";
  String text2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
        elevation: 0,
      ),
      body: Container(
        color: Colors.deepPurple,
        child: ListView(

          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                    bottomLeft:  Radius.circular(50),
                  )
                ),
                margin: const EdgeInsets.all(2),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    Theme(data: ThemeData(
                        hintColor: Colors.white,
                    ),
                      child: Column(
                        children: [
                          TextField(
                            style: const TextStyle(color: Colors.white),
                            controller: myController,
                            decoration: InputDecoration(
                              hintText: "email",
                              prefixIcon: const Icon(
                                Icons.mail_rounded,
                                color: Colors.black,
                              ),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 5.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: const TextStyle(color: Colors.white),
                            controller: myController2,
                            decoration: InputDecoration(
                              hintText: "password",
                              prefixIcon: const Icon(
                                Icons.lock_open,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                      child: const Text('next screen'),
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      onPressed: () async {
                        //email : de@de.de
                        //pass : 1234567890
                        try {
                          // ignore: unused_local_variable
                          UserCredential userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                              email: myController.text,
                              password: myController2.text);
                          text1 = myController.text;
                          text2 = "es el email";
                          myController.clear();
                          myController2.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home(text1, text2)),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                    backgroundColor: Colors.brown,
                                    titleTextStyle: const TextStyle( color: Colors.white),
                                    contentTextStyle: const TextStyle( color: Colors.white),
                                    title: const Text(
                                        ' Ops! No user found for that email.'),
                                    content: Text('${e.message}')));
                          } else if (e.code == 'wrong-password') {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                    backgroundColor: Colors.brown,
                                    titleTextStyle: const TextStyle( color: Colors.white),
                                    contentTextStyle: const TextStyle( color: Colors.white),
                                    title: const Text(
                                        ' Ops! Wrong password provided for that user.'),
                                    content: Text('${e.message}')));
                          } else {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                    backgroundColor: Colors.brown,
                                    titleTextStyle: const TextStyle( color: Colors.white),
                                    contentTextStyle: const TextStyle( color: Colors.white),
                                    title: const Text(' Ops! Error.'),
                                    content: Text('${e.message}')));
                          }
                        }
                      },
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                    RaisedButton(
                      child: const Text('register now'),
                      color: Colors.deepPurpleAccent,
                      textColor: Colors.white,
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Registre()),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
