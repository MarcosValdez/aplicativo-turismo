import 'package:aplicativo_turismo/Calendar/model/task_model.dart';
import 'package:aplicativo_turismo/calendar/repo/task_service.dart';
import 'package:flutter/cupertino.dart';

class TaskViewModel extends ChangeNotifier {
  bool _loading = false;
  List<TaskModel> _taskListModel = [];

  bool get loading => _loading;
  List<TaskModel> get taskListModel => _taskListModel;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setTaskListModel(List<TaskModel> taskList) {
    _taskListModel = taskList;
  }

  getTasks() async {
    setLoading(true);
    var response = await TaskService.getTasks();
    setTaskListModel(response);
    setLoading(false);
  }
}
