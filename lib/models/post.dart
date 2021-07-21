import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Post {
  Post(
      {required this.postId,
      required this.createdAt,
      required this.likesArray,
      required this.senderId,
      required this.text,
      required this.imageUrl});

  String postId;
  Timestamp createdAt;
  String text;
  String senderId;
  List<dynamic> likesArray;
  String imageUrl;
}
