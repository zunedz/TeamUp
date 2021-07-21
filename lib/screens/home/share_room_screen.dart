import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:orbital_login/models/room.dart';
import 'package:orbital_login/widgets/share_room/share_room_item.dart';

class ShareRoom extends StatefulWidget {
  @override
  _ShareRoomState createState() => _ShareRoomState();
}

class _ShareRoomState extends State<ShareRoom> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find a room"),
        elevation: 2,
      ),
      body: Column(
        children: [
          Container(
            //search bar
            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Material(
              color: Colors.grey.shade100,
              elevation: 0,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: TextField(
                controller: _searchController,
                cursorColor: Colors.purple.shade300,
                decoration: InputDecoration(
                  hintText: "search game ",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            //list of rooms
            child: FutureBuilder(
              future: _searchController.text.trim() == ""
                  ? FirebaseFirestore.instance.collection('chatRoom').get()
                  : FirebaseFirestore.instance
                      .collection('chatRoom')
                      .where(
                        'gameName',
                        isEqualTo: _searchController.text.trim().toUpperCase(),
                      )
                      .get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      futureChatRoomSnapshots) {
                if (futureChatRoomSnapshots.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(100.0),
                      child: LoadingIndicator(
                        indicatorType: Indicator.lineScale,
                        color: Colors.purple.shade300,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder: (ctx, index) {
                    var roomItemQuery =
                        futureChatRoomSnapshots.data!.docs[index].data();
                    print(roomItemQuery['userIdArray']);
                    var currentRoom = new Room(
                        description: roomItemQuery["roomDescription"],
                        gamePlayed: roomItemQuery['gameName'],
                        id: roomItemQuery['roomId'],
                        maxCapacity: roomItemQuery['roomCapacity'],
                        roomName: roomItemQuery['roomName'],
                        users: roomItemQuery['userIdArray']);
                    return RoomItem(currentRoom);
                  },
                  itemCount: futureChatRoomSnapshots.data!.docs.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
