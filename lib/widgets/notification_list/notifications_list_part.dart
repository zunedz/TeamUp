import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_login/widgets/loadingScreen.dart';
import 'package:orbital_login/widgets/notification_list/following_notification_item.dart';
import 'package:orbital_login/widgets/notification_list/invitation_notification_item.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationListPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                'appUser/${FirebaseAuth.instance.currentUser!.uid}/Notification')
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }
          var notificationList = snapshot.data!.docs;
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      var currentNotification = notificationList[index].data();
                      if (currentNotification["notificationType"] ==
                          "followingNotification") {
                        return FollowingNotificationItem(
                            timeago.format(
                                DateTime.parse(currentNotification["createdAt"]
                                    .toDate()
                                    .toString()),
                                locale: 'en_short'),
                            currentNotification["senderId"],
                            currentNotification["senderName"]);
                      }

                      return InvitationNotificationItem(
                          timeago.format(
                              DateTime.parse(currentNotification["createdAt"]
                                  .toDate()
                                  .toString()),
                              locale: 'en_short'),
                          currentNotification["senderId"],
                          currentNotification["senderName"],
                          currentNotification["roomId"]);
                    },
                    itemCount: notificationList.length,
                  ),
                )
              ],
            ),
          );
        });
  }
}
