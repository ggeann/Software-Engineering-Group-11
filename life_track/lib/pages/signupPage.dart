import 'package:flutter/material.dart';
import 'package:life_track/pages/loginPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  void signUp() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 11,
                spreadRadius: 6,
              ),
            ],
          ),

          child: Center(
              // padding: const EdgeInsets.only(left: 23),
            child: SingleChildScrollView(
              child: Column(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _signupTitle(),
                  _nameForm('Name'),
                  _emailForm('Email address'),
                  _passwordForm('Password'),
                  Padding(
                    padding: const EdgeInsets.only(left: 23, right: 23, top: 48),
                    child: Container(
                      height: 56,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF3EB489),
                        ),
                        onPressed: () {
                          signUp();
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                          ),
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5FBF5),
    );
  }

  Widget _signupTitle() {
    return Column(
      children: [
        Text('Sign Up', style: TextStyle(fontSize: 30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have an account?'),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Log In'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _nameForm(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 23, right: 23),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text),
            SizedBox(height: 9),
            TextField(
              decoration: InputDecoration(
                filled: true,
                hintText: 'Name',
                // labelText: 'Email address',
                fillColor: const Color(0xFFF5FBF5),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailForm(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23, top: 23),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text),
            SizedBox(height: 9),
            TextField(
              decoration: InputDecoration(
                filled: true,
                hintText: 'name@example.com',
                // labelText: 'Email address',
                fillColor: const Color(0xFFF5FBF5),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordForm(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23, top: 23),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text),
            SizedBox(height: 9),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF5FBF5),
                hintText: 'Enter password',
                // labelText: 'Password',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
