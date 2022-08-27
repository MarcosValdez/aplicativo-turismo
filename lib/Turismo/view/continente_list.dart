import 'package:aplicativo_turismo/Turismo/bloc/pais_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContinenteList extends StatefulWidget {
  @override
  _ContinenteListState createState() => _ContinenteListState();
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("America"), value: "1"),
    DropdownMenuItem(child: Text("Europa"), value: "2"),
    DropdownMenuItem(child: Text("Asia"), value: "3"),
    DropdownMenuItem(child: Text("Africa"), value: "4"),
    DropdownMenuItem(child: Text("Australia"), value: "5"),
  ];
  return menuItems;
}

class _ContinenteListState extends State<ContinenteList> {
  final _scrollController = ScrollController();
  //final Continente continente;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaisBloc, PaisState>(builder: (context, state) {
      return Column(children: <Widget>[
        Container(
            margin: EdgeInsets.all(5),
            child: DropdownButtonFormField<String>(
              value: null,
              hint: Text("Seleccionar una opcion"),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.south_america_outlined),
                border: OutlineInputBorder(),
              ),
              isExpanded: true, //make true to make width 100%
              items: dropdownItems,
              onChanged: (value) {
                BlocProvider.of<PaisBloc>(context)
                    .add(PaisesFiltro(value, state.paises));
              },
            ))
      ]);
    });
  }
}
