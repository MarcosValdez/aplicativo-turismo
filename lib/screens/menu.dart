import 'package:aplicativo_turismo/screens/Dicctionary/biblioteca.dart';
import 'package:aplicativo_turismo/screens/Turism/continente.dart';
import 'package:aplicativo_turismo/screens/Calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'Translate/imagen.dart';

class menu extends StatefulWidget {
  @override
  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [btn_trad(), btn_biblio(), btn_tur(), btn_cal()],
          ),
        ),
      ),
    );
  }

  Widget btn_trad() {
    return Container(
        margin: EdgeInsets.only(bottom: 30),
        width: 150,
        height: 40,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, '/home/img_selecc');
          },
          icon: Icon(Icons.camera),
          label: Text('Traduccion', textAlign: TextAlign.center),
        ));
  }

  Widget btn_biblio() {
    return Container(
        margin: EdgeInsets.only(bottom: 30),
        width: 150,
        height: 40,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => biblioteca()));
          },
          icon: Icon(Icons.book),
          label: Text('Biblioteca', textAlign: TextAlign.center),
        ));
  }

  Widget btn_tur() {
    return Container(
        margin: EdgeInsets.only(top: 30),
        width: 150,
        height: 40,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => continente()));
          },
          icon: Icon(Icons.travel_explore),
          label: Text('Informacion turistica', textAlign: TextAlign.center),
        ));
  }

  Widget btn_cal() {
    return Container(
      margin: EdgeInsets.only(top: 60, left: 20),
      child: Row(
        children: [
          Ink(
            decoration:
                ShapeDecoration(color: Colors.blue, shape: CircleBorder()),
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Calendar()));
              },
              icon: Icon(Icons.calendar_month),
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
