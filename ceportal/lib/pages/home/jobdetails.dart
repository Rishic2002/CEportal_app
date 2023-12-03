import 'package:flutter/material.dart';
class Jobs_detail extends StatefulWidget {
  const Jobs_detail({super.key});

  @override
  State<Jobs_detail> createState() => _Jobs_detailState();
}

class _Jobs_detailState extends State<Jobs_detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white
            ),
          )

        ],
      ),


    );
  }
}