
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Home.dart';

class HacerComanda extends StatelessWidget {
  final myController = TextEditingController();
  String user="";
  HacerComanda(String u){user=u;}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hacer comanda screen"),
      ),
      body: Center(
        /*child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
            ),
            Text("Welcome"),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: myController,
              decoration: InputDecoration(
                hintText: "hola",
                prefixIcon: const Icon(
                  Icons.lock_open,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
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
        ),*/
        child: getData(user)
      ),
    );
  }
}

class AddData extends StatelessWidget {
  var plato="";
  var user="";
  AddData(String s, String u){plato=s;user=u;}

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
                .add({'plato': plato,'persona':user});
            Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home(user)),
                    );
          },
        ),
      ),
    );
  }
}

class getData extends StatelessWidget {
  String plato="";
  String user="";
  getData(String u){user=u;}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('restaurante').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Column(
                children: [
                  const SizedBox(height: 20,),
                  RaisedButton(
                      child: Text(document['text']),
                      color: Colors.deepPurpleAccent,
                      textColor: Colors.white,
                      onPressed: (){
                        plato=document['text'];
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddData(plato,user)),
                        );
                      },
                    ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}