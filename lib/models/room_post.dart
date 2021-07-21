import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class RoomPost {
  RoomPost({
    required this.postId,
    required this.createdAt,
    required this.roomId,
    required this.senderId,
  });

  String postId;
  Timestamp createdAt;
  String senderId;
  String roomId;
}
