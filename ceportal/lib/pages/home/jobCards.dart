import 'package:ceportal/Utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../Utils/utils.dart';

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.title, required this.date, required this.location});

  final title;
  final date;
  final location;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25,top: MediaQuery.of(context).size.height/)),
                Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 15,
                        top: MediaQuery.of(context).size.height / 50),
                    child: myText(
                      context: context,
                      title,
                      textColor: PrimaryColors().white,
                    )),
                Container(
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 10,
                      top: MediaQuery.of(context).size.height / 50),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                      ),
                      myText(
                        date,
                        context: context,
                      textColor: PrimaryColors().white,
                      ),
                    ],
                  ),
                ),
              ]),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 15,
                bottom: MediaQuery.of(context).size.height / 50,
                top: MediaQuery.of(context).size.height / 50),
            child: myText(
              context: context,
              location,
              textColor: PrimaryColors().white,
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}
