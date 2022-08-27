import 'package:aplicativo_turismo/color_constants.dart';
import 'package:aplicativo_turismo/screens/Translate/busqueda.dart';
import 'package:aplicativo_turismo/screens/Turism/lugarTuristico.dart';
import 'package:aplicativo_turismo/screens/User/login.dart';
import 'package:flutter/material.dart';

class BNavigation extends StatefulWidget {
  //VER MAS TARDE############################
  final Function currenIndex;
  const BNavigation({Key? key, required this.currenIndex}) : super(key: key);
  @override
  _BNavigatorState createState() => _BNavigatorState();
}

class _BNavigatorState extends State<BNavigation> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
          indicatorColor: ColorConstants.primaryColor,
          labelTextStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
      child: NavigationBar(
          backgroundColor: ColorConstants.fondoForms,
          selectedIndex: index,
          onDestinationSelected: (i) => setState(() {
                index = i;
                widget.currenIndex(i);
              }),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Inicio',
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              icon: Icon(Icons.camera_alt_outlined),
              label: 'Traducir',
              selectedIcon: Icon(Icons.camera),
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Calendario',
              selectedIcon: Icon(Icons.calendar_month),
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              label: 'Turismo',
              selectedIcon: Icon(Icons.airplane_ticket_outlined),
            ),
            NavigationDestination(
              icon: Icon(Icons.book_outlined),
              label: 'Biblioteca',
              selectedIcon: Icon(Icons.book),
            )
          ]),
    );
  }
}
