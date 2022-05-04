
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HacerComanda extends StatelessWidget {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hacer comanda screen"),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
            ),
            Text("Welcome"),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: myController,
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
            RaisedButton(
              child: const Text('register now'),
              color: Colors.deepPurpleAccent,
              textColor: Colors.white,
              onPressed: () async {
                FirebaseFirestore.instance
                      .collection('comanda1')
                      .add({'text': myController.text});
                },
            ),
          ],
        ),
        //child: AddData("plato")//AddUser("fullName", "company", 1),
      ),
    );
  }
}

class AddData extends StatelessWidget {
  var plato="";
  AddData(String s){plato=s;}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('comanda1')
                .add({'text': plato});
          },
        ),
      ),
    );
  }
}

class AddUser extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  AddUser(this.fullName, this.company, this.age);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      return users
          .add({
        'full_name': fullName, // John Doe
        'company': company, // Stokes and Sons
        'age': age // 42
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}