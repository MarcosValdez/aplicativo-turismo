import 'package:aplicativo_turismo/Turismo/bloc/pais_bloc.dart';
import 'package:aplicativo_turismo/Turismo/view/continente_list.dart';
import 'package:aplicativo_turismo/Turismo/view/paises_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PaisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => PaisBloc(httpClient: http.Client())..add(PostFetched()),
        
        child: Column(children: [ContinenteList(),PaisList()],) 
          
        //child: PaisList(),
      ),
    );
  }
}