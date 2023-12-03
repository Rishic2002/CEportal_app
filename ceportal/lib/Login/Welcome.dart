import 'dart:async';
import 'package:ceportal/Login/initialinfo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const InitialInfo()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Image.asset('lib/assets/images/make_in_India.png'),
                Image.asset('lib/assets/images/75_independence.png'),
              ],
            ), // Replace with your asset path

            const Center(
              child: Text('Scholarship APP',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Center(
              child: Image.asset('lib/assets/images/gov_in.png'),
            ), // Replace with your asset path
            const Center(
                child: Text('Government of India',
                    style: TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}
