import 'package:flutter/material.dart';

class traduccion extends StatefulWidget{
  @override
  _traduccionState createState() => _traduccionState();
}

class _traduccionState extends State<traduccion>{
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
  Widget txt_header(){
    return Container(
      margin: EdgeInsets.all(50),
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              txt_main('Texto Encontrado', 20),
            ],
          )
      ),
    );
  }

  Widget txt_traduccion(){
    return Container(
      margin: EdgeInsets.all(50),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            txt_idmoriginal(),
            txt_idmobjetivo()
          ],
        )
      ),
    );
  }
  
  Widget txt_idmoriginal(){
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            txt_main('Idioma Original',14),
            txt_main('Ruso',14),
            txt_main('CTOП',20),
          ],
        )
      )
    );
  }

  Widget txt_idmobjetivo(){
    return Container(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                txt_main('Español',14),
                txt_main('DETENGASE',20),
              ],
            )
        )
    );
  }

  Widget img_encontrado(){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.white,
              width: 10
          )
      ),
      child: Image.asset('assets/text_encontrado.jpg', height: 100,),
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

  Widget btn_options(){
    return Container(
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              btn_guardar(),
              btn_return()
            ],
          )
      ),
    );
  }

  Widget btn_guardar(){
    return Container(
      width: 150,
      height: 60,
      child: ButtonBar(
        children: [
          ElevatedButton.icon(
            onPressed: (){

            },
            icon: Icon(Icons.save),
            label: Text('Guardar Traducción', textAlign: TextAlign.center),
          ),
        ],
      )
    );
  }

  Widget btn_return(){
    return Container(
      width: 150,
      height: 60,
      child: ButtonBar(
        children: [
          ElevatedButton.icon(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.assignment_return),
            label: Text('Tomar otra foto', textAlign: TextAlign.center),
          ),
        ],
      )
    );
  }
}