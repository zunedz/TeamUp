import 'package:cloud_firestore/cloud_firestore.dart';

isFollowed(List<dynamic> followingList, String userId) {
  return followingList.contains(userId);
}

isFollowingYou(List<dynamic> followersList, String userId) {
  return followersList.contains(userId);
}

follow(String myUserId, String userId, String myUsername) async {
  await FirebaseFirestore.instance.collection('appUser').doc(myUserId).update({
    "followingIdArray": FieldValue.arrayUnion([userId]),
  });
  await FirebaseFirestore.instance.collection("appUser").doc(userId).update({
    "followerIdArray": FieldValue.arrayUnion([myUserId])
  });

  var notificationRef =
      FirebaseFirestore.instance.collection("appUser/$userId/Notification");

  var newNotification = notificationRef.doc();
  await notificationRef.doc(newNotification.id).set({
    "createdAt": Timestamp.now(),
    "senderName": myUsername,
    "docId": newNotification.id,
    "senderId": myUserId,
    "notificationType": "followingNotification",
  });
}

unfollow(String myUserId, String userId) async {
  await FirebaseFirestore.instance.collection('appUser').doc(myUserId).update({
    "followingIdArray": FieldValue.arrayRemove([userId]),
  });
  await FirebaseFirestore.instance.collection("appUser").doc(userId).update({
    "followerIdArray": FieldValue.arrayRemove([myUserId])
  });
}
