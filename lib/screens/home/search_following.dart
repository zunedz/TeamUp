import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/widgets/loadingScreen.dart';
import 'package:orbital_login/widgets/search_following/search_following_item.dart';

class SearchFollowingScreen extends StatefulWidget {
  @override
  _SearchFollowingScreenState createState() => _SearchFollowingScreenState();
}

class _SearchFollowingScreenState extends State<SearchFollowingScreen> {
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    TextEditingController searchTextController = new TextEditingController();

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                elevation: 0,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: TextField(
                  controller: searchTextController,
                  cursorColor: Colors.purple.shade300,
                  decoration: InputDecoration(
                    hintText: "search by username",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                    suffixIcon: InkWell(
                      onTap: () {
                        var tempQuery = searchTextController.text.trim();
                        setState(() {
                          searchQuery = tempQuery;
                        });
                      },
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('appUser')
                      .where("username", isEqualTo: searchQuery)
                      .get(),
                  builder: (ctx,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          futureSnapshots) {
                    if (futureSnapshots.connectionState ==
                        ConnectionState.waiting) {
                      return LoadingScreen();
                    }
                    print(searchQuery);
                    var followingList = futureSnapshots.data!.docs;
                    print(followingList);

                    return ListView.builder(
                      itemBuilder: (ctx, index) {
                        return SearchFollowingItem(
                            followingList[index]["avatarUrl"],
                            followingList[index]["userId"],
                            followingList[index]["username"]);
                      },
                      itemCount: followingList.length,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
