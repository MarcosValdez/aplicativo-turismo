
import 'package:aplicativo_turismo/main.dart';
import 'package:aplicativo_turismo/screens/User/Model/user_model.dart';
import 'package:aplicativo_turismo/screens/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void signIn(String email, String password, _auth, _formKey, context) async {
  String? errorMessage;
  final prefs = await SharedPreferences.getInstance();
  if (_formKey.currentState!.validate()) {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
        Fluttertoast.showToast(msg: "Accediendo"),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyApp())),
        prefs.setString('email', email),
        prefs.setString('uid', uid.user!.uid),
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "El email no tiene el formato correcto.";

          break;
        case "wrong-password":
          errorMessage = "Contraseña incorrecta.";
          break;
        case "user-not-found":
          errorMessage = "Email no registrado.";
          break;
        case "user-disabled":
          errorMessage = "Usuario deshabilitado.";
          break;
        case "too-many-requests":
          errorMessage = "Demasiadas peticiones";
          break;
        case "operation-not-allowed":
          errorMessage = "Operacion no permitida.";
          break;
        default:
          errorMessage = "Ha ocurrido un error desconocido.";
      }
      Fluttertoast.showToast(msg: errorMessage);
      print(error.code);
    }
  }
}

void registroUsuario(String email, String password, _auth, _formKey, nombre, _paisselecto, context) async {
  String? errorMessage;
  if (_formKey.currentState!.validate()) {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(_auth, nombre, _paisselecto, context)})
          .catchError((e) {
        Fluttertoast.showToast(msg: e.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "El email no tiene el formato correcto.";

          break;
        case "user-disabled":
          errorMessage = "Usuario deshabilitado.";
          break;
        case "too-many-requests":
          errorMessage = "Demasiadas peticiones";
          break;
        case "operation-not-allowed":
          errorMessage = "Operacion no permitida.";
          break;
        default:
          errorMessage = "Ha ocurrido un error desconocido.";
      }
      Fluttertoast.showToast(msg: errorMessage, timeInSecForIosWeb: 3);
      print(error.code);
    }
  }
}

postDetailsToFirestore(_auth, nombre, _paisselecto, context) async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = _auth.currentUser;

  UserModel userModel = UserModel();

  userModel.email = user!.email;
  userModel.uid = user.uid;
  userModel.nombre = nombre.text;
  userModel.pais = _paisselecto;

  await firebaseFirestore
      .collection("users")
      .doc(user.uid)
      .set(userModel.toMap());
  Fluttertoast.showToast(
      msg: "Registro realizado con exito ", timeInSecForIosWeb: 2);

  Navigator.pushAndRemoveUntil((context),
      MaterialPageRoute(builder: (context) => Menu()), (route) => false);
}