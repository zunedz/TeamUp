import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evil_icons_flutter/evil_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orbital_login/helpers/post.dart';
import 'package:orbital_login/models/post.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ReplyItemMain extends StatelessWidget {
  ReplyItemMain(this.post, this.currentRef);

  final Post post;
  final String currentRef;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.9;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
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
                .collection(currentRef)
                .doc(post.postId)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    postSnapshot) {
              if (!postSnapshot.hasData || !userSnapshot.hasData) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    userSnapshot.data!['avatarUrl']),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          userSnapshot.data!['username'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
                      height: 10,
                    ),
                    post.imageUrl == "-"
                        ? Container()
                        : ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Image.network(post.imageUrl,
                                fit: BoxFit.fill, width: c_width),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat().add_yMd().add_jm().format(DateTime.parse(
                            post.createdAt.toDate().toString(),
                          )),
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                likePost(dislikesArray, likesArray, post.postId,
                                    userId, currentRef);
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
                              (likesArray.length - dislikesArray.length)
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
                                    post.postId, userId, currentRef);
                              },
                              icon: Icon(
                                EvilIcons.arrow_down,
                                color: isDisliked(dislikesArray, userId)
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
                            onPressed: () => Navigator.of(context).pushNamed(
                                    '/home/write-reply-screen',
                                    arguments: {
                                      'post': post,
                                      'currentRef': currentRef,
                                      'replyingTo':
                                          userSnapshot.data!['username']
                                    }),
                            icon: Icon(
                              EvilIcons.comment,
                              color: Colors.grey.shade600,
                              size: 30,
                            ))
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
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
