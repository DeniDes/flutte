import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerComanda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ver comanda screen"),
      ),
      body: Container(
        // child: ListView.builder(
        //   itemBuilder: (context, index) {
        //     return Text("$index");
        //   },
        // ),
          child: getData()
      )

    );
  }
}

class getData extends StatelessWidget {
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
              return Center(child: Text(document['primero'][0]));
            }).toList(),
          );
        },
      ),
    );
  }
}