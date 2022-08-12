import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class TranslateModel
{
  String id;
  String email;
  String idm_origen;
  String idm_traduc;
  String txt_origen;
  String txt_traduc;
  String imagen;

  TranslateModel(this.id, this.email, this.idm_origen, this.idm_traduc, this.txt_origen, this.txt_traduc, this.imagen);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'idm_origen': idm_origen,
      'idm_traduc': idm_traduc,
      'txt_origen': txt_origen,
      'txt_traduc': txt_traduc,
      'imagen': imagen
    };
  }
}

Future<List<TranslateModel>> getTraduccionesEmail(String email) async
{
  var uri = Uri.parse('http://api-turismo-backend.herokuapp.com/biblioteca/listarEmail');
  Map datajson = {
    'email': email
  };
  var body = json.encode(datajson);
  var request = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  var jsondata = json.decode(request.body);
  List<TranslateModel>list = [];
  for (var data in jsondata) {
    TranslateModel n = new TranslateModel(
        data['doc_id'],
        data['email'],
        data['idm_origen'],
        data['idm_traduc'],
        data['txt_origen'],
        data['txt_traduc'],
        data['imagen']
    );
    list.add(n);
  }
  return list;
}



Future<List<TranslateModel>> getTraducciones() async
{
  var data = await http.get(Uri.parse('http://api-turismo-backend.herokuapp.com/biblioteca/listar'));
  var jsondata = json.decode(data.body);
  String id = "";
  List<TranslateModel>list = [];
  for (var data in jsondata) {
    TranslateModel n = new TranslateModel(
      data['doc_id'],
      data['email'],
      data['idm_origen'],
      data['idm_traduc'],
      data['txt_origen'],
      data['txt_traduc'],
      data['imagen']
    );
    list.add(n);
  }
  return list;
}

Future showTraducciones() async
{
  var data = await http.get(Uri.parse('http://api-turismo-backend.herokuapp.com/biblioteca/listar'));
  var jsondata = json.decode(data.body);
  List<TranslateModel>list = [];
  String id = "";
  for (var data in jsondata) {
    TranslateModel n = new TranslateModel(
        data['doc_id'],
        data['email'],
        data['idm_origen'],
        data['idm_traduc'],
        data['txt_origen'],
        data['txt_traduc'],
        data['imagen']
    );
    // print(n.toMap());
    list.add(n);
  }
}

void deleteTraduccion(String id) async{
  var uri = Uri.parse('http://api-turismo-backend.herokuapp.com/biblioteca/delete');
  Map datajson = {
    'id': id
  };
  var body = json.encode(datajson);
  await http.delete(
      uri,
      headers: {"Content-Type": "application/json"},
      body: body
  );
}

Future showTraduccionesEmail(String email) async
{
  var uri = Uri.parse('http://api-turismo-backend.herokuapp.com/biblioteca/listarEmail');
  Map datajson = {
    'email': email
  };
  var body = json.encode(datajson);
  var request = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: body
  );
  String id = "";
  var jsondata = json.decode(request.body);
  List<TranslateModel>list = [];
  for (var data in jsondata) {
    TranslateModel n = new TranslateModel(
      data['doc_id'],
      data['email'],
      data['idm_origen'],
      data['idm_traduc'],
      data['txt_origen'],
      data['txt_traduc'],
      data['imagen']
    );
    // print(n.toMap());
  }
}