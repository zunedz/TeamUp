import 'package:flutter/material.dart';

class InvitationNotificationItem extends StatelessWidget {
  final String senderName;
  final String senderId;
  final String createdAt;
  final String roomId;

  InvitationNotificationItem(
      this.createdAt, this.senderId, this.senderName, this.roomId);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("$senderName invited you to join this room!"),
      subtitle: Text(createdAt),
      trailing: TextButton(
        child: Text("Join room"),
        onPressed: () {},
      ),
    );
  }
}
