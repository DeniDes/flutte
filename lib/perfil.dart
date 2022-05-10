import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class perfil extends StatefulWidget {
  final String? email;

  const perfil({
    Key? key,
    required this.email
  }): super(key:key);
  @override
  _perfil createState() => _perfil();
}

class _perfil extends State<perfil> {
  File? _foto;
  final ImagePicker img = ImagePicker();
  var data = { };

  TextEditingController? _myController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  /*perfil(String email) {
    getData(email);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Perfil"),
        ),
        body: Center(
            child: ListView(
              children: [
                Expanded(
                  child: Column(
                    children:[
                      _setImageView(),
                      FloatingActionButton(
                        onPressed: () {
                          _openGallery(context);
                        },
                        child: Icon(Icons.camera_alt),
                      ),
                      TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: _myController,
                          decoration: InputDecoration(
                            hintText: "username",
                            hintStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          var image = _fototourl(_foto);
                          FirebaseFirestore.instance
                              .collection('user')
                              .doc(widget.email)
                              .update({'username': _myController,'photo':image});
                          Navigator.of(context).pop();
                         },
                      )
                    ]
                  )
                )
              ]
            )
        )
    );
  }


  getData() async{
    var user = await FirebaseFirestore.instance.collection('user').doc(widget.email).get();
    data=user.data()!;
    setState(() {});
    _myController = TextEditingController( text: data['username'] );
  }
  void _openGallery(BuildContext context) async {
    var picture =  await img.pickImage(source: ImageSource.gallery);
    this.setState(() {
      if(picture!=null) {
        _foto = File(picture.path);
      }
    });
    //Navigator.of(context).pop();
  }
  Widget _setImageView() {
    if (_foto != null) {
      return Image.file(_foto!, width: 500, height: 500);
    } else {
      return Text("Please select an image");
    }
  }
  Future <String> _fototourl(mFile) async{
    final Reference storage = FirebaseStorage.instance.ref('userimg').child(widget.email!);
    UploadTask task = storage.putFile(mFile);
    String url = await (await task).ref.getDownloadURL();
    return url;
  }

}