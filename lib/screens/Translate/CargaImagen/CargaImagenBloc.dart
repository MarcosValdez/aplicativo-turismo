import 'dart:io';

import 'package:aplicativo_turismo/screens/Translate/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:async';

//Eventos que ocurriran en este Bloc
enum BlocEvent{
  CargaEvent
}


// Clase Bloc encargada de la carga de imagenes
class CargaBloc{

  // Controller para la vista
  final userStreamController = StreamController<String>();
  StreamSink<String> get userSink => userStreamController.sink;
  Stream<String> get userStream => userStreamController.stream;




  // Controller para la logica
  //StreamController encargado de los Bloc Events
  final eventStreamController = StreamController<BlocEvent>();

  //StreamSink tomara la entrada del usuario al hacer click
  StreamSink<BlocEvent> get inputEvent => eventStreamController.sink;

  //Encargado de la salida de eventStream
  Stream<BlocEvent> get outputEvent => eventStreamController.stream;

  CargaBloc(){
    outputEvent.listen((event) async{
      if(event == BlocEvent.CargaEvent){
        // Iniciamos Firebase Storage
        final storage = FirebaseStorage.instance;
        // Iniciamos Image Picker
        final image_picker = ImagePicker();
        // Instancia de PickedFile
        PickedFile imagen;
        //Solicitar Permisos
        await Permission.photos.request();
        var CheckValidPermission = await Permission.photos.status;

        if(CheckValidPermission.isGranted){
          imagen = (await image_picker.getImage(source: ImageSource.gallery))!;
          var file = File(imagen.path);
          await storage.ref().child(RUTA_IMAGEN).putFile(file).then((value) async{
            var downloadURL = await value.ref.getDownloadURL();
            userSink.add(downloadURL);
          });
        }else{
          print("Permiso Denegado");
        }

        ;
      }else{

      }
    });
  }

}