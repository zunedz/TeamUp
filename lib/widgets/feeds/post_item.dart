import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evil_icons_flutter/evil_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/helpers/post.dart';
import 'package:orbital_login/models/post.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostItem extends StatelessWidget {
  PostItem(this.post);

  final Post post;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.75;

    return Padding(
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
                .collection('post')
                .doc(post.postId)
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
              var likesArray = postSnapshot.data!['likesArray'];
              var dislikesArray = postSnapshot.data!['dislikesArray'];
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
                              width: c_width,
                              child: Text(
                                post.text,
                                maxLines: 1000,
                                softWrap: true,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          likePost(dislikesArray, likesArray,
                                              post.postId, userId, 'post');
                                        },
                                        icon: Icon(
                                          EvilIcons.arrow_up,
                                          color: isLiked(likesArray, userId)
                                              ? Theme.of(context).accentColor
                                              : Colors.grey.shade600,
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        (likesArray.length -
                                                dislikesArray.length)
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          dislikePost(likesArray, dislikesArray,
                                              post.postId, userId, 'post');
                                        },
                                        icon: Icon(
                                          EvilIcons.arrow_down,
                                          color:
                                              isDisliked(dislikesArray, userId)
                                                  ? Colors.red
                                                  : Colors.grey.shade600,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: c_width * 0.3,
                                  ),
                                  IconButton(
                                      onPressed: () => Navigator.of(context)
                                              .pushNamed(
                                                  '/home/reply-section-screen',
                                                  arguments: {
                                                'post': post,
                                                'senderName': userSnapshot
                                                    .data!['username'],
                                                'postRef': 'post'
                                              }),
                                      icon: Icon(
                                        EvilIcons.comment,
                                        color: Colors.grey.shade600,
                                        size: 30,
                                      ))
                                ])
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
