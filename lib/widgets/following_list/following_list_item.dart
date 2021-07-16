import 'package:flutter/material.dart';

class FollowingListItem extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String userId;

  FollowingListItem(this.imageUrl, this.userId, this.userName);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image:
              DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        ),
      ),
      title: Text(
        userName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      trailing: Text(
        "offline",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
