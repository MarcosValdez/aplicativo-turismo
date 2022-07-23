part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class GetTasks extends TaskEvent {
  List<TaskModel> tasks;
  GetTasks(this.tasks);
}
