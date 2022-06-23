import 'package:aplicativo_turismo/screens/Calendar/calendar.dart';
import 'package:aplicativo_turismo/screens/Turism/continente.dart';
import 'package:aplicativo_turismo/screens/Translate/foto_galeria.dart';
import 'package:aplicativo_turismo/screens/principal.dart';
import 'package:flutter/material.dart';

class Routes extends StatelessWidget {

  final int index;
  const Routes ({Key? key, required this.index}): super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      Principal(),
      // busqueda(),
      Imagen(),
      Calendar(),
      continente(),
    ];
    return myList[index];
  }

}