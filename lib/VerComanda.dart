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
        //     //return Text("$index");
        //     return getData(1);
        //   },
        // ),
         child: getData(1)
      )

    );
  }
}

class getData extends StatelessWidget {
  var index1=0;
  getData(int index){
    index1=index;
  }

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
              return Center(
                  child: Text(document['text']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}