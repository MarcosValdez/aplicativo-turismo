import 'dart:convert';
import 'dart:io';

import 'package:aplicativo_turismo/calendar/model/task_model.dart';
import 'package:aplicativo_turismo/calendar/repo/api_status.dart';
import 'package:aplicativo_turismo/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  static Future<Object> getTasks() async {
    try {
      // var user = '2';
      final prefs = await SharedPreferences.getInstance();

      final String? uid = prefs.getString('uid');
      var uri = Uri.parse('$ENDPOINT/task/user/$uid');
      var response = await http.get(
        uri,
        headers: {"Content-Type": "application/json"},
      );
      // print(response.body);
      if (200 == response.statusCode) {
        return Success(code: 200, response: taskModelFromJson(response.body));
      }
      return Failure(code: USER_INVALID_RESPNSE, message: 'Invalid Response');
    } on HttpException {
      return Failure(code: NO_INTERNET, message: 'No internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, message: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, message: 'Unknown Error');
    }
  }

  static Future<http.Response> saveTask(
      String user, String description, String date) async {
    return await http.post(
      Uri.parse('$ENDPOINT/task/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'user_id': user,
        'description': description,
        'date': date,
        'date_created': ''
      }),
    );
  }
}
