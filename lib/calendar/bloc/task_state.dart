part of 'task_bloc.dart';

class TaskState {
  TaskState({
    required this.active,
    required this.date,
    required this.dateCreated,
    required this.dateUpdate,
    required this.description,
    required this.taskId,
    required this.userId,
  });


  bool active;
  DateTime date;
  String dateCreated;
  String dateUpdate;
  String description;
  String taskId;
  String userId;
}
