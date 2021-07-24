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
                    "SHARE ROOM",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                  onPressed: () async {
                    var postRef =
                        FirebaseFirestore.instance.collection('post').doc();
                    await postRef.set({
                      'postId': postRef.id,
                      'senderId': FirebaseAuth.instance.currentUser!.uid,
                      'createdAt': Timestamp.now(),
                      'roomId': roomData.id,
                      'type': "room",
                    });
                    Navigator.of(context).pop();
                  }),
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
