

import 'package:aplicativo_turismo/screens/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aplicativo_turismo/screens/User/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Model/User/user_model.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  final TextEditingController nombre = TextEditingController();
  final TextEditingController correo = TextEditingController();
  final TextEditingController contrasenia = TextEditingController();





  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$");

  static final RegExp _nombreRegExp = RegExp(
      r"^[a-zA-Z].{2,33}$");

  final _formKey = GlobalKey<FormState>();

  bool _esEmail(String str){
    return _emailRegExp.hasMatch(str.toLowerCase());
  }

  bool _nombre(String str){
    return _nombreRegExp.hasMatch(str.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Container(

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey),
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.all(30),

        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Registro",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Divider(
                    height: 30,
                    color: Colors.white,
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 0.0),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Nombre',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: nombre,
                          decoration: InputDecoration(
                            hintText: 'Ingresa tu nombre',
                          ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "Ingresar nombre";
                              }else{
                                if(!_nombre(value.toString())){
                                  return "Nombre extenso";
                                }
                              }
                            },
                          onSaved: (value){
                            nombre.text = value!;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 0.0),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Email',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        TextFormField(
                            controller: correo,
                          decoration: InputDecoration(
                            hintText: 'Ingresa tu correo',
                          ),
                            validator: (value){

                              if(value!.isEmpty){
                                return "Ingresar correo";
                              }else{
                                if(!_esEmail(value.toString())){
                                  return "Correo invalido";
                                }
                              }
                            },
                          onSaved: (value){
                              correo.text = value!;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 0.0),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Contraseña',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        TextFormField(
                            controller: contrasenia,
                          decoration: InputDecoration(
                              hintText: 'Ingresa tu contraseña'),
                            validator: (value){
                              if(value!.isEmpty){
                                return "Ingresar contraseña";
                              }
                            },
                          onSaved: (value){
                              contrasenia.text = value!;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.blue),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 80),
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              registroUsuario(correo.text, contrasenia.text);
                            },
                            child: const Text('Registrar'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 20,
                    color: Colors.white,
                    thickness: 1.5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '¿Ya estas registrado?',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Iniciar sesión'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void registroUsuario(String email, String password) async{
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  postDetailsToFirestore() async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.nombre = nombre.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Registro realizado con exito ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => menu()),
            (route) => false);
  }
}
