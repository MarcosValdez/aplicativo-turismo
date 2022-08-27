import 'dart:convert';

import 'package:aplicativo_turismo/color_constants.dart';
import 'package:aplicativo_turismo/screens/User/View/view_model_use.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_formfield/dropdown_formfield.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String _paisselecto;
  List futurepaisreg = [{"display":"asd","value":"asd"} ];
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
    _paisselecto='';
    _passwordVisible = false;
    dropform();
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
        DropDownFormField(
          titleText: 'Pais',
          hintText: 'Selecciona pais de procedencia',
          value: _paisselecto,
          onSaved: (value){
            setState((){
              _paisselecto=value;
            });
          },
          onChanged: (value) {
            setState(() {
              _paisselecto = value;
            });
          },
          dataSource: futurepaisreg,
          textField: 'display',
          valueField: 'value',

        ),
        btn_registrar(),
        divider_blanco(),
        szbox(),
        txt_blanco("¿Ya estas resgitrado?", 16),
        btn_login(),
      ],
    );
  }

  Future dropform() async{
    futurepaisreg = await fetchPaisReg();
    setState((){});
  }

  Future<List> fetchPaisReg() async {
    final response = await http.get(
      Uri.https(
          'api-turismo-backend.herokuapp.com',
          '/biblioteca/listar-todos-paises'
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return {"display": '${json['nombre']}', "value":'${json['nombre']}'};
      }).toList();
    }
    throw Exception('error fetching posts');

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
                    vertical: 12, horizontal: 10),
                primary: Colors.white,
              ),
              onPressed: () {
                registroUsuario(correo.text, contrasenia.text, _auth, _formKey, nombre, _paisselecto, context);
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
}