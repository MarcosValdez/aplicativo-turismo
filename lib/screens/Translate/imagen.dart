import 'dart:io';
import'package:aplicativo_turismo/screens/Translate/busqueda.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum ImageSourceType { gallery, camera }

class imagen extends StatelessWidget {
  void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Seleccionar imagen"),
        ),
        backgroundColor: Colors.black87,
        body: Center(
          child: Column(
            children: [
              Container(
                  width: 150,
                  height: 60,
                  child: ButtonBar(
                    children: [
                      ElevatedButton(
                        //color: Colors.blue,
                        child: Text(
                          "Imagen en galería",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white70, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          _handleURLButtonPress(context, ImageSourceType.gallery);
                        },
                      ),
                    ],
                  )
              ),
              Container(
                  width: 150,
                  height: 60,
                  child: ButtonBar(
                    children: [
                      ElevatedButton(
                        //color: Colors.blue,
                        child: Text(
                          "Desde la camara",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white70, fontWeight: FontWeight.bold),

                        ),
                        onPressed: () {
                          _handleURLButtonPress(context, ImageSourceType.camera);
                        },
                      ),
                    ],
                  )
              ),
            ],
          ),
        ));
  }
}



class ImageFromGalleryEx extends StatefulWidget {
  final type;
  ImageFromGalleryEx(this.type);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  var _image;
  var imagePicker;
  var type;

  ImageFromGalleryExState(this.type);

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
          title: Text(type == ImageSourceType.camera
              ? "Desde la camara"
              : "Imagen de galeria")),
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                var source = type == ImageSourceType.camera
                    ? ImageSource.camera
                    : ImageSource.gallery;
                XFile image = await imagePicker.pickImage(
                    source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
                setState(() {
                  _image = File(image.path);
                });
              },
                child: Column(
                  children: [
                    img_cam(),
                    btn_usar()
                  ],
                ),
            ),
          )
        ],
      ),
    );
  }
  Widget txt_main(String txt, double size){
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Text(
        txt,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: size,
        ),
      ),
    );
  }

  Widget btn_usar(){
    return Container(
        width: 150,
        height: 60,
        child: ButtonBar(
          children: [
            ElevatedButton.icon(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => busqueda())
                );
              },
              icon: Icon(Icons.camera),
              label: Text('Usar Imagen', textAlign: TextAlign.center),
            ),
          ],
        )
    );
  }

  Widget img_cam(){
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.blue),
      child: _image != null
          ? Image.file(
        _image,
        width: 200.0,
        height: 200.0,
        fit: BoxFit.fitHeight,
      )
          : Container(
        decoration: BoxDecoration(
            color: Colors.blue),
        width: 200,
        height: 200,
        child: Icon(type == ImageSourceType.camera
            ? Icons.camera_alt
            : Icons.file_upload,
          size: 50,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}

