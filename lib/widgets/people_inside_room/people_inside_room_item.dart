import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/helpers/follow.dart';
import 'package:skeleton_text/skeleton_text.dart';

class PeopleInsideRoomItem extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String userId;

  PeopleInsideRoomItem(this.imageUrl, this.userId, this.userName);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("appUser")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SkeletonAnimation(
              child: Container(
                width: 200,
                height: 200 * 0.4,
                margin: EdgeInsets.all(20),
                color: Colors.grey.shade50,
              ),
            );
          }
          return ListTile(
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
            trailing: userId == FirebaseAuth.instance.currentUser!.uid
                ? null
                : MaterialButton(
                    color:
                        isFollowed(snapshot.data!['followingIdArray'], userId)
                            ? Theme.of(context).accentColor
                            : Colors.white,
                    child:
                        isFollowed(snapshot.data!['followingIdArray'], userId)
                            ? Text(
                                "Followed",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            : isFollowingYou(
                                    snapshot.data!['followerIdArray'], userId)
                                ? Text(
                                    "Follow back",
                                    style: TextStyle(
                                        color: Colors.purpleAccent,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "Follow",
                                    style: TextStyle(
                                        color: Colors.purpleAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: () {
                      if (isFollowed(
                          snapshot.data!['followingIdArray'], userId)) {
                        unfollow(snapshot.data!['userId'], userId);
                      } else {
                        follow(snapshot.data!['userId'], userId,
                            snapshot.data!['username']);
                      }
                    }),
          );
        });
  }
}
