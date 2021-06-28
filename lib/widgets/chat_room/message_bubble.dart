import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;

  MessageBubble(this.message);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 140,
          
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Text(
            message,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
