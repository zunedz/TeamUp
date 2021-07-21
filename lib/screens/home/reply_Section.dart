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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.reply),
        onPressed: () => Navigator.of(context)
            .pushNamed('/home/write-reply-screen', arguments: {
          'post': post,
          'currentRef': currentRef,
          'replyingTo': senderName
        }),
      ),
      appBar: AppBar(
        title: Text("Reply"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('$currentRef/${post.postId}/replies')
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      replySnapshot) {
                if (replySnapshot.hasData) {
                  var replyList = replySnapshot.data!.docs;
                  replyList.sort((a, b) => helperFunction()
                      .getLikes(b)
                      .compareTo(helperFunction().getLikes(a)));

                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      if (index == 0) {
                        return ReplyItemMain(post, currentRef);
                      } else {
                        var currentPost = replyList[index - 1].data();
                        Post currentReply = Post(
                            imageUrl: "",
                            createdAt: currentPost['createdAt'],
                            likesArray: currentPost['likesArray'],
                            postId: currentPost['postId'],
                            senderId: currentPost['senderId'],
                            text: currentPost['text']);
                        return ReplyItem(currentReply, senderName,
                            '$currentRef/${post.postId}');
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
        ],
      ),
    );
  }
}

class helperFunction {
  int getLikes(var a) {
    return a.data()['likesArray'].length - a.data()['dislikesArray'].length;
  }
}
