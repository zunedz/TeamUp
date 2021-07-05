import 'package:flutter/material.dart';

class MessageBubbleJoin extends StatelessWidget {
  final String? message;

  MessageBubbleJoin(this.message);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message!,
          style: TextStyle(color: Theme.of(context).accentColor),
        )
      ],
    );
  }
}
