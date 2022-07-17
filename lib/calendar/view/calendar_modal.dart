import 'package:aplicativo_turismo/calendar/repo/task_service.dart';
import 'package:aplicativo_turismo/calendar/view_model/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalFit extends StatelessWidget {
  ModalFit({required this.selectedDay});
  DateTime? selectedDay;
  final myController = TextEditingController();

  // ModalFit(DateTime? selectedDay);

  @override
  Widget build(BuildContext context) {
    TaskViewModel taskViewModel = context.watch<TaskViewModel>();
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 8, //or null
              decoration: const InputDecoration.collapsed(
                  hintText: "Ingresa la nota ..."),
              controller: myController,
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.blue),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 80),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      TaskService.saveTask(
                          '2', myController.text, selectedDay.toString());
                      Navigator.of(context).pop();
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    ));
  }
}
