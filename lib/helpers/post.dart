import 'package:cloud_firestore/cloud_firestore.dart';

bool isLiked(List<dynamic> likesArray, String userId) {
  return likesArray.contains(userId);
}

bool isDisliked(List<dynamic> dislikesArray, String userId) {
  return dislikesArray.contains(userId);
}

Future<void> retractResponse(String postId, String userId) async {
  var postRef = FirebaseFirestore.instance.collection('post').doc(postId);

  await postRef.update({
    "likesArray": FieldValue.arrayRemove([userId]),
    "dislikesArray": FieldValue.arrayRemove([userId])
  });
}

Future<void> likePost(String postId, String userId) async {
  var postRef = FirebaseFirestore.instance.collection('post').doc(postId);

  await retractResponse(postId, userId);
  await postRef.update({
    "likesArray": FieldValue.arrayUnion([userId])
  });
}

Future<void> dislikePost(String postId, String userId) async {
  var postRef = FirebaseFirestore.instance.collection('post').doc(postId);

  await retractResponse(postId, userId);
  await postRef.update({
    "dislikesArray": FieldValue.arrayUnion([userId])
  });
}
