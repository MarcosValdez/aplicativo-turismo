import 'dart:async';

import 'package:aplicativo_turismo/calendar/model/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc()
      : super(TaskState(
          active: false,
          date: DateTime.now(),
          dateCreated: '',
          dateUpdate: '',
          description: '',
          taskId: '',
          userId: '',
        ));

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is GetTasks) {
      yield TaskState(
        active: false,
        date: DateTime.now(),
        dateCreated: '',
        dateUpdate: '',
        description: '',
        taskId: '',
        userId: '',
      );
    }
  }
}
