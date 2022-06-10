import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class newnotePage extends StatefulWidget {
  @override
  _notesState createState() => _notesState();
}
class _notesState extends State<newnotePage>{
  TextEditingController txt_nota = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Notas'),
      ),
      backgroundColor: Colors.black87,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              txt_principal(),
              btn_guardar(),
              btn_salir()
            ],
          ),
        ),
      ),
    );
  }
  Widget txt_principal(){
    return Container(
        margin: EdgeInsets.all(20),
      child: TextFormField(
        controller: txt_nota,
        minLines: 20,
        maxLines: 20,
        keyboardType: TextInputType.multiline,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusColor: Colors.white,
          hintText: 'Escriba aquí',
          hintStyle: TextStyle(
              color: Colors.white
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      )
    );
  }
  Widget btn_guardar(){
    return Container(
        margin: EdgeInsets.only(bottom: 30),
        width: 150,
        height: 40,
        child: ElevatedButton.icon(
          onPressed: (){
            guardarNota();
          },
          icon: Icon(Icons.save),
          label: Text('Guardar Nota', textAlign: TextAlign.center),
        )
    );
  }
  Widget btn_salir(){
    return Container(
        margin: EdgeInsets.only(bottom: 30),
        width: 150,
        height: 40,
        child: ElevatedButton.icon(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.exit_to_app),
          label: Text('Descartar', textAlign: TextAlign.center),
        )
    );
  }

  guardarNota() async{
    try{
      await FirebaseFirestore.instance.collection('Note').doc().set(
          {
            "correo": "frank@gmail.com",
            "text": txt_nota.text,
          }
      );
    }catch(e){
      print("ERRO...."+ e.toString());
    }
  }
}