import 'package:flutter/material.dart';
import 'package:aplicativo_turismo/Model/Translate/translate_model.dart';
import 'package:aplicativo_turismo/Model/User/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';


class idioma extends StatefulWidget{
  @override
  _idiomaState createState() => _idiomaState();
}

class _idiomaState extends State<idioma> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Biblioteca'),
      ),
      backgroundColor: Colors.black87,
      body: listaWidget()
    );
  }
  Widget itemTraduccion(
    String id,
    String idm_origen,
    String idm_traduc,
    String txt_origen,
    String txt_traduc,
    String imagen,
  ){
    return Container(
      margin: EdgeInsets.all(20),
      child: Center(
          child: Column(
            children: [
              img_encontrado(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  txt_idmoriginal(txt_origen, idm_origen),
                  txt_idmobjetivo(txt_traduc, idm_traduc)],
              ),
              btn_delete(id)
            ],
          )
      ),
    );
  }

  Widget btn_delete(String id){
    return Container(
      width: 150,
      height: 70,
      child: ButtonBar(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              deleteTraduccion(id);
            },
            icon: Icon(Icons.save),
            label: Text('Eliminar', textAlign: TextAlign.center),
          ),
        ],
      )
    );
  }
  Widget img_encontrado() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 10)),
      child: Image.asset(
        'assets/text_encontrado.jpg',
        height: 100,
      ),
    );
  }

  Widget txt_idmoriginal(String txt, String idm) {
    return Container(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                txt_main(idm, 14, false),
                txt_main(txt, 18, true),
              ],
            )));
  }

  Widget txt_idmobjetivo(String txt, String idm) {
    return Container(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                txt_main(idm, 14, false),
                txt_main(txt, 18, true),
              ],
            )));
  }

  Widget txt_main(String txt, double size, bool bold) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: bold? Text(
        txt,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: size,
          fontWeight: FontWeight.bold
        ),
      ): Text(
        txt,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: size,
        ),
      ),
    );
  }

  Widget listaWidget(){
    return FutureBuilder<List<TranslateModel>>(
        future: getTraduccionesEmail(loggedInUser.email.toString()),
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done) {
            // return: show loading widget
          }
          if(snapshot.hasError) {
            // return: show error widget
          }
          List<TranslateModel> traducciones = snapshot.data ?? [];
          return ListView.builder(
            itemCount: traducciones.length,
            itemBuilder: (context, index) {
              TranslateModel t = traducciones[index];
              return itemTraduccion(t.id, t.idm_origen, t.idm_traduc, t.txt_origen, t.txt_traduc, t.imagen);
            },
          );
        },

    );

  }
}
