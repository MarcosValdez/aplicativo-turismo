import 'package:aplicativo_turismo/color_constants.dart';
import 'package:aplicativo_turismo/screens/User/View/register.dart';
import 'package:aplicativo_turismo/screens/User/View/view_model_use.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool valuebox = true;
  bool _passwordVisible = false;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$");

  final _formKey = GlobalKey<FormState>();

  bool _esEmail(String str) {
    return _emailRegExp.hasMatch(str.toLowerCase());
  }

  String uuid = "";

  void initState() {
    _passwordVisible = false;
    // test();
  }

  void test() async {
    final prefs = await SharedPreferences.getInstance();

    uuid = prefs.getString('uid')!;
    // print("Login");
    // print(uuid);
  }

  @override
  Widget build(BuildContext context) {
    // if (uuid == "") {
    //   Navigator.of(context)
    //       .pushReplacement(MaterialPageRoute(builder: (context) => Menu()));
    //   return Container();
    // }

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
                  txt_blanco("Iniciar sesión", 30),
                  columna(),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget txt_blanco(String texto, double sz) {
    return Text(
      texto,
      style: TextStyle(fontSize: sz, color: Colors.white),
    );
  }

  Widget columna() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        divider_blanco(),
        email(),
        contrasenia(),
        // mant_abierta(),
        btn_ingresar(),
        divider_blanco(),
        sz_box(),
        txt_blanco("¿No estás registrado?", 16),
        btn_reg()
      ],
    );
  }

  Widget email() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              txt_blanco("Email", 16),
            ],
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Ingresa tu correo',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Ingrese correo";
              } else {
                if (!_esEmail(value.toString())) {
                  return "Email invalido";
                }
              }
            },
            onSaved: (value) {
              emailController.text = value!;
            },
          ),
        ],
      ),
    );
  }

  Widget contrasenia() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
      child: Column(
        children: [
          Row(
            children: [
              txt_blanco("Contraseña", 16),
            ],
          ),
          TextFormField(
            controller: passwordController,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              hintText: 'Ingresa tu contraseña',
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                return "Ingrese contraseña";
              }
            },
            onSaved: (value) {
              passwordController.text = value!;
            },
          ),
        ],
      ),
    );
  }

  Widget mant_abierta() {
    return Row(
      children: [
        Checkbox(
          value: valuebox,
          onChanged: (bool? value) {
            this.valuebox = value!;
          },
          activeColor: ColorConstants.secondaryColor,
        ),
        txt_blanco("Mantener abierta la sesion", 16)
      ],
    );
  }

  Widget btn_ingresar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(color: ColorConstants.secondaryColor),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                primary: Colors.white,
              ),
              onPressed: () {
                signIn(emailController.text, passwordController.text, _auth, _formKey, context);
              },
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider_blanco() {
    return Divider(
      height: 20,
      color: Colors.white,
      thickness: 1.5,
    );
  }

  Widget sz_box() {
    return SizedBox(
      height: 10,
    );
  }

  Widget btn_reg() {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
        //Navigator.pop(context);
      },
      child: const Text('Registrar'),
    );
  }
}
