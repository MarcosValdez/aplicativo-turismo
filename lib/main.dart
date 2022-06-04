import 'package:aplicativo_turismo/screens/Translate/imagen.dart';
import 'package:aplicativo_turismo/screens/User/register.dart';
import 'package:aplicativo_turismo/screens/menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTurismo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
      routes: {
        '/home': (context) => menu(),
        '/home/img_selecc': (context) => imagen(),
      },
    );
  }
}
