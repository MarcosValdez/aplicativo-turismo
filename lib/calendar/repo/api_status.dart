import 'package:aplicativo_turismo/calendar/model/task_model.dart';

class Success {
  int code;
  List<TaskModel> response;
  Success({required this.code, required this.response});
}

class Failure {
  int code;
  String message;
  Failure({required this.code, required this.message});
}
