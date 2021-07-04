import 'package:flutter/material.dart';
import 'package:orbital_login/models/user.dart';

class FollowingListItem extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String userId;

  FollowingListItem(this.imageUrl, this.userId, this.userName);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        imageUrl,
      ),
      title: Text(userName),
      trailing: Text("offline"),
    );
  }
}
