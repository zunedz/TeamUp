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

Future<void> likePost(List<dynamic> dislikesArray, List<dynamic> likesArray,
    String postId, String userId) async {
  var postRef = FirebaseFirestore.instance.collection('post').doc(postId);

  if (isLiked(likesArray, userId)) {
    await retractResponse(postId, userId);
    return;
  } else if (isDisliked(dislikesArray, userId)) {
    await postRef.update({
      "likesArray": FieldValue.arrayUnion([userId]),
      "dislikesArray": FieldValue.arrayRemove([userId])
    });
    return;
  }
  await postRef.update({
    "likesArray": FieldValue.arrayUnion([userId])
  });
}

Future<void> dislikePost(List<dynamic> likesArray, List<dynamic> dislikesArray,
    String postId, String userId) async {
  var postRef = FirebaseFirestore.instance.collection('post').doc(postId);

  if (isDisliked(dislikesArray, userId)) {
    await retractResponse(postId, userId);
    return;
  } else if (isLiked(likesArray, userId)) {
    await postRef.update({
      "likesArray": FieldValue.arrayRemove([userId]),
      "dislikesArray": FieldValue.arrayUnion([userId])
    });
    return;
  }
  await postRef.update({
    "dislikesArray": FieldValue.arrayUnion([userId])
  });
}
