import 'package:aplicativo_turismo/screens/Dicctionary/biblioteca.dart';
import 'package:aplicativo_turismo/screens/Translate/imagen.dart';
import 'package:aplicativo_turismo/screens/menu.dart';
import 'package:flutter/material.dart';

class traduccion extends StatefulWidget {
  @override
  _traduccionState createState() => _traduccionState();
}

class _traduccionState extends State<traduccion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Busqueda'),
      ),
      backgroundColor: Colors.black87,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              txt_header(),
              img_encontrado(),
              txt_traduccion(),
              btn_options()
            ],
          ),
        ),
      ),
    );
  }

  Widget txt_header() {
    return Container(
      margin: EdgeInsets.all(50),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          txt_main('Texto Encontrado', 20),
        ],
      )),
    );
  }

  Widget txt_traduccion() {
    return Container(
      margin: EdgeInsets.all(50),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [txt_idmoriginal(), txt_idmobjetivo()],
      )),
    );
  }

  Widget txt_idmoriginal() {
    return Container(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        txt_main('Idioma Original', 14),
        txt_main('Ruso', 14),
        txt_main('CTOП', 20),
      ],
    )));
  }

  Widget txt_idmobjetivo() {
    return Container(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        txt_main('Español', 14),
        txt_main('DETENGASE', 20),
      ],
    )));
  }

  Widget img_encontrado() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.white, width: 10)),
      child: Image.asset(
        'assets/text_encontrado.jpg',
        height: 100,
      ),
    );
  }

  Widget txt_main(String txt, double size) {
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

  Widget btn_options() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                btn_guardar(),
                btn_rep(),
              ],
            ),
            btn_return()
          ],
        ),
      ),
    );
  }

  Widget btn_guardar() {
    return Container(
        width: 150,
        height: 70,
        child: ButtonBar(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => biblioteca()));
              },
              icon: Icon(Icons.save),
              label: Text('Guardar Traducción', textAlign: TextAlign.center),
            ),
          ],
        ));
  }

  Widget btn_rep() {
    return Container(
        width: 150,
        height: 70,
        child: ButtonBar(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName('/home/img_selecc'));
              },
              icon: Icon(Icons.refresh),
              label:
                  Text('Seleccionar otra imagen', textAlign: TextAlign.center),
            ),
          ],
        ));
  }

  Widget btn_return() {
    return Container(
        width: 150,
        height: 60,
        child: ButtonBar(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => menu()));
              },
              icon: Icon(Icons.assignment_return),
              label: Text('Volver al menú', textAlign: TextAlign.center),
            ),
          ],
        ));
  }
}
