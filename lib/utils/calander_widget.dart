import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget(
      {super.key, required this.attendenceList, this.year, this.month});
  final List<Attendence> attendenceList;
  final int? year;
  final int? month;
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int displayYear = year ?? now.year;
    int displayMonth = month ?? now.month;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Table(
              children: _buildCalendar(_daysInMonth(displayYear, displayMonth)),
            ),
          ],
        ),
      ),
    );
  }

  List<DateTime> _daysInMonth(int year, int month) {
    var lastDayOfMonth = DateTime(year, month + 1, 0);
    return List.generate(
        lastDayOfMonth.day, (index) => DateTime(year, month, index + 1));
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
      String date =
          '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
      String status = getStatus(date)!;
      Color att = (status == '2')
          ? (checkTime() ? AppColors.primaryColor : Colors.grey)
          : (status == '1' ? Colors.green : Colors.white);

      week.add(
        Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 0.4,
                  color: att,
                )
              ],
              border: Border(
                  bottom: BorderSide(
                width: 5,
                color: att,
              )),
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

  String? getStatus(String date) {
    for (var attendence in attendenceList) {
      if (attendence.date == date) {
        return attendence.status;
      }
    }
    return '0'; // or you can return a default value
  }

  bool checkTime() {
    DateTime now = DateTime.now();
    DateTime ninePM =
        DateTime(now.year, now.month, now.day, 21, 0, 0); // 9 PM today

    return now.isAfter(ninePM);
  }
}
