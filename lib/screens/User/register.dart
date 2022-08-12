import 'package:aplicativo_turismo/screens/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Model/user_model.dart';
import '../../color_constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  bool _passwordVisible = false;
  String? errorMessage;

  final TextEditingController nombre = TextEditingController();
  final TextEditingController correo = TextEditingController();
  final TextEditingController contrasenia = TextEditingController();

  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$");

  static final RegExp _nombreRegExp = RegExp(r"^[a-zA-Z].{2,33}$");

  final _formKey = GlobalKey<FormState>();

  bool _esEmail(String str) {
    return _emailRegExp.hasMatch(str.toLowerCase());
  }

  bool _nombre(String str) {
    return _nombreRegExp.hasMatch(str.toLowerCase());
  }

  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              reverse: true,
              padding: EdgeInsets.all(32),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorConstants.fondoForms),
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.all(30),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      txt_blanco("Registro", 30),
                      columna(),
                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }

  Widget columna(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        divider_blanco(),
        name(),
        email(),
        contrasen(),
        btn_registrar(),
        divider_blanco(),
        szbox(),
        txt_blanco("¿Ya estas resgitrado?", 16),
        btn_login(),
      ],
    );
  }
  
  Widget name(){
    return Padding(
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
            validator: (value) {
              if (value!.isEmpty) {
                return "Ingresar nombre";
              } else {
                if (!_nombre(value.toString())) {
                  return "Nombre extenso";
                }
              }
            },
            onSaved: (value) {
              nombre.text = value!;
            },
          ),
        ],
      ),
    );
  }
  
  Widget email(){
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 10.0, horizontal: 0.0),
      child: Column(
        children: [
          Row(
            children:[
              txt_blanco("Email", 16)
            ],
          ),
          TextFormField(
            controller: correo,
            decoration: InputDecoration(
              hintText: 'Ingresa tu correo',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Ingresar correo";
              } else {
                if (!_esEmail(value.toString())) {
                  return "Correo invalido";
                }
              }
            },
            onSaved: (value) {
              correo.text = value!;
            },
          ),
        ],
      ),
    );
  }

  Widget contrasen(){
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 10.0, horizontal: 0.0),
      child: Column(
        children: [
          Row(
            children: [
              txt_blanco("Contraseña", 16)
            ],
          ),
          TextFormField(
            controller: contrasenia,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              hintText: 'Ingresa tu contraseña',
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: ColorConstants.primaryColor,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Ingresar contraseña";
              }
            },
            onSaved: (value) {
              contrasenia.text = value!;
            },
          ),
        ],
      ),
    );
  }

  Widget btn_registrar(){
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration:
                BoxDecoration(color: ColorConstants.secondaryColor),
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
    );
  }

  Widget divider_blanco(){
    return Divider(
      height: 20,
      color: Colors.white,
      thickness: 1.5,
    );
  }

  Widget szbox(){
    return SizedBox(
      height: 10,
    );
  }

  Widget txt_blanco(String text, double sz){
    return Text(
      text,
      style: TextStyle(fontSize: sz, color: Colors.white),
    );
  }

  Widget btn_login(){
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Iniciar sesión'),
    );
  }

  void registroUsuario(String email, String password) async {
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
        Fluttertoast.showToast(msg: errorMessage!, timeInSecForIosWeb: 3);
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
    Fluttertoast.showToast(
        msg: "Registro realizado con exito ", timeInSecForIosWeb: 2);

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => Menu()), (route) => false);
  }
}
