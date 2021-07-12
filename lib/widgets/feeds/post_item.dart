import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/models/post.dart';

class PostItem extends StatelessWidget {
  PostItem(this.post);

  Post post;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('appUser')
            .doc(post.senderId)
            .get(),
        builder: (ctx,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snpashot) {
          return Container(
            child: Row(
              children: [
                CircleAvatar(),
              ],
            ),
          );
        });
  }
}
