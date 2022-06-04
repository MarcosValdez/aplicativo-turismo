import 'package:aplicativo_turismo/screens/register.dart';
import 'package:aplicativo_turismo/screens/login.dart';
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
      home: Scaffold(
        appBar: AppBar(
        ),
        backgroundColor: Colors.black38,

        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.grey),
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.all(30),
          child: LoginPage(),
        ),
      )
    );
  }
}
