// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Login/signin_page.dart';
import '../Utils/utils.dart';
import 'settings_list.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool isDarkMode;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await _storage.deleteAll();
    // Navigate to the login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInPage()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    isDarkMode = true;
  }

  String? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: myText('Welcome',context: context),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 17, right: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              SettingList(
                settingsTitle: isDarkMode ? "Dark Mode" : "Light Mode",
                //iconasset: AppAssets.moonIcon,
                isSuffixIcon: true,
                iconButton: CupertinoSwitch(
                  value: isDarkMode,
                  onChanged: ((value) {
                    setState(() {
                      isDarkMode = !isDarkMode;
                    });
                  }),
                ),
              ),
               myText(
                "User Settings",
               fontWeight: FontWeight.bold, fontSize: 15,
                   context: context
              ),
              const SizedBox(
                height: 20,
              ),
              SettingList(
                  isSuffixIcon: false,
                  settingsTitle: "Log Out",
                  onTap: () {
                    logout(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
