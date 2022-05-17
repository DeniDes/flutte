import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


//import 'package:image_picker_web/image_picker_web.dart';

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
  var imageFile;
  File? _foto;
  final ImagePicker img = ImagePicker();
//  final ImagePickerWeb im = ImagePickerWeb();
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
          title: const Text("Perfil Screen"),
        ),
        body: Center(
            child: ListView(
              children: [
                Expanded(
                  child: Column(
                    children:[
                      //Image.asset(data['photo']),
                      // CircleAvatar(
                      //   backgroundImage: NetworkImage(data['photo']),
                      // ),
                      //_setImageView(),
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
                        child: const Text('modificar perfil'),
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                        onPressed: () async {
                          if(_foto==null){
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(widget.email)
                                .update({
                              'username': _myController!.text,
                              'photo': data['photo']
                            });
                            Navigator.of(context).pop();
                          }
                          else {
                            String image = await _fototourl(_foto);
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(widget.email)
                                .update({
                              'username': _myController!.text,
                              'photo': image
                            });
                            Navigator.of(context).pop();
                          }
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
  }
  void _openGalleryWeb(BuildContext context) async {
//     var iFoto = ImagePickerWeb.getImageAsFile();
     var picture =  await img.pickImage(source: ImageSource.gallery); 
     print("a");
//     print(iFoto);
     print("b");
     print(picture!.path);
  }
  Widget _setImageViewWeb() {
    if (_foto != null || data['photo'].toString()!="") {
      if(_foto != null) {
        var im = _foto as File;
        return Text(_foto.toString());
        //return Image.file(im, width: 400, height: 400);
      }/*else if(data['photo']!=null){
         //return Image.network(data['photo'], width: 400, height: 400);
         return Image.network(
           "https://www.google.com/url?sa=i&url=https%3A%2F%2Flasletras.org%2Fletra-a%2F&psig=AOvVaw09gTIO2EYjtvEjFADSBAVa&ust=1652457653982000&source=images&cd=vfe&ved=0CAkQjRxqFwoTCOCh6s2q2vcCFQAAAAAdAAAAABAE"
         , width: 400, height: 400);
      }*/
      else{return Text("aaa");}
    } else {
      return Text("Please select an image");
    }
  }
  Widget _setImageView() {
    if (kIsWeb) {
      // if(_foto != null || data['photo'].toString()!="") {
      //   if(_foto!=null) {
      //     var f = _foto?.readAsBytes();
      //
      //       _foto = f as File?;
      //
      //     return Image.file(_foto!, width: 400, height: 400);
      //   }
      //   else if(data['photo']!=null){
      //     return Image.network(data['photo'], width: 400, height: 400);
      //   }
      // }
    }else{
      if (_foto != null || data['photo'].toString()!="") {
        if(_foto != null) {
          return Image.file(_foto!, width: 400, height: 400);
        }else if(data['photo']!=null){
           return Image.network(data['photo'], width: 400, height: 400);
         }
        else{return Text("");}
      } else {
        return Text("Please select an image");
      }
    }
    return Text("a");
  }

  Future <String> _fototourl(mFile) async{
    if(kIsWeb){
      final Reference storage = FirebaseStorage.instance.ref('userimg').child(widget.email!);

      //UploadTask task = storage.putFile(mFile);

      UploadTask uploadTask = storage.putFile(mFile);
      String url;
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      url = await (await taskSnapshot).ref.getDownloadURL();
      return url;
    }else {
      final Reference storage = FirebaseStorage.instance.ref('userimg').child(widget.email!);
      UploadTask task = storage.putFile(mFile);
      String url = await (await task).ref.getDownloadURL();
      return url;
    }
  }

}