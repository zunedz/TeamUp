import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/widgets/chat_room/message.dart';
import 'package:orbital_login/widgets/chat_room/new_messages.dart';
import 'package:orbital_login/widgets/loadingScreen.dart';

class ChatRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String roomId = ModalRoute.of(context)!.settings.arguments as String;

    return FutureBuilder(
      future:
          FirebaseFirestore.instance.collection('chatRoom').doc(roomId).get(),
      builder: (ctx,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
              futureRoomSnapshots) {
        if (futureRoomSnapshots.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        }
        var currentRoom = futureRoomSnapshots.data!;
        return Scaffold(
          appBar: AppBar(
            title: Text("${currentRoom["roomName"]}".toUpperCase()),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/home/invite-friend-screen');
                  },
                  icon: Icon(Icons.add)),
              IconButton(
                  onPressed: () async {
                    var roomRef = FirebaseFirestore.instance
                        .collection('chatRoom')
                        .doc(currentRoom['roomId']);

                    var userId = FirebaseAuth.instance.currentUser!.uid;
                    var userRef = FirebaseFirestore.instance
                        .collection('appUser')
                        .doc(userId);
                    var userName = await userRef
                        .get()
                        .then((value) => value.data()!['username']);

                    await roomRef.update({
                      'userIdArray': FieldValue.arrayRemove([userId])
                    });
                    await userRef.update({'roomId': ''});
                    await roomRef.collection('/chats').add(
                      {
                        "text": "$userName has left the room",
                        "createdAt": Timestamp.now(),
                        "userId": userId,
                        "username": userName,
                        "type": "join",
                      },
                    );

                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                  icon: Icon(Icons.exit_to_app))
            ],
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
      },
    );
  }
}
