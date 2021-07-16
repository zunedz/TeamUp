import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InviteFriendItem extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String userId;
  final String myUserName;
  final String roomId;

  InviteFriendItem(
      this.imageUrl, this.userId, this.userName, this.myUserName, this.roomId);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(imageUrl), fit: BoxFit.cover),
          ),
        ),
        title: Text(userName),
        trailing: MaterialButton(
          color: Theme.of(context).accentColor,
          child: Text(
            "Invite",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          onPressed: () async {
            var notificationRef = FirebaseFirestore.instance
                .collection("appUser/$userId/Notification");
            var notificationId = notificationRef.doc();
            await notificationRef.doc(notificationId.id).set({
              "createdAt": Timestamp.now(),
              "senderName": myUserName,
              "docId": notificationId.id,
              "senderId": FirebaseAuth.instance.currentUser!.uid,
              "notificationType": "invitationNotification",
              "roomId": roomId
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Invitation sent!"),
            ));
          },
        ),
      ),
    );
  }
}
