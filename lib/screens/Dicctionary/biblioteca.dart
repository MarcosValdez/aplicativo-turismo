import 'package:aplicativo_turismo/screens/Dicctionary/idioma.dart';
import 'package:flutter/material.dart';

class biblioteca extends StatefulWidget{
  @override
  _bibliotecaState createState() => _bibliotecaState();
}

class _bibliotecaState extends State<biblioteca>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Biblioteca de traducciones'),
      ),
      backgroundColor: Colors.black87,
      body: Container(
        child: Column(
          children: [
            list_idiomas()
          ],
        ),
      ),
    );
  }
  Widget list_idiomas(){
    return Container(
      margin: EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Column(
        children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => idioma())
                    );
                  },
                  child: Text(
                    'Ingles', style: TextStyle(color: Colors.white,),
                  ),
                ),
              ],
            ),
          Divider(color: Colors.white,),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => idioma())
                  );
                },
                child: Text(
                  'Portugues', style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Divider(color: Colors.white,),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => idioma())
                  );
                },
                child: Text(
                  'Frances', style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Divider(color: Colors.white,),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => idioma())
                  );
                },
                child: Text(
                  'Ruso', style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }


}