import 'package:ceportal/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'CommonWid.dart';
import 'Essentials.dart';
import 'myCalendar.dart';
import 'theme_helper.dart';

class CalenderDropDown extends StatefulWidget {
  final Function(DateTime) onDateSelected; // Callback function
  final String title;

  const CalenderDropDown(
      {Key? key, required this.onDateSelected, required this.title})
      : super(key: key);

  @override
  State<CalenderDropDown> createState() => _CalenderDropDownState();
}

class _CalenderDropDownState extends State<CalenderDropDown> {
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    selectedDay = now.day;
    selectedMonth = now.month;
    selectedYear = now.year;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              myText(widget.title,
                  fontWeight: FontWeight.w600,
                  fontSize: Essentials.mSize,
                  context: context),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/calender.svg",
                    theme: SvgTheme(
                      currentColor: PrimaryColors().blue,
                    ),
                  ),
                  Essentials.widthSpacer(4),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CommonWid.myDialog(
                            context,
                            widget.title,
                            MyCalendar(
                              onDateSelected: (DateTime selectedDate) {
                                setState(() {
                                  selectedDay = selectedDate.day;
                                  selectedMonth = selectedDate.month;
                                  selectedYear = selectedDate.year;
                                  widget.onDateSelected(
                                    DateTime(selectedYear, selectedMonth,
                                        selectedDay),
                                  );
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: myText(
                      "Calendar",
                      textColor: PrimaryColors().blue,
                      context: context,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Essentials.heightSpacer(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildDropdown(
                'Day',
                List.generate(31, (index) => index + 1),
                (value) {
                  setState(() {
                    selectedDay = value!;
                    widget.onDateSelected(
                      DateTime(selectedYear, selectedMonth, selectedDay),
                    );
                  });
                },
              ),
              Essentials.widthSpacer(4),
              buildDropdown(
                'Month',
                List.generate(12, (index) => index + 1),
                (value) {
                  setState(() {
                    selectedMonth = value!;
                    widget.onDateSelected(
                      DateTime(selectedYear, selectedMonth, selectedDay),
                    );
                  });
                },
              ),
              Essentials.widthSpacer(4),
              buildDropdown(
                'Year',
                List.generate(100, (index) => DateTime.now().year - index),
                (value) {
                  setState(() {
                    selectedYear = value!;
                    widget.onDateSelected(
                      DateTime(selectedYear, selectedMonth, selectedDay),
                    );
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDropdown(
    String label,
    List<int> items,
    Function(int?) onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<int>(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 30),
        value: label == 'Day'
            ? selectedDay
            : label == 'Month'
                ? selectedMonth
                : selectedYear,
        onChanged: onChanged,
        items: items.map((item) {
          return DropdownMenuItem<int>(
            value: item,
            child: Text('$item'),
          );
        }).toList(),
        icon: null,
        underline: SizedBox(),
      ),
    );
  }
}
