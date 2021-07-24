import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/models/room.dart';

class RoomItem extends StatelessWidget {
  final Room roomData;
  RoomItem(this.roomData);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          collapsedBackgroundColor: Colors.grey.shade200,
          leading: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/default.png'),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                roomData.roomName!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "${roomData.users!.length} / ${roomData.maxCapacity}",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          children: [
            ListTile(
              trailing: TextButton(
                child: Text(
                  "JOIN ROOM",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                ),
                onPressed: () async {
                  var roomRef = FirebaseFirestore.instance
                      .collection('chatRoom')
                      .doc(roomData.id);

                  var roomUsers = await roomRef
                      .get()
                      .then((value) => value.data()!['userIdArray']);
                  var roomCapacity = await roomRef
                      .get()
                      .then((value) => value.data()!['roomCapacity']);
                  var userId = FirebaseAuth.instance.currentUser!.uid;
                  var userRef = FirebaseFirestore.instance
                      .collection('appUser')
                      .doc(userId);
                  var userName = await userRef
                      .get()
                      .then((value) => value.data()!['username']);
                  print(roomCapacity);
                  print(roomUsers.length);
                  if (roomCapacity > roomUsers.length) {
                    await roomRef.update({
                      'userIdArray': FieldValue.arrayUnion([userId])
                    });
                    await userRef.update({'roomId': roomData.id});
                    await roomRef.collection('/chats').add(
                      {
                        "text": "$userName has joined the room",
                        "createdAt": Timestamp.now(),
                        "userId": userId,
                        "username": userName,
                        "type": "join",
                      },
                    );

                    // Navigator.popUntil(context, ModalRoute.withName('/home'));
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home/chat-room-screen', (route) => false,
                        arguments: roomData.id);
                  } else {
                    await CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      text: "Room is fully occupied",
                    );
                  }
                }, //push and replace the chatroom screen to the screenstacks.
              ),
              title: Text(
                roomData.gamePlayed!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text(
                roomData.description == null ? "" : roomData.description!,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
            // Text(roomData.description!),
            // ElevatedButton(onPressed: () {}, child: Text("join room"))
          ],
        ),
      ),
    );
  }
}
