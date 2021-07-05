import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FollowingNotificationItem extends StatelessWidget {
  final String senderName;
  final String senderId;
  final String createdAt;

  FollowingNotificationItem(this.createdAt, this.senderId, this.senderName);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("appUser")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          return ListTile(
            title: Text("$senderName has just followed you!"),
            subtitle: Text(createdAt),
            trailing: TextButton(
              child: Text(
                "Follow back",
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onPressed: () async {
                String myUserId = FirebaseAuth.instance.currentUser!.uid;
                await FirebaseFirestore.instance
                    .collection('appUser')
                    .doc(myUserId)
                    .update({
                  "followingIdArray": FieldValue.arrayUnion([senderId]),
                });
                await FirebaseFirestore.instance
                    .collection("appUser")
                    .doc(senderId)
                    .update({
                  "followerIdArray": FieldValue.arrayUnion([myUserId])
                });

                var notificationRef = FirebaseFirestore.instance
                    .collection("appUser/$senderId/Notification");

                var newNotification = notificationRef.doc();
                await notificationRef.doc(newNotification.id).set({
                  "createdAt": Timestamp.now(),
                  "senderName": snapshot.data!["username"],
                  "docId": newNotification.id,
                  "senderId": myUserId,
                  "notificationType": "followingNotification",
                });
              },
            ),
          );
        });
  }
}
