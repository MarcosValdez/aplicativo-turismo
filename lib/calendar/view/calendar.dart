import 'package:aplicativo_turismo/calendar/view_model/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:aplicativo_turismo/Calendar/view/calendar_modal.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    // TaskViewModel taskViewModel = context.watch<TaskViewModel>();
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime(1999),
              lastDay: DateTime(2050),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.green),
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
                        showMaterialModalBottomSheet(
                          expand: false,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => ModalFit(),
                        );
                      },
                      child: const Text('Crear nota'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
