// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'signin_page.dart';

class RegisterApp extends StatefulWidget {
  const RegisterApp({super.key});

  @override
  State<RegisterApp> createState() => _RegisterAppState();
}

class _RegisterAppState extends State<RegisterApp> {
  bool isLoading = false;
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //final TextEditingController _societyNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 245, 246, 245),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 6),
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                              color: Colors.grey), // Set label text color
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Set border color
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
                                color: Colors
                                    .grey), // Set focused error border color
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Colors.grey), // Set label text color
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Set border color
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
                                color: Colors
                                    .grey), // Set focused error border color
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: Colors.grey), // Set label text color
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Set border color
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
                                color: Colors
                                    .grey), // Set focused error border color
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          const Text('I agree with Terms and Privacy Policy'),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 6),
                      ElevatedButton(
                        onPressed: _register,
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
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => const SignInPage()));
                        },
                        child: const Text(
                          "Already have a account? Login here",
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

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': _nameController.text,
          'mobile': _mobileController.text,
          'email': _emailController.text,
        });

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful.'),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInPage()),
        );
      } catch (e) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration failed. Please try again.'),
          ),
        );
      }
    }
  }
}
