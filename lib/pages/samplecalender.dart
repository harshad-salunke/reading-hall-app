import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class Calender extends StatefulWidget {
  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  void _onPreviousMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
    });
  }

  void _onNextMonth() {
    Navigator.pop(context);
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calendar'),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: _onPreviousMonth,
                ),
                Text(
                  DateFormat.yMMMM().format(_selectedDate),
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: _onNextMonth,
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: GridView.count(
                  crossAxisCount: 7,
                  children: _buildCalendar(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCalendar() {
    List<Widget> calendarDays = [];
    var firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    var lastDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
    var weekDay = firstDayOfMonth.weekday;
    var numberOfDays = lastDayOfMonth.day;

    // Add the weekday names to the calendar


    // Add empty cells for the days before the first day of the month
    for (var i = 0; i < weekDay; i++) {
      calendarDays.add(Container());
    }

    // Add the calendar days for the selected month
    for (var i = 1; i <= numberOfDays; i++) {
      var date = DateTime(_selectedDate.year, _selectedDate.month, i);
      calendarDays.add(
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Text(
              '${DateFormat.d().format(date)} ${DateFormat.E().format(date)}',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      );
    }

    return calendarDays;
  }

}
