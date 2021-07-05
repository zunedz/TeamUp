import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/widgets/following_list/following_list_item.dart';
import 'package:orbital_login/widgets/loadingScreen.dart';

class FollowingListPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('appUser')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return LoadingScreen();
                  }
                  var followingIdArray = userSnapshot.data!['followingIdArray'];
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
                            return FollowingListItem(
                                snapshot.data!['avatarUrl'],
                                snapshot.data!['userId'],
                                snapshot.data!['username']);
                          });
                    },
                    itemCount: followingIdArray.length,
                  );
                }),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/home/search-following-screen');
            },
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  border: Border.all(color: Colors.purple.shade900, width: 1)),
              width: 300,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/add-user.png',
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Follow people",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    softWrap: true,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 15)
        ],
      ),
    );
  }
}
