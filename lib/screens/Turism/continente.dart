import 'dart:convert';

import 'package:aplicativo_turismo/screens/Turism/pais.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../color_constants.dart';

class continente extends StatefulWidget {
  late String tipo_continente;
  late List tipo_continente_todos;
  continente({required this.tipo_continente, required this.tipo_continente_todos});

  @override
  _continenteState createState() => _continenteState();
}

class _continenteState extends State<continente> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String tipo = "0";

  late List list;
  bool _autoValidate = false;

  String URL = "https://api-turismo-backend.herokuapp.com/biblioteca/";

  Future getLista(tipo_continente) async{
    if (tipo_continente == "6") {
      var url = Uri.parse(URL+'listar-todos-paises');
      final response = await http.get(url, headers: {
        "Accept": "application/json",
      });
      // print("ssssssssssssssss"+response.body);
      return json.decode(response.body);
    }else{
      var url = Uri.parse(URL+'listar-paises/$tipo_continente');
      final response = await http.get(url, headers: {
        "Accept": "application/json",
      });
      // print("222222222222222222"+response.body);
      // print("--------------------------- ------------------");
      return json.decode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.secondaryColor,
        title: Text("Destinos a visitar", style: Theme.of(context).textTheme.bodySmall?.merge(TextStyle(color: Colors.white))),
      ),
      backgroundColor: Colors.grey,
      body: Container(
        color: ColorConstants.lightBackground,
        child: Form(
            key: _formKey,
            child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          _ListaContinentes(),
                          _btnBuscar(),
                        ],
                      )
                  ),
                  FutureBuilder(
                      future: getLista(widget.tipo_continente),
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        if(snapshot.hasData){
                          print(snapshot.error);
                        }
                        return snapshot.hasData
                            ?
                        Expanded(
                            child: Scrollbar(
                                child: ListView.builder( //mostrar datos en Listview
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index){

                                    list = snapshot.data;
                                    // print(index);
                                    // print(list);
                                    return
                                      Card(
                                        color: ColorConstants.cards,
                                        child: ListTile(
                                          title: Text(list[index]['nombre']),

                                        ),
                                      );
                                  },
                                )
                            ))
                            :Center(
                          child: CircularProgressIndicator(),
                        );}
                  ),
                ],
            ),
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }
  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('NOMBRE')),
    ];
  }
  List<DataRow> _createRows() {
    return list.map((book) => DataRow(cells: [
      DataCell(Text(book['nombre'])),
    ])).toList();
  }
  
  Widget _ListaContinentes(){
    return  DropdownButtonFormField<String>(
      value: null,
      hint: Text("Seleccionar una opcion"),
      dropdownColor: ColorConstants.primaryColor, //dropdown background color
      isExpanded: true, //make true to make width 100%
      items: widget.tipo_continente_todos.map((list) {
        // print(list);
        return DropdownMenuItem<String>(
          value: list["codigo"],
          child: Text(list["nombre"], style: TextStyle(color: Colors.white),),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          tipo=value!;
          // print("------------------"+tipo);
        });

      },

    )
    ;
  }

  Widget _btnBuscar(){
    return MaterialButton(
        minWidth: 500.0,
        onPressed:(){
          _validar();
        },
        color: ColorConstants.primaryColor,
        child: Text('Buscar', style: TextStyle(color: Colors.white))
    );
  }

  void _validar(){
    if (_formKey.currentState!.validate() && tipo != "0") {
      _formKey.currentState!.save();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder:(BuildContext context){
                return new continente(tipo_continente: tipo, tipo_continente_todos: widget.tipo_continente_todos,);
              }),
              (Route route)=>false
      );
    } else {
      setState(() {
        _autoValidate=true;
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('AlertDialog Title'),
              content: const Text('Seleccione el tipo de Cartera'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            )
        );
      });
    }
  }

  Widget _boton(String texto) {
    return SizedBox(
        height: 90,
        width: 250,
        child: RaisedButton(
          child: Text(
            texto,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0),
          ),
          color: Colors.blue,
          elevation: 5,
          padding: EdgeInsets.all(30),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pais()),
            ),
          },
        ));
  }

}

