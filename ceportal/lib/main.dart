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

/* IOS POD ISSUE SOLVE COMMANDS 
cd ios
pod cache clean --all
Pod clean
pod deintegrate
sudo gem install cocoapods-deintegrate cocoapods-clean

sudo arch -x86_64 gem install ffi
arch -x86_64 pod repo update
arch -x86_64 pod install



- Error (Xcode): DT_TOOLCHAIN_DIR cannot be used to evaluate LIBRARY_SEARCH_PATHS, use TOOLCHAIN_DIR instead

Could not build the application for the simulator.
Error launching application on iPhone 15 Pro Max.

To perform this replacement, you can add the following code snippet at the end of your project's Podfile:

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
      File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
    end
  end
end
*/

