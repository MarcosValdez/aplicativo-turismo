import 'package:aplicativo_turismo/BNavigation.dart';
import 'package:aplicativo_turismo/Model/User/user_model.dart';
import 'package:aplicativo_turismo/routes.dart';
import 'package:aplicativo_turismo/screens/User/login.dart';
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
  BNavigation? myBNB;

  @override
  void initState(){
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              icono_usuario(),
              mostrar_dato("${loggedInUser.nombre}"),
              mostrar_dato("${loggedInUser.email}"),
              cerrar_sesion()
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Grupo 01'),
      ),
      backgroundColor: Colors.black87,
      bottomNavigationBar: myBNB,

      body: Routes(index: index),

    );
  }

  Widget icono_usuario(){
    return Container(
      height: 100,
      width: 100,
      margin: EdgeInsets.all(50),
      child: Icon(Icons.person_rounded, color: Colors.blue, size: 100,),
    );
  }

  Widget mostrar_dato (String texto){
    return Container(
        margin: EdgeInsets.all(10),
        child: Text(texto, style: TextStyle(fontSize: 20))
    );
  }

  Widget cerrar_sesion(){
    return ElevatedButton.icon(
        onPressed: (){
          logout(context);
        },
        icon: Icon(Icons.logout),
        label: Text("Cerrar sesion"));

  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
