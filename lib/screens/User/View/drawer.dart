import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../color_constants.dart';
import '../Model/user_model.dart';
import '../login.dart';
class drawerWidget extends StatefulWidget{
  @override
  _drawerWidgetState createState() => _drawerWidgetState();
}

class _drawerWidgetState extends State<drawerWidget>{



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
    return drawer_usuario();
  }

Widget drawer_usuario(){
  return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("${loggedInUser.email}"),
              accountEmail: Text("${user?.email}"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: ColorConstants.primaryColor,
              ),),
            cerrar_sesion(context)
          ],
        ),
      ),
    );
}

Widget cerrar_sesion(BuildContext context){
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