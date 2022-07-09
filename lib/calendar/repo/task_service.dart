import 'dart:convert';

import 'package:aplicativo_turismo/Calendar/model/task_model.dart';
import 'package:http/http.dart' as http;

class TaskService {
  static Future<List<TaskModel>> getTasks() async {
    var uri = Uri.parse('http://api-turismo-backend.herokuapp.com/task');
    var request = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    var jsondata = json.decode(request.body);
    List<TaskModel> list = [];
    for (var data in jsondata) {
      TaskModel n = TaskModel(
          user: data['user'],
          description: data['description'],
          date: data['date'],
          dateCreated: data['date_created']);
      list.add(n);
    }
    return list;
  }

  static Future<http.Response> saveTask(
      String user, String description, String date) async {
    return await http.post(
      Uri.parse('http://api-turismo-backend.herokuapp.com/task'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'user': user,
        'description': description,
        'date': date,
        'date_created': ''
      }),
    );
  }
}
