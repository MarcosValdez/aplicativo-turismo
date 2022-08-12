import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class TranslateService{
  Future getTraduccionesEmail(String email) async
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
    return jsondata;
  }

  Future getTraducciones() async
  {
    var data = await http.get(Uri.parse('http://api-turismo-backend.herokuapp.com/biblioteca/listar'));
    var jsondata = json.decode(data.body);
    return jsondata;
  }

  Future deleteTraduccion(String id) async{
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
}