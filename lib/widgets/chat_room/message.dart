import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/models/appuser_function.dart';
import 'package:orbital_login/widgets/chat_room/message_bubble_me.dart';
import 'package:orbital_login/widgets/chat_room/message_bubble_people.dart';

class Message extends StatelessWidget {
  final currentRoom;

  Message(this.currentRoom);

  @override
  Widget build(BuildContext context) {
    var appuser = AppUserFunction();

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chatRoom/${currentRoom["roomId"]}/chats')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var messages = chatSnapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemBuilder: (ctx, index) {
            var message = messages[index].data();
            return message['userId'] == appuser.getUserId()
                ? MessageBubbleMe(message['text'], "Me")
                : MessageBubblePeople(message['text'], message['username']);
          },
          itemCount: messages.length,
        );
      },
    );
  }
}
