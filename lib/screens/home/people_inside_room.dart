import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/widgets/people_inside_room/people_inside_room_item.dart';

class PeopleInsideRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    List<dynamic> userIdArray = args['userIdArray'];
    String roomName = args['roomName'];

    return Scaffold(
      appBar: AppBar(
        title: Text("$roomName ( ${userIdArray.length} )"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: userIdArray.length,
                  itemBuilder: (ctx, index) {
                    return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('appUser')
                            .doc(userIdArray[index])
                            .get(),
                        builder: (context,
                            AsyncSnapshot<
                                    DocumentSnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                            );
                          }
                          String imageUrl = snapshot.data!['avatarUrl'];
                          String username = snapshot.data!['username'];
                          String userId = snapshot.data!['userId'];

                          return PeopleInsideRoomItem(
                              imageUrl, userId, username);
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
