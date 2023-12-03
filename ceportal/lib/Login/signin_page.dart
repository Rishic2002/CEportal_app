// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/bottom_navigation_bar.dart';
import 'register_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 245),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 40.0),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(color: Colors.grey), // Set label text color
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey), // Set border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Set focused border color
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Set error border color
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Set focused error border color
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: Colors.grey), // Set label text color
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey), // Set border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Set focused border color
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Set error border color
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Set focused error border color
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterApp(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 230, 57, 70),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 6),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _signIn,
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size.fromWidth(
                              MediaQuery.of(context).size.width / 2),
                          maximumSize: const Size.fromHeight(50),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: const Color.fromARGB(
                              255, 230, 57, 70), // Background color
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterApp(),
                      ),
                    );
                  },
                  child: const Text(
                    "Don't have a account? Signup",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Retrieve the user ID from the UserCredential
        String userId = userCredential.user!.uid;

        // Check the email and password in the Firestore collection
        // Replace this with your Firestore logic, if needed

        // Email and password match, navigate to the homepage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavBottom(userId: userId),
          ),
        );

        // Save email and password to shared preferences
        await _saveLoginCredentials(
            _emailController.text, _passwordController.text);
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });

        String errorMessage = 'Sign in failed. Please try again.';

        if (e.code == 'user-not-found') {
          errorMessage = 'User not found. Please check your email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Invalid password. Please try again.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    }
  }

  Future<void> _saveLoginCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }
}
