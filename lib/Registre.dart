import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registre extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;

  final myController = TextEditingController();
  final myController2 = TextEditingController();
  String text1 = "";
  String text2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("registrer screen"),
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
                hintText: "username",
                prefixIcon: Icon(Icons.account_circle_rounded,color: Colors.black,),
                border:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(height: 30,),
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
              child: Text('create'),
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: () async {
                try {
                  await auth.createUserWithEmailAndPassword(
                      email: myController.text,
                      password: myController2.text
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sucessfully Register.You Can Login Now'),
                    ),
                    //duration: Duration(seconds: 5),
                  );
                  Navigator.of(context).pop();
                } on FirebaseAuthException catch (e) {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(' Ops! Registration Failed'),
                        content: Text('${e.message}')
                      )
                  );
                }
              },
            ),
          ],

        ),
      ),
    );
  }
}
