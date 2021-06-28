import 'package:flutter/material.dart';
import 'package:orbital_login/models/room.dart';

class RoomItem extends StatelessWidget {
  final Room roomData;
  RoomItem(this.roomData);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          collapsedBackgroundColor: Colors.grey.shade200,
          leading: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/default.png'),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                roomData.roomName!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "${roomData.users.length} / ${roomData.maxCapacity}",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          children: [
            ListTile(
              trailing: TextButton(
                child: Text(
                  "JOIN ROOM",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('home/chat-room-screen',
                      arguments: roomData.id);
                }, //push and replace the chatroom screen to the screenstacks.
              ),
              title: Text(
                roomData.gamePlayed!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text(
                roomData.description!,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
            // Text(roomData.description!),
            // ElevatedButton(onPressed: () {}, child: Text("join room"))
          ],
        ),
      ),
    );
  }
}
