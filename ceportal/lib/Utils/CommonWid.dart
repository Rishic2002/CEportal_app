import 'package:ceportal/Utils/theme_helper.dart';
import 'package:ceportal/Utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

import 'Essentials.dart';

class CommonWid {
  static Widget myBottomSheet(
      {required BuildContext context,
      required String header,
      required Widget child,
      double? height}) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: BoxDecoration(
          color: PrimaryColors().white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: height ?? (Essentials.height(context) * 0.9),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Essentials.heightSpacer(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  myText(header,
                      fontSize: Essentials.mSize,
                      context: context,
                      fontWeight: FontWeight.w500),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              Essentials.heightSpacer(20),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // static Widget CustomCalender(BuildContext context) {
  //   CalendarFormat _calendarFormat = CalendarFormat.month;
  //   DateTime _focusedDay = DateTime.now();
  //   DateTime? _selectedDay;
  //
  //   final kToday = DateTime.now();
  //   final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
  //   final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
  //     decoration: Essentials.shadowDecoration(opacity: 0.14),
  //     child: Container(
  //       padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         color: PrimaryColors().white,
  //       ),
  //       child: Column(
  //         children: [
  //           TableCalendar(
  //             firstDay: kFirstDay,
  //             calendarStyle: CalendarStyle(
  //               markerDecoration: const BoxDecoration(
  //                   color: Colors.red, shape: BoxShape.circle),
  //               selectedDecoration: const BoxDecoration(
  //                   color: Colors.pink, shape: BoxShape.circle),
  //               todayDecoration: const BoxDecoration(
  //                 shape: BoxShape.rectangle,
  //               ),
  //               defaultTextStyle: const TextStyle(),
  //               selectedTextStyle: TextStyle(color: PrimaryColors().white),
  //               todayTextStyle: const TextStyle(color: Colors.black),
  //               weekendTextStyle: TextStyle(
  //                 color: PrimaryColors().grey.withOpacity(0.4),
  //               ),
  //               outsideTextStyle: TextStyle(
  //                 color: PrimaryColors().grey.withOpacity(0.4),
  //               ),
  //               outsideDaysVisible: true,
  //             ),
  //             headerStyle: HeaderStyle(
  //               titleCentered: true,
  //               formatButtonVisible: false,
  //               titleTextStyle: TextStyle(
  //                   fontFamily: 'comfortaa',
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.w700,
  //                   fontSize: Essentials.mSize),
  //               leftChevronIcon: const Icon(
  //                 Icons.chevron_left,
  //                 color: Colors.black,
  //               ),
  //               rightChevronIcon: const Icon(
  //                 Icons.chevron_right,
  //                 color: Colors.black,
  //               ),
  //             ),
  //             daysOfWeekStyle: DaysOfWeekStyle(
  //                 weekdayStyle: TextStyle(
  //                   color: PrimaryColors().grey.withOpacity(0.4),
  //                 ),
  //                 weekendStyle: TextStyle(
  //                   color: PrimaryColors().grey.withOpacity(0.4),
  //                 )),
  //             lastDay: kLastDay,
  //             focusedDay: _focusedDay,
  //             // calendarFormat: _calendarFormat,
  //             calendarBuilders: CalendarBuilders(
  //               selectedBuilder: (c, day, focusDay) {
  //                 return Tooltip(
  //                   message: '',
  //                   child: Container(
  //                     margin: const EdgeInsets.symmetric(
  //                         horizontal: 10, vertical: 4),
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10),
  //                         shape: BoxShape.rectangle,
  //                         color: PrimaryColors().ProfileTextColor),
  //                     child: Center(
  //                       child: Text(
  //                         '${day.day}',
  //                         style: TextStyle(color: PrimaryColors().white),
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //             selectedDayPredicate: (day) {
  //               return isSameDay(_selectedDay, day);
  //             },
  //             onDaySelected: (selectedDay, focusedDay) {
  //               if (!isSameDay(_selectedDay, selectedDay)) {
  //                 setState(() {
  //                   _selectedDay = selectedDay;
  //                   _focusedDay = focusedDay;
  //                 });
  //               }
  //             },
  //             onFormatChanged: (format) {
  //               if (_calendarFormat != format) {
  //                 setState(() {
  //                   _calendarFormat = format;
  //                 });
  //               }
  //             },
  //             onPageChanged: (focusedDay) {
  //               _focusedDay = focusedDay;
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // static Widget MyCheckbox(BuildContext context,
  //     {required String title,
  //     required bool value,
  //     required Function(bool?)? onChanged}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
  //     child: Container(
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         color: PrimaryColors().white,
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             myText(
  //               title,
  //               isHeader: true,
  //               fontSize: Essentials.mSize,
  //               fontWeight: FontWeight.w400,
  //               textColor: PrimaryColors().black,
  //               context: context,
  //             ),
  //             Checkbox(
  //               shape: CircleBorder(),
  //               value: value,
  //               onChanged: onChanged,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  static Widget myDialog(
    BuildContext context,
    String title,
    Widget myDialogWidget, {
    Widget? myContentWidget,
    TextAlign titleAlignment = TextAlign.left,
    TextAlign contentAlignment = TextAlign.left,
  }) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.blue,
      icon: Align(
        alignment: Alignment.topRight,
        child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.close, color: PrimaryColors().white)),
      ),
      title: myText(
        title,
        context: context,
        fontSize: Essentials.mSize,
        fontWeight: FontWeight.w600,
        textColor: PrimaryColors().white,
        textAlign: titleAlignment,
      ),
      content: myContentWidget ?? SizedBox.shrink(),
      actions: myDialogWidget != null ? <Widget>[myDialogWidget] : [],
    );
  }

  static Widget myTextField(
    String label,
    BuildContext context,
    String hinttext,
    TextEditingController controller,
    int maxline,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: myText(
            label,
            context: context,
            textColor: PrimaryColors().black,
            fontSize: Essentials.rSize,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: controller,
            maxLines: maxline,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: PrimaryColors().grey),
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: PrimaryColors().grey),
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: hinttext,
              hintStyle: TextStyle(
                  color: PrimaryColors().grey, fontSize: Essentials.sSize),
            ),
          ),
        ),
      ],
    );
  }
}
