import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:orbital_login/widgets/invite_friend/invite_friend_item.dart';
import 'package:orbital_login/widgets/loadingScreen.dart';

class InviteFriendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Invite friend"),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('appUser')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get(),
                  builder: (context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return LoadingScreen();
                    }
                    var followingIdArray =
                        userSnapshot.data!['followingIdArray'];
                    print(followingIdArray);
                    return ListView.builder(
                      itemBuilder: (ctx, index) {
                        var followingId = followingIdArray[index];
                        return FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('appUser')
                                .doc(followingId)
                                .get(),
                            builder: (context,
                                AsyncSnapshot<
                                        DocumentSnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return ListTile(
                                  leading: CircularProgressIndicator(
                                    color: Theme.of(context).accentColor,
                                  ),
                                );
                              }
                              return InviteFriendItem(
                                  snapshot.data!['avatarUrl'],
                                  snapshot.data!['userId'],
                                  snapshot.data!['username'],
                                  userSnapshot.data!["username"],
                                  userSnapshot.data!["roomId"]);
                            });
                      },
                      itemCount: followingIdArray.length,
                    );
                  }),
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}
