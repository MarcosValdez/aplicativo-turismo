import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

import '../../../color_constants.dart';
import '../../menu.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';


class Imagen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImagenState();
}

class _ImagenState extends State<Imagen> {

  File? imagen;
  final picker = ImagePicker();
  var pickedFile;
  String escaneado = "";
  String traducido = "";

  Future selImagen(op) async{

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
    getRecognisedText(imagen!);
    Navigator.of(context).pop();  }

  Future<void> getRecognisedText(File imagen) async {
    final inputImage = InputImage.fromFilePath(imagen.path);
    final textDetector = TextRecognizer(script: TextRecognitionScript.latin);
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    escaneado = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        escaneado = escaneado + line.text + "\n";
      }
    }
    setState((){});
    traduccion(escaneado);
  }

  Future<void> traduccion(String original) async{
    final onDeviceTranslator = OnDeviceTranslator(sourceLanguage: TranslateLanguage.english, targetLanguage: TranslateLanguage.spanish);
    final String response = await onDeviceTranslator.translateText(original);
    await onDeviceTranslator.close();
    traducido = response;
    setState((){});
  }

  // Upload image with a uuid in dir: imagenesTraduccion
  Future uploadFile(BuildContext context) async{
    UploadTask updloadTask = FirebaseStorage.instance.ref().child('imagenesTraduccion').child(Uuid().v1()).putFile(imagen!);
    TaskSnapshot taskSnapshot = await updloadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    log(downloadUrl);
    await _showMyDialog(context);
  }

  Widget _buildAlertDialog() {
    return AlertDialog(
      title: Text('Notificacion'),
      content:
      Text("La imagen se ha cargado con exito"),
      actions: <Widget>[
        FlatButton(
            child: Text("Aceptar"),
            textColor: Colors.blue,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Menu()));
            }),
      ],
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (_) => _buildAlertDialog(),
    );
  }

  carga_opciones(context) {
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
                )
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.secondaryColor,
          title: Text('Traduccion por Imagen',
              style: Theme.of(context).textTheme.bodySmall?.merge(TextStyle(color: Colors.white))
          ),
        ),
        backgroundColor: ColorConstants.lightBackground,
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    carga_opciones(context);
                  },
                  child: Text('Seleccionar imagen'),
                ),
                ElevatedButton(
                  onPressed: (){
                    uploadFile(context);
                  },
                  child: Text('Cargar imagen'),
                ),
                SizedBox(
                  height: 30,
                ),
                imagen == null ? Center() : Image.file(imagen!),
                Text("\nTexto detectado:\n\n"+escaneado+"\n"),
                Text("Traduccion:\n\n"+traducido)
              ],
            ),
          )
        ])
    );
  }
}
