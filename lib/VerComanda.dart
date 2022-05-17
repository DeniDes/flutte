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
        stream: FirebaseFirestore.instance.collection('comanda1').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              const SizedBox(
                height: 90,
              );
              return Column(
                children: [

                  const SizedBox(height: 20,),
                  Text(document['plato']+' , '+document['persona']),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}