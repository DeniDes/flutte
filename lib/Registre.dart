// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class Registre extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;

  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  String text1 = "";
  String text2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("registrer screen"),
      ),
      body: Center(
        child: Theme(data: ThemeData(
          hintColor: Colors.white,
        ),
        child: ListView(
          children: [

            Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(30),
                    ),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: myController,
                      decoration: InputDecoration(
                        hintText: "username",
                        prefixIcon: const Icon(
                          Icons.account_circle_rounded,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 2.0),
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
                        hintText: "email",
                        prefixIcon: const Icon(
                          Icons.mail_rounded,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: myController3,
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
                    const SizedBox(
                      height: 30,
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: const Text('create'),
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      onPressed: () async {
                        try {
                          await auth.createUserWithEmailAndPassword(
                              email: myController2.text, password: myController3.text);
                          FirebaseFirestore.instance
                              .collection('user')
                              .doc(myController2.text)
                              .set({'username': myController.text, 'photo':''});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sucessfully Register.You Can Login Now'),
                            ),
                            //duration: Duration(seconds: 5),
                          );
                          Navigator.of(context).pop();
                        } on FirebaseAuthException catch (e) {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                  title: const Text(' Ops! Registration Failed'),
                                  content: Text('${e.message}')));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
      ),
    );
  }
}
