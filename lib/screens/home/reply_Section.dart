import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/models/post.dart';
import 'package:orbital_login/widgets/reply_sections/reply_item.dart';
import 'package:orbital_login/widgets/reply_sections/reply_item_main.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ReplySectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Post post = args['post'];
    String senderName = args['senderName'];
    String currentRef = args['postRef'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Reply"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('$currentRef/replies')
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      replySnapshot) {
                if (replySnapshot.hasData) {
                  var replyList = replySnapshot.data!.docs;

                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      if (index == 0) {
                        return ReplyItemMain(post);
                      } else {
                        var currentPost = replyList[index - 1].data();
                        Post currentReply = Post(
                            createdAt: currentPost['createdAt'],
                            likesArray: currentPost['likesArray'],
                            postId: currentPost['postId'],
                            senderId: currentPost['senderId'],
                            text: currentPost['text']);
                        return ReplyItem(currentReply, senderName, currentRef);
                      }
                    },
                    itemCount: replyList.length + 1,
                  );
                } else {
                  return ListView(
                    children: [
                      SkeletonAnimation(
                          child: Container(
                        margin: EdgeInsets.all(20),
                        color: Colors.grey.shade50,
                      ))
                    ],
                  );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                      '/home/write-reply-screen',
                      arguments: {'post': post, 'currentRef': currentRef}),
                  child: Text("reply"))
            ],
          )
        ],
      ),
    );
  }
}
