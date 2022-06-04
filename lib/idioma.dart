import 'package:flutter/material.dart';

class idioma extends StatefulWidget{
  @override
  _idiomaState createState() => _idiomaState();
}

class _idiomaState extends State<idioma> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Traducciones en ruso'),
      ),
      backgroundColor: Colors.black87,
      body: Container(
        child: Column(
          children: [
            traduccion()
          ],
        ),
      ),
    );
  }
  Widget traduccion(){
    return Container(
      margin: EdgeInsets.only(top:30),
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imagen(),
              texto()
            ],
          )
      ),
    );
  }

  Widget imagen(){
    return Container(
      margin: EdgeInsets.only(right: 15),
        child: Image.asset('assets/text_encontrado.jpg', height: 100,)
    );
  }

  Widget texto(){
    return Container(
      child: Text('DETENGASE', style: TextStyle(color: Colors.white),),
    );
  }
}