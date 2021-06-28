import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/widgets/chat_room/message.dart';
import 'package:orbital_login/widgets/chat_room/new_messages.dart';
import 'package:orbital_login/widgets/loadingScreen.dart';

class ChatRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String roomId = ModalRoute.of(context)!.settings.arguments as String;

    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('chatRoom')
            .where("roomId", isEqualTo: roomId)
            .get(),
        builder: (ctx,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                futureRoomSnapshots) {
          if (futureRoomSnapshots.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }
          var currentRoom = futureRoomSnapshots.data!.docs[0].data();
          return Scaffold(
            appBar: AppBar(
              title: Text("${currentRoom["roomName"]}".toUpperCase()),
            ),
            body: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Message(currentRoom),
                  ),
                  NewMessages(currentRoom),
                ],
              ),
            ),
          );
        });
  }
}
