import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagesStream extends StatelessWidget {
  MessagesStream(this._firestore, this.loggedUser);

  final FirebaseFirestore _firestore;
  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final messages = snapshot.data.docs;
          List<Widget> messagesWidget = messages.map((message) {
            final msgText = message.data()['text'];
            final msgSender = message.data()['sender'];
            return MessageItem(
              text: msgText,
              sender: msgSender,
              isCurrentUser: msgSender == loggedUser.email,
            );
          }).toList();

          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 2,
              ),
              children: messagesWidget,
            ),
          );
        }
      },
    );
  }
}

class MessageItem extends StatelessWidget {
  MessageItem({this.text, this.sender, this.isCurrentUser});

  final String text;
  final String sender;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(30),
            elevation: 5,
            color:
                isCurrentUser ? Colors.lightBlueAccent : Colors.lightBlue[50],
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
