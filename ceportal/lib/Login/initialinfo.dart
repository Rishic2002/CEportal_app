// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:ceportal/Login/register_page.dart';
import 'package:flutter/material.dart';

class InitialInfo extends StatefulWidget {
  const InitialInfo({super.key});
  @override
  _InitialInfoState createState() => _InitialInfoState();
}

class _InitialInfoState extends State<InitialInfo> {
  String selectedGender = 'Male';
  String selectedLocation = 'Delhi, India';
  List<String> locations = [
    'Delhi, India',
    'Mumbai, India',
    'Bangalore, India'
  ];

  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            const Text(
              'A little about yourself',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  color: const Color.fromARGB(255, 239, 242, 241),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: selectedGender == 'Male'
                                ? Colors.red
                                : Colors.grey,
                            minimumSize: const Size(80, 80),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the border radius as needed
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedGender = 'Male';
                            });
                          },
                          child: Image.asset(
                            'lib/assets/icons/ifemale.png', // Replace with the actual path to your PNG icon
                            width: 48.0, // Set the width of the icon
                            height: 48.0, // Set the height of the icon
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Male',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 239, 242, 241),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: selectedGender == 'Female'
                                ? Colors.red
                                : Colors.grey,
                            minimumSize: const Size(80, 80),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the border radius as needed
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedGender = 'Female';
                            });
                          },
                          child: Image.asset(
                            'lib/assets/icons/male.png', // Replace with the actual path to your PNG icon
                            width: 48.0, // Set the width of the icon
                            height: 48.0, // Set the height of the icon
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Female',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 50, // Adjust the width as needed
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: ' Day',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10), // Add spacing between text fields
                Container(
                  width: 100,
                  height: 50, // Adjust the width as needed
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: ' Month',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10), // Add spacing between text fields
                Container(
                  width: 100,
                  height: 50,
                  // Adjust the width as needed
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: ' Year',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Your location',
              ),
              value: selectedLocation,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLocation = newValue!;
                });
              },
              items: locations.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 10), // Add spacing between text fields
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Adjust the border radius as needed
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterApp(),
                  ),
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
