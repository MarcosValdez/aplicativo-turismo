import 'package:flutter/material.dart';
import 'package:aplicativo_turismo/screens/User/login.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey),
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.all(30),
        child: Center(
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
                        const TextField(
                          decoration: InputDecoration(
                            hintText: 'Ingresa tu nombre',
                          ),
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
                        const TextField(
                          decoration: InputDecoration(
                            hintText: 'Ingresa tu correo',
                          ),
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
                        const TextField(
                          decoration: InputDecoration(
                              hintText: 'Ingresa tu contraseña'),
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
                              Navigator.pushNamed(context, '/home');
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage())
                      );
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
