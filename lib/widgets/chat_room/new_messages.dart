import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  final currentRoom;
  NewMessages(this.currentRoom);

  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var chatInputController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (val) {
                setState(() {});
              },
              controller: chatInputController,
              decoration: InputDecoration(hintText: "new message"),
            ),
          ),
          IconButton(
            onPressed: chatInputController.text.trim() == ""
                ? null
                : () {
                    FirebaseFirestore.instance
                        .collection(
                            'chatRoom/${widget.currentRoom["roomId"]}/chats')
                        .add(
                      {
                        "text": chatInputController.text,
                        "createdAt": Timestamp.now()
                      },
                    );
                    FocusScope.of(context).unfocus();
                    chatInputController.clear();
                  },
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
