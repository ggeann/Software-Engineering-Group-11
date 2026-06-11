import 'package:flutter/material.dart';
import 'package:life_track/pages/signupPage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void signIn() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xfffffffff),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 11,
                spreadRadius: 6
              )
            ]
          ),
          // color: const Color(0xFFF5FBF5),
          child: Center(
            child: SingleChildScrollView( // prevents bottom overflow
              child: Column(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0.3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: Image(
                        image: AssetImage('images/LifeTrack.png'),
                        height: 121,
                      ),
                    ),
                  ),
                  SizedBox(height: 13),
                  Text(
                    'Login to your account.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Column(
                    spacing: 1,
                    children: [
                      _emailForm('Email address'),
                      _passwordForm('Password'),
                      Padding(
                        padding: const EdgeInsets.only(left: 23, right: 23, top: 32),
                        child: SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xfff3eb489),
                            ),
                            onPressed: () {
                              signIn();
                            },
                            child: Text(
                              'Sign In',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage())
                          );
                        },
                        child: Text('Sign up'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5FBF5),
    );
  }

  Widget _emailForm(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23, top: 30),
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
      padding: const EdgeInsets.all(23),
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
