import 'package:aplicativo_turismo/calendar/model/task_model.dart';

class Success {
  int code;
  List<TaskModel> reponse;
  Success({required this.code, required this.reponse});
}

class Failure {
  int code;
  String reponse;
  Failure({required this.code, required this.reponse});
}
