import 'package:flutter/material.dart';
import 'package:orbital_login/models/room.dart';
import 'package:orbital_login/widgets/find_room/room_item.dart';
import 'package:provider/provider.dart';

class FindRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Rooms roomList = Provider.of<Rooms>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            //search bar
            margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Material(
              color: Colors.grey.shade100,
              elevation: 0,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: TextField(
                controller: TextEditingController(),
                cursorColor: Colors.purple.shade300,
                decoration: InputDecoration(
                  hintText: "search game ",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                  suffixIcon: Material(
                    elevation: 5.0,
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
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return RoomItem(roomList.getRoomAtIndex(index));
              },
              itemCount: roomList.getLength(),
            ),
          ),
        ],
      ),
    );
  }
}
