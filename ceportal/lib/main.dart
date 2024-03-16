import 'package:ceportal/Login/initialinfo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Theme/themeprovider.dart';
import 'firebase_options.dart';
import 'pages/bottom_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(), // Initialize your ThemeProvider

    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadLoginCredentials();
  }

  Future<void> _loadLoginCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    if (email != null && password != null) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Check if sign-in was successful and retrieve the user ID
        if (userCredential.user != null) {
          _userId = userCredential.user!.uid;
        }
      } on FirebaseAuthException catch (e) {
        print('Error signing in with saved credentials: ${e.message}');
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'My App',
          theme: themeProvider.themeData,
          home: _isLoading
              ? _buildLoadingScreen()
              : _userId != null
                  ? NavBottom(userId: _userId!)
                  : const InitialInfo(),
        );
      },
    );
  }

  Widget _buildLoadingScreen() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}



/*
Need to work on the UI 
Adding Essentials file and restructure code accroding to it  // Integrate Essentials and helperfunctions file into the app
remove theme files and add theme data to Essentials 
UI needed for the Backend Data 
Need to work on Icons in Login Page
Need to work on Color schemes in home page 
Firebase/Mongo Node js backend 
*/
