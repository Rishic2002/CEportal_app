import 'dart:js';

import 'package:ceportal/Utils/theme_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Utils/utils.dart';
import '../notification_screen.dart';
import 'jobCards.dart';

class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({super.key, required this.userId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = 'Username';

  Future<void> _fetchUserData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null) {
          setState(() {
            _username = data["name"] as String? ?? 'Default Username';
          });
        }
      }
    } catch (error) {
      const CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  var location = "Delhi,India";
  TextEditingController Controller = TextEditingController();

  bool ForBool = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height)),
                Padding(
                  padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width) /
                      20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),
                      Container(
                        child: myText(
                          context:context,
                          "Welcome back, $_username!",

                              fontSize: 25,


                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 13,
                      ),
                      Container(
                        child: const Icon(Icons.notifications),
                      )
                    ],
                  ),
                ),

                // Padding(padding:EdgeInsets.all(5) ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 18)),
                    const Icon(
                      Icons.location_pin,
                      size: 18,
                      color: Colors.grey,
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 20),
                      child: myText(
                        textColor: PrimaryColors().grey,
                        location,context: null,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 30),
                      child: Card(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width /
                                        30)),
                            const Icon(Icons.search),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 40,
                              child: TextField(
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      ForBool = false;
                                    });
                                  } else {
                                    setState(() {
                                      ForBool = true;
                                    });
                                  }
                                  Controller.text = value;
                                  Controller.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: Controller.text.length));
                                },
                                controller: Controller,
                                decoration: InputDecoration(
                                  hintText: ForBool ? null : 'Example "Job"',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red[500]),
                      // color: Colors.red,
                      child: const Icon(
                        Icons.tune,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),

                Container(
                  child:  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        myText(
                          "Categories",

                              fontWeight: FontWeight.w600,
                              fontSize: 18, context: context,
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 50,
                      right: MediaQuery.of(context).size.width / 50),
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width) /
                                15,
                            child: Column(
                              children: [
                                Card(
                                  color: Colors.pink[50],
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width) /
                                        36,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            // color: Color(.fromhex(#ffe2dc)),
                                            child: Image.asset(
                                              "lib/assets/images/categories/job_logo.png",
                                              width: 35,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                myText(
                                  "Job", context: context,

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width) /
                                15,
                            child: Column(
                              children: [
                                Card(
                                  color: Colors.blue[50],
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width) /
                                        36,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            // color: Color(.fromhex(#ffe2dc)),
                                            child: Image.asset(
                                              "lib/assets/images/categories/scholarship.png",
                                              width: 35,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                myText(
                                  "Scholarship", context: context,

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width) /
                                15,
                            child: Column(
                              children: [
                                Card(
                                  color: Colors.yellow[50],
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width) /
                                        36,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              "lib/assets/images/categories/scheme.png",
                                              width: 35,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                 myText(
                                  "Scheme", context: context,

                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myText(
                        "Recent", context: context,

                      ),
                      myText(
                        "see all", context: context,

                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          print("job 1 buton pressd\n");
                          FirestoreDemo();
                        },
                        child: const JobCard(
                            title: "Job_1",
                            date: "12 Mar",
                            location: "Mumbai,India")),
                    TextButton(
                      onPressed: () {
                        print("job 1 buton pressd\n");
                        Navigator.pushNamed(context, 'Jobs_Detail');
                      },
                      child: const JobCard(
                          title: "Dakaiti",
                          date: "29 May",
                          location: "Chambal,M.P"),
                    ),
                    TextButton(
                      onPressed: () {
                        print("job 1 buton pressd\n");
                        Navigator.pushNamed(context, 'Jobs_Detail');
                      },
                      child: const JobCard(
                          title: "Job_3",
                          date: "20 May",
                          location: "Indore,M.P"),
                    ),
                    TextButton(
                      onPressed: () {
                        print("job 1 buton pressd\n");
                        Navigator.pushNamed(context, 'Jobs_Detail');
                      },
                      child: const JobCard(
                          title: "Job_2",
                          date: "10 Jan",
                          location: "Lucknow,India"),
                    ),
                    TextButton(
                        onPressed: () {
                          print("job 1 buton pressd\n");
                          Navigator.pushNamed(context, 'Jobs_Detail');
                        },
                        child: const JobCard(
                            title: "NoPlacement",
                            date: "30 jun",
                            location: "All India")),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
