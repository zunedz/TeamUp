import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/models/post.dart';
import 'package:orbital_login/models/room_post.dart';
import 'package:orbital_login/widgets/feeds/post_item.dart';
import 'package:orbital_login/widgets/feeds/room_post_item.dart';
import 'package:skeleton_text/skeleton_text.dart';

class FeedPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('post')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        postSnapshot) {
                  if (postSnapshot.hasData) {
                    return ListView.builder(
                        itemCount: postSnapshot.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          var postData = postSnapshot.data!.docs[index].data();
                          if (postData["type"] == "text") {
                            var currentPost = Post(
                                createdAt: postData['createdAt'],
                                likesArray: postData['likesArray'],
                                postId: postData['postId'],
                                senderId: postData['senderId'],
                                text: postData['text']);
                            return PostItem(currentPost);
                          } else {
                            var currentPost = RoomPost(
                                postId: postData['postId'],
                                createdAt: postData['createdAt'],
                                roomId: postData["roomId"],
                                senderId: postData['senderId']);
                            print("ok til here");
                            return RoomPostItem(currentPost);
                          }
                        });
                  } else {
                    return ListView(
                      children: [
                        SkeletonAnimation(
                            child: Container(
                          margin: EdgeInsets.all(20),
                          color: Colors.grey.shade50,
                        ))
                      ],
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
