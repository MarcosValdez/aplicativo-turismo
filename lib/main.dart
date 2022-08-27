import 'package:aplicativo_turismo/calendar/bloc/task_bloc.dart';
import 'package:aplicativo_turismo/calendar/view_model/task_view_model.dart';
import 'package:aplicativo_turismo/Dictionary/view/screen/dictionary_screen.dart';
import 'package:aplicativo_turismo/screens/Translate/imagen.dart';
import 'package:aplicativo_turismo/screens/Translate/view/CargaImagen.dart';
import 'package:aplicativo_turismo/screens/User/login.dart';
import 'package:aplicativo_turismo/screens/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dictionary/view/screen/dictionary_screen.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TaskViewModel())],
      // providers: [BlocProvider<TaskBloc>(create: (_)=>TaskBloc())],
      child: MaterialApp(
        title: 'AppTurismo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: ColorConstants.primaryColor,
                secondary: ColorConstants.secondaryColor),
            fontFamily: 'Georgia',
            textTheme: const TextTheme(
                titleLarge:
                    TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
                bodySmall:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Turismo'),
          ),
          backgroundColor: Colors.black38,
          body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot){
              if (snapshot.hasData){
                return Menu();
              }
              else{
                return LoginPage();
              }
            },
          ),
        ),
        routes: {
          '/home': (context) => Menu(),
          '/biblioteca': (context) => DictionaryScreen(),
          '/home/img_selecc': (context) => CargaImagen(),
        },
      ),
    );
  }
}
