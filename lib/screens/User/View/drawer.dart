import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../color_constants.dart';
import '../Model/user_model.dart';
import '../login.dart';

User? user = FirebaseAuth.instance.currentUser;
UserModel loggedInUser = UserModel();

Widget drawer_usuario(BuildContext context){
  return Drawer(
    child: Container(
      color: Colors.white,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("${loggedInUser.nombre}"),
            accountEmail: Text("${loggedInUser.email}"),
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