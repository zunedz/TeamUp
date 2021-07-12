import 'package:flutter/foundation.dart';

class Post {
  Post(
      {required this.postId,
      required this.createdAt,
      required this.likesArray,
      required this.senderId,
      required this.text});

  String postId;
  DateTime createdAt;
  String text;
  String senderId;
  List<String> likesArray;
}
