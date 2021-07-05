import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InvitationNotificationItem extends StatelessWidget {
  final String senderName;
  final String senderId;
  final String createdAt;
  final String roomId;

  InvitationNotificationItem(
      this.createdAt, this.senderId, this.senderName, this.roomId);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("$senderName invited you to join this room!"),
      subtitle: Text(createdAt),
      trailing: TextButton(
        child: Text(
          "Join room",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        onPressed: () async {
          var roomRef =
              FirebaseFirestore.instance.collection('chatRoom').doc(roomId);

          var roomUsers =
              await roomRef.get().then((value) => value.data()!['userIdArray']);
          var roomCapacity = await roomRef
              .get()
              .then((value) => value.data()!['roomCapacity']);
          var userId = FirebaseAuth.instance.currentUser!.uid;
          var userRef =
              FirebaseFirestore.instance.collection('appUser').doc(userId);
          var userName =
              await userRef.get().then((value) => value.data()!['username']);
          print(roomCapacity);
          print(roomUsers.length);
          if (roomCapacity > roomUsers.length) {
            await roomRef.update({
              'userIdArray': FieldValue.arrayUnion([userId])
            });
            await userRef.update({'roomId': roomId});
            await roomRef.collection('/chats').add(
              {
                "text": "$userName has joined the room",
                "createdAt": Timestamp.now(),
                "userId": userId,
                "username": userName,
                "type": "join",
              },
            );
            Navigator.popUntil(context, ModalRoute.withName('/home'));
            Navigator.of(context).pushReplacementNamed('/home/chat-room-screen',
                arguments: roomId);
          } else {
            await CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: "Room is fully occupied",
            );
          }
        }, //push and
      ),
    );
  }
}
