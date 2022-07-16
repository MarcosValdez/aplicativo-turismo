import 'dart:convert';
import 'dart:io';

import 'package:aplicativo_turismo/calendar/model/task_model.dart';
import 'package:aplicativo_turismo/calendar/repo/api_status.dart';
import 'package:aplicativo_turismo/utils/constants.dart';
import 'package:http/http.dart' as http;

class TaskService {
  static Future<Object> getTasks() async {
    try {
      var uri = Uri.parse('$ENDPOINT/task');
      var response = await http.get(
        uri,
        headers: {"Content-Type": "application/json"},
      );

      // var jsondata = json.decode(response.body);
      // List<TaskModel> list = [];
      // for (var data in jsondata) {
      //   TaskModel n = TaskModel(
      //       user: data['user'],
      //       description: data['description'],
      //       date: data['date'],
      //       dateCreated: data['date_created']);
      //   list.add(n);
      // }
      if (200 == response.statusCode) {
        return Success(code: 200, reponse: taskModelFromJson(response.body));
      }
      return Failure(code: USER_INVALID_RESPNSE, reponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: NO_INTERNET, reponse: 'No internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, reponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, reponse: 'Unknown Error');
    }
  }

  static Future<http.Response> saveTask(
      String user, String description, String date) async {
    return await http.post(
      Uri.parse('$ENDPOINT/task'),
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
