import 'package:aplicativo_turismo/screens/User/login.dart';
import 'package:aplicativo_turismo/screens/Translate/imagen.dart';
import 'package:aplicativo_turismo/screens/User/register.dart';
import 'package:aplicativo_turismo/screens/menu.dart';

import 'package:flutter/material.dart';

// Firebase
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// To use firebase
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

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
      ),
      routes: {
        '/home': (context) => menu(),
        '/home/img_selecc': (context) => imagen(),
      },
    );
  }
}
