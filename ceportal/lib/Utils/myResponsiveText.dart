import 'package:flutter/material.dart';

class MyResponsiveText extends StatefulWidget {
  final String data;
  final BuildContext context;
  final decoration;
  final Key? key;
  final textColor;
  final double? fontSize;
  final fontWeight;
  final double? height;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;
  final int? maxLines;

  MyResponsiveText(
    this.data, {
    required this.context,
    this.decoration,
    this.key,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
  });

  @override
  _MyResponsiveTextState createState() => _MyResponsiveTextState();
}

class _MyResponsiveTextState extends State<MyResponsiveText> {
  bool myState = false;

  @override
  Widget build(BuildContext context) {
    const Color color = Colors.black;
   

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.data,
          key: widget.key,
          textAlign: widget.textAlign,
          style: TextStyle(
            color: color,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            height: widget.height,
            fontFamily: 'primary',
            decoration: widget.decoration,
          ),
          overflow: myState ? null : widget.overflow,
          maxLines: myState ? null : widget.maxLines,
        ),
        if (widget.data.length > 120)
          GestureDetector(
            child: Text(
              myState ? "see less" : "see more",
              style: const TextStyle(
                color: Colors.blueAccent,
              ),
            ),
            onTap: () {
              setState(() {
                myState = !myState;
              });
            },
          ),
      ],
    );
  }
}
