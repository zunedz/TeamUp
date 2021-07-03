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
        },
      ),
    );
  }
}
