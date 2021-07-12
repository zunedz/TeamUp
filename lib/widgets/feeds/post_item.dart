import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/models/post.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                userSnapshot) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('post')
                  .doc(post.postId)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      postSnapshot) {
                return Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                          child:
                              Image.network(userSnapshot.data!["avatarUrl"])),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(userSnapshot.data!['username']),
                              SizedBox(
                                width: 10,
                              ),
                              Text(post.createdAt.toString())
                            ],
                          ),
                          Text(post.text),
                          Row(children: [
                            Icon(
                              EvilIcons.arrow_up,
                              color: Colors.purple,
                            ),
                            Text(post.likesArray.length.toString()),
                            Icon(Icons.arrow_downward),
                            Icon(Icons.reply)
                          ])
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
