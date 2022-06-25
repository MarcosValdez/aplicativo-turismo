import 'package:aplicativo_turismo/routes.dart';
import 'package:aplicativo_turismo/screens/Translate/foto_galeria.dart';
import 'package:aplicativo_turismo/screens/Translate/imagen.dart';
import 'package:aplicativo_turismo/screens/User/login.dart';
import 'package:aplicativo_turismo/screens/menu.dart';
import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'color_constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTurismo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: ColorConstants.primaryColor,
              secondary: ColorConstants.secondaryColor),
          fontFamily: 'Georgia',
          textTheme: const TextTheme(
              titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
              bodySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Turismo'),
        ),
        backgroundColor: Colors.black38,
        body: LoginPage(),
      ),
      routes: {
        '/home': (context) => Menu(),
        '/home/img_selecc': (context) => imagen(),
      },
    );
  }
}
