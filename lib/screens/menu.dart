import 'dart:convert';
import 'package:aplicativo_turismo/color_constants.dart';
import 'package:aplicativo_turismo/screens/User/View/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:aplicativo_turismo/BNavigation.dart';
import 'package:aplicativo_turismo/screens/User/Model/user_model.dart';
import 'package:aplicativo_turismo/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _menuState createState() => _menuState();
}

class _menuState extends State<Menu> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  int index = 0;
  late List continentes;
  BNavigation? myBNB;

  @override
  void initState(){
    continentes = [];
    myBNB = BNavigation(currenIndex: (i){
      setState((){
        index = i;
      });
    });
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState((){});
    });
    listaContinentes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer_usuario(context),
      appBar: AppBar(
        title: Text('Grupo 01'),
      ),
      backgroundColor: ColorConstants.lightBackground,
      bottomNavigationBar: myBNB,

      body: Routes(index: index, continentes: continentes)

    );
  }

  Future listaContinentes() async{
    var url = Uri.parse('https://api-turismo-backend.herokuapp.com/biblioteca/listar-continentes');
    final response = await http.get(url,headers:{
      "Accept": "application/json",
    });
    continentes = json.decode(response.body);
    return continentes;
  }
}
