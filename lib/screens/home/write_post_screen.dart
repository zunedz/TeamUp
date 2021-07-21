import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WritePostScreen extends StatefulWidget {
  const WritePostScreen({Key? key}) : super(key: key);

  @override
  _WritePostScreenState createState() => _WritePostScreenState();
}

class _WritePostScreenState extends State<WritePostScreen> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Write a post"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: Navigator.of(context).pop,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: MaterialButton(
              color: _textEditingController.text.trim() == ""
                  ? Colors.grey
                  : Theme.of(context).accentColor,
              child: Text(
                "POST",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              onPressed: _textEditingController.text.trim() == ""
                  ? () {}
                  : () async {
                      var postRef =
                          FirebaseFirestore.instance.collection('post').doc();
                      await postRef.set({
                        'postId': postRef.id,
                        'text': _textEditingController.text,
                        'senderId': FirebaseAuth.instance.currentUser!.uid,
                        'createdAt': Timestamp.now(),
                        'likesArray': [],
                        'dislikesArray': [],
                        'type': "text",
                      });
                      Navigator.of(context).pop();
                    },
            ),
          )
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                maxLength: 500,
                onChanged: (val) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: "Write something....",
                ),
                controller: _textEditingController,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_photo_alternate),
      ),
    );
  }
}
