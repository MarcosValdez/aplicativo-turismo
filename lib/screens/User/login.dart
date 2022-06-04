import 'package:aplicativo_turismo/screens/User/register.dart';
import 'package:aplicativo_turismo/screens/menu.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool valuebox = true;

  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");

  final _formKey = GlobalKey<FormState>();

  bool _esEmail(String str){
    return _emailRegExp.hasMatch(str.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Form(

        key: _formKey,

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Iniciar sesión",
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
                        vertical: 20.0, horizontal: 0.0),
                    child: Column(
                      children: [
                        Row(
                          children: const<Widget> [
                            Text(
                              'Email',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),

                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Ingresa tu correo',
                          ),
                            validator: (value){

                              if(value!.isEmpty){
                                return "Ingrese correo";
                              }else{
                                if(!_esEmail(value.toString())){
                                  return "Email invalido";
                                }
                              }
                            }
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 0.0),
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
                          decoration: InputDecoration(
                              hintText: 'Ingresa tu contraseña'),
                            validator: (value){
                              if(value!.isEmpty){
                                return "Ingrese contraseña";
                              }
                            }
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: valuebox,
                        onChanged: (bool? value) {
                          this.valuebox = value!;
                        },
                      ),
                      const Text(
                        'Mantener abierta la sesión',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
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

                              print('inicio');
                              if(_formKey.currentState!.validate()){
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("accesando al sistema"))
                                );
                                print('intermedio');
                              }
                              print('final');
                              Navigator.pushNamed(context, '/home');

                            },
                            child: const Text('Ingresar'),
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
                    '¿No estas registrado?',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage())
                      );
                      //Navigator.pop(context);
                    },
                    child: const Text('Registrar'),
                  ),
                ],
              )
            ],
          ),
        ),
    );
  }
}
