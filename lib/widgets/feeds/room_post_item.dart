import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:orbital_login/models/room_post.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:timeago/timeago.dart' as timeago;

class RoomPostItem extends StatelessWidget {
  RoomPostItem(this.post);

  final RoomPost post;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.75;

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('appUser')
            .doc(post.senderId)
            .get(),
        builder: (ctx,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                userSnapshot) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chatRoom')
                .doc(post.roomId)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    postSnapshot) {
              if (!postSnapshot.hasData) {
                return SkeletonAnimation(
                  child: Container(
                    width: c_width,
                    height: c_width * 0.6,
                    margin: EdgeInsets.all(20),
                    color: Colors.grey.shade50,
                  ),
                );
              }
              var roomData = postSnapshot.data!;
              var userId = FirebaseAuth.instance.currentUser!.uid;

              return Container(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        userSnapshot.hasData
                            ? Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          userSnapshot.data!['avatarUrl']),
                                      fit: BoxFit.cover),
                                ),
                              )
                            : CircleAvatar(
                                radius: 30,
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  userSnapshot.hasData
                                      ? userSnapshot.data!['username']
                                      : "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  timeago.format(
                                    DateTime.parse(
                                        post.createdAt.toDate().toString()),
                                    locale: 'en_short',
                                  ),
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Container(
                              width: c_width * 0.9,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: ExpansionTile(
                                  tilePadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  collapsedBackgroundColor:
                                      Colors.grey.shade200,
                                  leading: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/images/default.png'),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        roomData["roomName"],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${roomData["userIdArray"].length} / ${roomData["roomCapacity"]}",
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
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                        onPressed: () async {
                                          var roomRef = FirebaseFirestore
                                              .instance
                                              .collection('chatRoom')
                                              .doc(post.roomId);

                                          var roomUsers = await roomRef
                                              .get()
                                              .then((value) =>
                                                  value.data()!['userIdArray']);
                                          var roomCapacity = await roomRef
                                              .get()
                                              .then((value) => value
                                                  .data()!['roomCapacity']);
                                          var userId = FirebaseAuth
                                              .instance.currentUser!.uid;
                                          var userRef = FirebaseFirestore
                                              .instance
                                              .collection('appUser')
                                              .doc(userId);
                                          var userName = await userRef
                                              .get()
                                              .then((value) =>
                                                  value.data()!['username']);
                                          print(roomCapacity);
                                          print(roomUsers.length);
                                          if (roomCapacity > roomUsers.length) {
                                            await roomRef.update({
                                              'userIdArray':
                                                  FieldValue.arrayUnion(
                                                      [userId])
                                            });
                                            await userRef.update(
                                                {'roomId': post.roomId});
                                            await roomRef
                                                .collection('/chats')
                                                .add(
                                              {
                                                "text":
                                                    "$userName has joined the room",
                                                "createdAt": Timestamp.now(),
                                                "userId": userId,
                                                "username": userName,
                                                "type": "join",
                                              },
                                            );

                                            // Navigator.popUntil(context, ModalRoute.withName('/home'));
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    '/home/chat-room-screen',
                                                    (route) => false,
                                                    arguments: post.roomId);
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
                                        roomData["gameName"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      subtitle: Text(
                                        roomData["roomDescription"],
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
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
