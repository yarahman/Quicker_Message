import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat_Screen extends StatefulWidget {
  static const String id = "Chat_Screen";

  @override
  _Chat_ScreenState createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  final _fireStore = FirebaseFirestore.instance;
  String? messageText;
  bool activeSendButton = false;
  final messageTextController = TextEditingController();
  bool isMe = false;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void messageSteam() async {
    await for (var snapshot in _fireStore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.blue.shade100,
        title: Text(
          '⚡Messages',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                }
                final messages = snapshot.data!.docs;
                List<Padding> messageWigdet = [];
                for (var message in messages) {
                  final messageText = message['text'];
                  final messageSender = message['sender'];
                  final currentUser = loggedInUser?.email;
                  if (currentUser == messageSender) {
                    isMe = true;
                  }

                  final messagewidget = Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(messageSender),
                        Material(
                          elevation: 5.0,
                          borderRadius: isMe == true
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0))
                              : BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0)),
                          color: Colors.blueAccent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '$messageText',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                  messageWigdet.add(messagewidget);
                }
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(10.0),
                    children: messageWigdet,
                  ),
                );
              },
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'type a message',
                      ),
                      onChanged: (value) {
                        activeSendButton = true;
                        messageText = value;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (activeSendButton == true) {
                        _fireStore.collection('messages').add(
                          {'text': messageText, 'sender': loggedInUser!.email},
                        );
                        messageTextController.clear();
                      }
                    },
                    child: Text('Send'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
