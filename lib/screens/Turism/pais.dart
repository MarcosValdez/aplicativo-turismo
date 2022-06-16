import 'package:aplicativo_turismo/screens/Turism/lugarTuristico.dart';
import 'package:aplicativo_turismo/screens/Turism/lugaresVert.dart';
import 'package:flutter/material.dart';

class pais extends StatefulWidget {
  @override
  _paisState createState() => _paisState();
}

class _paisState extends State<pais> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Destinos a visitar"),
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_boton("Perú"), _boton("Brazil"), _boton("Argentina")],
            ),
          ],
        ),
      ),
    );
  }

  Widget _boton(String texto) {
    return Container(
        height: 90,
        width: 200,
        margin: EdgeInsets.only(top: 50, bottom: 40),
        child: RaisedButton(
          child: Text(
            texto,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0),
          ),
          color: Colors.blue,
          elevation: 5,
          padding: EdgeInsets.all(30),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => lugarTuristicoVert()),
            ),
          },
        ));
  }
}
