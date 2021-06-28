import 'package:flutter/material.dart';
import 'package:orbital_login/models/user.dart';

class FriendListItem extends StatelessWidget {
  final AppUser friend;

  FriendListItem(this.friend);
  String getStatus(AppUser friend) {
    if (friend.isOnline == false) {
      return "Offline";
    } else {
      return "Currently Playing ${friend.currentGame!.title}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        child: Row(
          children: [
            Text(
              friend.username!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Expanded(
              child: Text(
                getStatus(friend),
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        margin: EdgeInsets.all(20),
      ),
    );
  }
}
