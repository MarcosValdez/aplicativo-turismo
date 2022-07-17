import 'package:aplicativo_turismo/calendar/model/task_error.dart';
import 'package:aplicativo_turismo/calendar/model/task_model.dart';
import 'package:aplicativo_turismo/calendar/repo/api_status.dart';
import 'package:aplicativo_turismo/calendar/repo/task_service.dart';
import 'package:flutter/material.dart';

class TaskViewModel extends ChangeNotifier {
  bool _loading = false;
  List<TaskModel> _taskListModel = [];
  TaskError? _taskError;

  bool get loading => _loading;
  List<TaskModel> get taskListModel => _taskListModel;
  TaskError? get taskError => _taskError;

  TaskViewModel() {
    getTasks();
  }
  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setTaskListModel(List<TaskModel> taskList) {
    _taskListModel = taskList;
  }

  setTaskError(TaskError taskError) {
    _taskError = taskError;
  }

  getTasks() async {
    setLoading(true);
    var response = await TaskService.getTasks();
    if (response is Success) {
      List<TaskModel> taskList = response.response;
      setTaskListModel(taskList);
    }
    if (response is Failure) {
      TaskError taskError =
          TaskError(code: response.code, message: response.message);
      setTaskError(taskError);
      print(taskError.message);
    }
    setLoading(false);
  }
}
