import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quicker_message/screens/log_in_screen.dart';
import 'package:quicker_message/screens/sign_up_screen.dart';

class Welcome_Screen extends StatefulWidget {
  static const String id = "Welcome_Screen";

  @override
  _Welcome_ScreenState createState() => _Welcome_ScreenState();
}

class _Welcome_ScreenState extends State<Welcome_Screen>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller!, curve: Curves.decelerate);
    controller?.forward(from: 1.0);
    controller?.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      "Images/icon.png",
                      height: 80.0,
                      width: 80.0,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  'Quick Message',
                  style: TextStyle(
                      fontSize: animation?.value * 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 80.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    // if click
                    // go to log in Screen
                    Navigator.pushNamed(context, Log_In_Screen.id);
                  },
                  height: 50.0,
                  minWidth: 10.0,
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    // if click
                    // go to Sign up Screen
                    Navigator.pushNamed(context, Sign_Up_Screen.id);
                  },
                  height: 50.0,
                  minWidth: 200.0,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
