import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

class Imagen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImagenState();
}

class _ImagenState extends State<Imagen> {

  File? imagen;
  final picker = ImagePicker();
  var pickedFile;

  Future selImagen(op) async{

    // var pickedFile;
    // Opcion de tomar foto o seleccionar desde galeria
    if(op == 1){
      pickedFile = await picker.getImage(source: ImageSource.camera);
    }else{
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }

    setState((){
      if(pickedFile != null) {
        imagen = File(pickedFile!.path);
      }else{
        print("No se selecciono una imagen");
      }
    });
    // Cerrar al seleccionar
    Navigator.of(context).pop();
  }

  // Upload image with a uuid in dir: imagenesTraduccion
  Future uploadFile() async{
    //Desea subir imagen?
    // final path = 'files/${pickedFile!.name}';
    UploadTask updloadTask = FirebaseStorage.instance.ref().child('imagenesTraduccion').child(Uuid().v1()).putFile(imagen!);
    TaskSnapshot taskSnapshot = await updloadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    log(downloadUrl);
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        selImagen(1);
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(width: 1, color: Colors.grey))),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Tomar Foto',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Icon(Icons.camera_alt, color: Colors.blue)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        selImagen(2);
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(width: 1, color: Colors.grey))),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Seleccionar Foto',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Icon(Icons.photo_album, color: Colors.blue)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.red),
                        child: Row(
                          children: [
                            Expanded(child: Text('Cancelar', style: TextStyle(
                                fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.center,)),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Traduccion por Imagen'),
        ),
        backgroundColor: Colors.black87,
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    opciones(context);
                  },
                  child: Text('Seleccionar imagen'),
                ),
                ElevatedButton(
                  onPressed: uploadFile,
                  child: Text('Cargar imagen'),
                ),
                SizedBox(
                  height: 30,
                ),
                imagen == null ? Center() : Image.file(imagen!)
              ],
            ),
          )
        ]));
  }
}
