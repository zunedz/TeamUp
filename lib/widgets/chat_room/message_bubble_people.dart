import 'package:flutter/material.dart';

class MessageBubblePeople extends StatelessWidget {
  final String message;
  final String userName;

  MessageBubblePeople(this.message, this.userName);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 140,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  topRight: Radius.circular(15))),
          child: Column(
            children: [
              Text(
                userName,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              Text(
                message,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
