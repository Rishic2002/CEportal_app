import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'Essentials.dart';
import 'theme_helper.dart';

class MyCalendar extends StatefulWidget {
  final Function(DateTime)? onDateSelected;

  const MyCalendar({Key? key, this.onDateSelected}) : super(key: key);

  @override
  State<MyCalendar> createState() => _CalenderDropDownState();
}

class _CalenderDropDownState extends State<MyCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
    return Container(
      width: Essentials.width(context),
      height: Essentials.height(context) / 2,
      decoration: Essentials.shadowDecoration(opacity: 0.14),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: PrimaryColors().white,
        ),
        child: Column(
          children: [
            TableCalendar(
              firstDay: kFirstDay,
              calendarStyle: CalendarStyle(
                markerDecoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
                selectedDecoration: const BoxDecoration(
                    color: Colors.pink, shape: BoxShape.circle),
                todayDecoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                defaultTextStyle: const TextStyle(),
                selectedTextStyle: TextStyle(color: PrimaryColors().white),
                todayTextStyle: const TextStyle(color: Colors.black),
                weekendTextStyle: TextStyle(
                  color: PrimaryColors().grey.withOpacity(0.4),
                ),
                outsideTextStyle: TextStyle(
                  color: PrimaryColors().grey.withOpacity(0.4),
                ),
                outsideDaysVisible: true,
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                    fontFamily: 'comfortaa',
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: Essentials.mSize),
                leftChevronIcon: const Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                ),
                rightChevronIcon: const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: PrimaryColors().grey.withOpacity(0.4),
                  ),
                  weekendStyle: TextStyle(
                    color: PrimaryColors().grey.withOpacity(0.4),
                  )),
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              // calendarFormat: _calendarFormat,
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (c, day, focusDay) {
                  return Tooltip(
                    message: '',
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          color: PrimaryColors().ProfileTextColor),
                      child: Center(
                        child: Text(
                          '${day.day}',
                          style: TextStyle(color: PrimaryColors().white),
                        ),
                      ),
                    ),
                  );
                },
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  // Invoke the callback if provided
                  if (widget.onDateSelected != null) {
                    widget.onDateSelected!(_selectedDay!);
                  }
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
          ],
        ),
      ),
    );
  }
}
