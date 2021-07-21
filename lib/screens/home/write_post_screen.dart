import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class WritePostScreen extends StatefulWidget {
  const WritePostScreen({Key? key}) : super(key: key);

  @override
  _WritePostScreenState createState() => _WritePostScreenState();
}

class _WritePostScreenState extends State<WritePostScreen> {
  TextEditingController _textEditingController = TextEditingController();
  File? _imageFile;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  setImage(imageFile) {
    setState(() {
      _imageFile = imageFile;
    });
  }

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
                      var imageUrl;

                      String filePath = 'postImages/${postRef.id}.png';
                      if (_imageFile != null) {
                        await _storage
                            .ref()
                            .child(filePath)
                            .putFile(_imageFile!);
                        imageUrl = await _storage
                            .ref()
                            .child(filePath)
                            .getDownloadURL();
                      }

                      await postRef.set({
                        'postId': postRef.id,
                        'text': _textEditingController.text,
                        'senderId': FirebaseAuth.instance.currentUser!.uid,
                        'createdAt': Timestamp.now(),
                        'likesArray': [],
                        'dislikesArray': [],
                        'type': "text",
                        'image': _imageFile == null ? "-" : imageUrl,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            _imageFile != null
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Image.file(_imageFile!))
                : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed('/home/post-image-picker', arguments: setImage);
        },
        child: Icon(Icons.add_photo_alternate),
      ),
    );
  }
}
