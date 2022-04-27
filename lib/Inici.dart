import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Home.dart';
import 'Registre.dart';

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
        title: Text('First Screen'),
      ),
      body: Center(
        child:Column(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
            ),
            TextField(
              controller: myController,
              decoration: InputDecoration(
                hintText: "email",
                prefixIcon: Icon(Icons.mail_rounded,color: Colors.black,),
                border:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              controller: myController2,
              decoration: InputDecoration(
                hintText: "password",
                prefixIcon: Icon(Icons.lock_open,color: Colors.black,),
                border:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30,),
            RaisedButton(
              child: Text('next screen'),
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: () async {
                //email : de@de.de
                //pass : 1234567890
                try {
                  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: myController.text,
                      password: myController2.text
                  );
                  text1 = myController.text;
                  text2 = "es el email";
                  myController.clear();
                  myController2.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(text1, text2)),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              },
            ),
            SizedBox(height: 90,),
            RaisedButton(
              child: Text('register now'),
              color: Colors.deepPurpleAccent,
              textColor: Colors.white,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Registre()),
                );
              },
            ),
          ],

        ),
      ),
    );
  }
}