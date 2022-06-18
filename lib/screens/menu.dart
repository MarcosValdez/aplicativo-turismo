import 'package:aplicativo_turismo/BNavigation.dart';
import 'package:aplicativo_turismo/Model/User/user_model.dart';
import 'package:aplicativo_turismo/routes.dart';
import 'package:aplicativo_turismo/screens/Dicctionary/biblioteca.dart';
import 'package:aplicativo_turismo/screens/Turism/continente.dart';
import 'package:aplicativo_turismo/screens/Calendar/calendar.dart';
import 'package:aplicativo_turismo/screens/Notes/new_note.dart';
import 'package:aplicativo_turismo/screens/Notes/view_notes.dart';
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
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(50),
                child: Icon(Icons.person_rounded, color: Colors.blue, size: 100,),
              ),
              Container(
                margin: EdgeInsets.all(10),
                  child: Text("${loggedInUser.nombre}", style: TextStyle(fontSize: 20))
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text("${loggedInUser.email}", style: TextStyle(fontSize: 20))
              ),
              ElevatedButton.icon(
                  onPressed: (){
                    logout(context);
                  },
                  icon: Icon(Icons.logout),
                  label: Text("Cerrar sesion"))
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

  Widget btn_note() {
    return Container(
        margin: EdgeInsets.only(top: 30),
        width: 150,
        height: 40,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => notePage()));
          },
          icon: Icon(Icons.travel_explore),
          label: Text('Notas', textAlign: TextAlign.center),
        ));
  }

  Widget btn_newnote() {
    return Container(
        margin: EdgeInsets.only(top: 30),
        width: 150,
        height: 40,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => newnotePage()));
          },
          icon: Icon(Icons.travel_explore),
          label: Text('nueva nota', textAlign: TextAlign.center),
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
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
