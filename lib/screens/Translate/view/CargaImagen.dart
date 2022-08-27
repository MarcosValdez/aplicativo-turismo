import 'package:flutter/material.dart';

import '../CargaImagen/CargaImagenBloc.dart';

class CargaImagen extends StatefulWidget{

  @override
  _CargaImagenState createState() => _CargaImagenState();
  
}

class _CargaImagenState extends State<CargaImagen>{

  var carga_bloc = CargaBloc();
  //String imagenUrl;
  late String imgUrl;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: carga_bloc.userStream,
      initialData: null,
      builder: (context, snapshot) => Column(
        children: [
          // (snapshot.data!=null)?Image.network(snapshot.data):Placeholder(fallbackHeight: 200.0, fallbackWidth: double.infinity,),
          (imgUrl!=null)?Image.network(imgUrl):Placeholder(fallbackHeight: 200.0, fallbackWidth: double.infinity,),
          SizedBox(height: 20,),
          RaisedButton(
              onPressed: (){
                carga_bloc.inputEvent.add(BlocEvent.CargaEvent);
              },
            child: Text("Cargar Imagen"),
            color: Colors.blueAccent,
          )
      ],
      ),
    );
    }
  }
