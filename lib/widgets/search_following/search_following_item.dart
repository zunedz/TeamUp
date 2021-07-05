import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchFollowingItem extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String userId;

  SearchFollowingItem(this.imageUrl, this.userId, this.userName);

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
            leading: Image.network(imageUrl),
            title: Text(userName),
            trailing: TextButton(
              child: Text("Follow"),
              onPressed: () async {
                String myUserId = FirebaseAuth.instance.currentUser!.uid;
                await FirebaseFirestore.instance
                    .collection('appUser')
                    .doc(myUserId)
                    .update({
                  "followingIdArray": FieldValue.arrayUnion([userId]),
                });
                await FirebaseFirestore.instance
                    .collection("appUser")
                    .doc(userId)
                    .update({
                  "followerIdArray": FieldValue.arrayUnion([myUserId])
                });

                var notificationRef = FirebaseFirestore.instance
                    .collection("appUser/$userId/Notification");

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
