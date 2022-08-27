import 'package:aplicativo_turismo/calendar/model/task_model.dart';
import 'package:aplicativo_turismo/calendar/repo/task_service.dart';
import 'package:aplicativo_turismo/calendar/view_model/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarListTask extends StatelessWidget {
  CalendarListTask({required this.selectedDay});
  DateTime? selectedDay;
  final myController = TextEditingController();

  // CalendarListTask(DateTime? selectedDay);

  @override
  Widget build(BuildContext context) {
    TaskViewModel taskViewModel = context.watch<TaskViewModel>();
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    TaskModel taskModel = taskViewModel.taskListModel[index];
                    return InkWell(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();

                        final String? action = prefs.getString('uid');
                      },
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // AppTitle(text: taskModel.description),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    taskModel.description,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Text(
                                taskModel.date.toString(),
                                style: TextStyle(color: Colors.black),
                              )
                            ]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: taskViewModel.taskListModel.length))
        ],
      ),
    ));
  }
}
