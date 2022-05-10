// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutterproject/HacerComanda.dart';
import 'package:flutterproject/VerComanda.dart';
import 'package:flutterproject/perfil.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String user = "";


  // ignore: use_key_in_widget_constructors
  Home(String u) {
    user = u;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      body: Center(
        child: ListView(
          children: [
            Expanded(
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
                  ClipOval(
                    child: RaisedButton(
                      child: const Text('perfil'),
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => perfil(email: user,)),
                        );
                      },
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
                          MaterialPageRoute(builder: (context) => HacerComanda(user)),
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
                  const SizedBox(
                    height: 90,
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
