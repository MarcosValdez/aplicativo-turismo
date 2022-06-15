import 'package:aplicativo_turismo/BNavigation.dart';
import 'package:aplicativo_turismo/routes.dart';
import 'package:aplicativo_turismo/screens/Calendar/calendar.dart';
import 'package:aplicativo_turismo/screens/Dicctionary/idioma.dart';
import 'package:aplicativo_turismo/screens/Translate/busqueda.dart';
import 'package:aplicativo_turismo/screens/Translate/foto_galeria.dart';
import 'package:aplicativo_turismo/screens/Turism/continente.dart';
import 'package:aplicativo_turismo/screens/Turism/lugarTuristico.dart';
import 'package:aplicativo_turismo/screens/User/login.dart';
import 'package:aplicativo_turismo/screens/Translate/imagen.dart';
import 'package:aplicativo_turismo/screens/User/register.dart';
import 'package:aplicativo_turismo/screens/menu.dart';

import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// To use firebase
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

/*void main() {
  Firebase.initializeApp();
  runApp(const MyApp());
}*/

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  BNavigation? myBNB;
  @override
  void initState(){
    myBNB = BNavigation(currenIndex: (i){
      setState((){
        index = i;
      });
    });
    super.initState();
  }

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
          title: Text('Turismo'),
        ),
        backgroundColor: Colors.black38,
        bottomNavigationBar: myBNB,
        body: Routes(index: index),
        /*Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.grey),
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.all(30),
          child: screens[index],
        ),*/

      ),
      routes: {
        '/home': (context) => menu(),
        '/home/img_selecc': (context) => Imagen(),
      },
    );
  }
}
