import 'package:aplicativo_turismo/Model/Translate/translate_model.dart';
import 'package:flutter/material.dart';
import 'package:aplicativo_turismo/Model/User/user_model.dart';
import 'package:aplicativo_turismo/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DictionaryWidget extends StatefulWidget{
  State<StatefulWidget> createState(){
    return _DictionaryWidgetState();
  }
}

class _DictionaryWidgetState extends State<DictionaryWidget>{
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
    return listaWidget();
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
        //child: Center(
        child: Column(
          children: [
            img_encontrado(),
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: txt_idmoriginal(txt_origen, idm_origen),
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox()
                  ),
                  Expanded(
                    flex: 5,
                    child: txt_idmobjetivo(txt_traduc, idm_traduc),
                  )
                ]
            ),
            btn_delete(id, context)
          ],
        )
      //),
    );
  }

  Widget btn_delete(String id, BuildContext context){
    return Container(
        width: 150,
        height: 70,
        child: ButtonBar(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                deleteTraduccion(id);
                Navigator.pushNamed(context, '/biblioteca');
              },
              icon: Icon(Icons.delete),
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
      child: bold? Text(
        txt,
        style: TextStyle(
          color: ColorConstants.primaryTextColor,
          fontFamily: 'Roboto',
          fontSize: size,
          fontWeight: FontWeight.bold,
        ),
      ): Text(
        txt,
        style: TextStyle(
          color: ColorConstants.primaryTextColor,
          fontFamily: 'Roboto',
          fontSize: size,
        ),
      ),
    );
  }

  Widget scr_loading(){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          txt_main("Cargando", 20, false)
        ],
      ),
    );
  }
  Widget scr_empty(){
    return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              txt_main("No existen traducciones guardadas", 20, false)
            ],
          ),
        )
    );
  }
  Widget listaWidget(){
    return FutureBuilder<List<TranslateModel>>(
      future: getTraduccionesEmail(loggedInUser.email.toString()),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) {
          return scr_loading();
        }
        if(snapshot.hasError) {
          // return: show error widget
        }
        List<TranslateModel> traducciones = snapshot.data ?? [];
        if(traducciones.isEmpty){
          return scr_empty();
        }
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