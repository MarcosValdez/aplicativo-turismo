import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aplicativo_turismo/screens/User/login.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController contrasenia = TextEditingController();

  registroUsuraio() async {
    try {
      await FirebaseFirestore.instance.collection('User').doc().set({
        "nombre": nombre.text,
        "correo": correo.text,
        "contrasenia": contrasenia.text
      });
    } catch (e) {
      print("ERRO...." + e.toString());
    }
  }

  /*Validaciones*/
  bool value = true;

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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Ingresar nombre";
                              } else {
                                if (!_nombre(value.toString())) {
                                  return "Nombre extenso";
                                }
                              }
                            }),
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Ingresar correo";
                              } else {
                                if (!_esEmail(value.toString())) {
                                  return "Correo invalido";
                                }
                              }
                            }),
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Ingresar contraseña";
                              }
                            }),
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
                              /*if(_formKey.currentState!.validate()){
                                Navigator.pushNamed(context, '/home');
                              }*/
                              print("datos:\n");
                              print(nombre.text);
                              print(correo.text);
                              print(contrasenia.text);
                              registroUsuraio();
                              print("usuario registrado");
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
}
