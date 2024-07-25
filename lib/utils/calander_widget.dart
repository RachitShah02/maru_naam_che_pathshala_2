import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Table(
              children: _buildCalendar(_daysInMonth(now)),
            ),
          ],
        ),
      ),
    );
  }

  List<DateTime> _daysInMonth(DateTime date) {
    var lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    return List.generate(lastDayOfMonth.day,
        (index) => DateTime(date.year, date.month, index + 1));
  }

  List<TableRow> _buildCalendar(List<DateTime> daysInMonth) {
    List<TableRow> rows = [];

    // Add header row with day names starting from Sunday
    rows.add(TableRow(
      children: List.generate(7, (index) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat.E().format(
                  DateTime(2021, 8, index + 1)), // 2021-08-01 is a Sunday
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
        );
      }),
    ));

    int weekDay = daysInMonth.first.weekday %
        7; // Adjusting to start from Sunday (0 = Sunday)
    List<Widget> week = [];

    // Fill the first week with empty cells if necessary
    for (int i = 0; i < weekDay; i++) {
      week.add(Container());
    }

    for (var day in daysInMonth) {
      week.add(
        Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: day.day.toInt() % 2 == 0
                  ? AppColors.primaryColor
                  : Colors.greenAccent,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: day.day.toString().text.bold.make(),
            ),
          ),
        ),
      );

      if (week.length == 7) {
        rows.add(TableRow(children: week));
        week = [];
      }
    }

    // Add remaining days
    if (week.isNotEmpty) {
      while (week.length < 7) {
        week.add(Container());
      }
      rows.add(TableRow(children: week));
    }

    return rows;
  }
}
