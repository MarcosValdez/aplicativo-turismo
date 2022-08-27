import 'dart:convert';

import 'package:aplicativo_turismo/Turismo/bloc/pais_bloc.dart';
import 'package:aplicativo_turismo/Turismo/view/continente_list.dart';
import 'package:aplicativo_turismo/Turismo/view/paises_list.dart';
import 'package:aplicativo_turismo/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CulturaPage extends StatefulWidget {
  late String pais;

  CulturaPage({required this.pais});

  @override
  _culturaState createState() => _culturaState();
}

class _culturaState extends State<CulturaPage> {
  var clik = List<bool>.filled(5, true);

  late List list;
  String URL = "https://turismo-backend-prueba.herokuapp.com/biblioteca/";
  Future getLista(pais) async {
    var url = Uri.parse(URL + 'listar-cultura/$pais');
    final response = await http.get(url, headers: {
      "Accept": "application/json",
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pais),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: getLista(widget.pais),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.error);
                }
                return snapshot.hasData
                    ? Expanded(
                        child: Scrollbar(
                            child: ListView.builder(
                        //mostrar datos en Listview
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          list = snapshot.data;
                          return Card(
                            child: ListTile(
                              tileColor: Color.fromRGBO(207, 235, 229, 1),
                              title: Text(list[index]['cultura']),
                              leading: Icon(Icons.nordic_walking_outlined),
                              trailing: IconButton(
                                icon: Icon((clik[index] == false)? Icons.star : Icons.star_border),
                                onPressed: () {
                                  setState(() {
                                    clik[index] = !clik[index];
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      )))
                    :Center(
                          child: CircularProgressIndicator(),
                    );
              })
        ],
        /* children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return null
                 ;
              },
            ),
          ),
        ], */
      ),
    );
  }
}
