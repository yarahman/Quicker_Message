import 'package:flutter/material.dart';
import 'package:quicker_message/screens/chat_screen.dart';
import 'package:quicker_message/screens/log_in_screen.dart';
import 'package:quicker_message/screens/sign_up_screen.dart';
import 'package:quicker_message/screens/welcome_screen.dart';

void main() {
  runApp(Quicker_Message());
}

class Quicker_Message extends StatelessWidget {
  const Quicker_Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black54),
          ),
        ),
        initialRoute: Welcome_Screen.id,
        routes: {
          Welcome_Screen.id: (context) => Welcome_Screen(),
          Log_In_Screen.id: (context) => Log_In_Screen(),
          Sign_Up_Screen.id: (context) => Sign_Up_Screen(),
          Chat_Screen.id: (context) => Chat_Screen(),
        });
  }
}
