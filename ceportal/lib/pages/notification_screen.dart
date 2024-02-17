// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreDemo extends StatefulWidget {
  @override
  _FirestoreDemoState createState() => _FirestoreDemoState();
}

class _FirestoreDemoState extends State<FirestoreDemo> {
  Future<DocumentSnapshot> getDocument() async {
    // Replace 'your_collection' with your Firestore collection name
    // and 'your_document_id' with the ID of the document you want to fetch
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('States') // Access 'States' collection
        .doc('Delhi') // Access 'Delhi' document
        .collection(
            'Scholarships') // Access 'Scholarships' collection within 'Delhi' document
        .doc(
            'om8yD92u0uL1qqUeV7WT') // Access 'om8yD92u0uL1qqUeV7WT' document within 'Scholarships' collection
        .get();
    return document;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Demo'),
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: getDocument(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Access the document data
              var data = snapshot.data!.data();
              var jsonData = data.toString(); // Convert data to JSON string
              List<String> reversedLines = jsonData
                  .split('\n')
                  .reversed
                  .toList(); // Split data by lines and reverse the list

              return ListView.builder(
                itemCount: reversedLines.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reversedLines[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8), // Add spacing after each item
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
