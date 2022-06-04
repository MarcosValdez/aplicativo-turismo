import 'package:flutter/material.dart';
import 'imagen.dart';

class menu extends StatefulWidget{
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
            children: [
              btn_trad(),
              btn_tur(),
              btn_cal()
            ],
          ),
        ),
      ),
    );
  }
  Widget btn_trad(){
    return Container(
        margin: EdgeInsets.only(bottom: 30),
        child: ElevatedButton.icon(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage())
              );
            },
            icon: Icon(Icons.camera),
            label: Text('Traduccion', textAlign: TextAlign.center),
        )
    );
  }

  Widget btn_tur(){
    return Container(
      margin: EdgeInsets.only(top: 30),
        child: ElevatedButton.icon(onPressed: (){}
          , icon: Icon(Icons.travel_explore),
          label: Text('Informacion turistica', textAlign: TextAlign.center),
        )
    );
  }

  Widget btn_cal(){
    return Container(
        margin: EdgeInsets.only(top: 60, left: 20),
        child: Row(
          children: [
            Ink(
              decoration: ShapeDecoration(
                color: Colors.blue,
                shape: CircleBorder()
              ),
              child:
              IconButton(onPressed: (){}
                , icon: Icon(Icons.calendar_month),
                color: Colors.white,
              ),
            )
          ],
        ),
    );
  }
}