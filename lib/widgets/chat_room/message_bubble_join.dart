import 'package:flutter/material.dart';

class MessageBubbleJoin extends StatelessWidget {
  final String? userName;

  MessageBubbleJoin(this.userName);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${userName} joins the room!",
          style: TextStyle(color: Theme.of(context).accentColor),
        )
      ],
    );
  }
}
