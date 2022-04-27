import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  String Nodeuno = "";
  String Nodedos = "";

  Home(String text1, String text2){
    Nodeuno=text1;
    Nodedos=text2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: Text(Nodeuno+" "+Nodedos),
      ),
    );
  }
}
