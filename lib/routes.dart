import 'package:aplicativo_turismo/Turismo/models/pais.dart';
import 'package:aplicativo_turismo/Turismo/view/pais_page.dart';
import 'package:aplicativo_turismo/calendar/view/calendar.dart';
import 'package:aplicativo_turismo/Dictionary/view/screen/dictionary_screen.dart';
import 'package:aplicativo_turismo/screens/Turism/continente.dart';
import 'package:aplicativo_turismo/screens/Translate/view/view_foto.dart';
import 'package:aplicativo_turismo/screens/principal.dart';
import 'package:flutter/material.dart';

class Routes extends StatelessWidget {
  final int index;
  final List continentes;
  const Routes({Key? key, required this.index, required this.continentes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      Principal(),
      // busqueda(),
      Imagen(),
      Calendar(),
      PaisPage(),
      DictionaryScreen(),
    ];
    return myList[index];
  }
}
