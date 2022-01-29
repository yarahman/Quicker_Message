import 'package:flutter/material.dart';
import 'package:quicker_message/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Log_In_Screen extends StatefulWidget {
  static const String id = "Log_In_Screen";

  @override
  _Log_In_ScreenState createState() => _Log_In_ScreenState();
}

class _Log_In_ScreenState extends State<Log_In_Screen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  bool _isStart = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isStart,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.0,
              ),
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'Images/icon.png',
                    height: 200.0,
                    width: 200.0,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Log In',
                style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text(
                    'Enter your number',
                    style: TextStyle(fontSize: 25.0),
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 25.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text(
                    'Password',
                    style: TextStyle(fontSize: 25.0),
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 100.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () async {
                      setState(() {
                        _isStart = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email!, password: password!);
                        if (user != null) {
                          Navigator.pushNamed(context, Chat_Screen.id);
                        }
                        setState(() {
                          _isStart = false;
                        });
                      } catch (e) {
                        print(e);
                      }
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
            ],
          ),
        ),
      ),
    );
  }
}
