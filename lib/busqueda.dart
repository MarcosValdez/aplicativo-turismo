import 'package:flutter/material.dart';
import 'package:aplicativo_turismo/traduccion.dart';

class busqueda extends StatefulWidget{
  @override
  _busquedaState createState() => _busquedaState();
}

class _busquedaState extends State<busqueda>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Busqueda'),
      ),
      backgroundColor: Colors.black87,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imagen_principal(),
              texto_busqueda(),
              btn_siguiente(),
            ],
          ),
        ),
      ),
    );
  }
  Widget imagen_principal() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 10
        )
      ),
      child: Image.asset('assets/img_busqueda.jpg', height: 400,),
    );
  }
  Widget texto_busqueda(){
    return Text(
      'Buscando Texto',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontSize: 20,
      ),
    );
  }

  //Para pruebas
  Widget btn_siguiente(){
    return FlatButton(
      child: Text(
        'Siguiente Prototipo',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 10,
        ),
      ),
      onPressed: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => traduccion())
        );
      },
    );
  }
}