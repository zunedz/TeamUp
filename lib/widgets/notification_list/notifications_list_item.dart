import 'package:flutter/material.dart';
import '../../models/notification.dart' as Notif;
import 'package:intl/intl.dart';

class NotificationListItem extends StatelessWidget {
  final Notif.Notification notification;

  NotificationListItem(this.notification);

  @override
  Widget build(BuildContext context) {
    if (notification.type == Notif.NotificationType.Follow) {
      return InkWell(
        onTap: () {},
        child: Card(
          elevation: 5.0,
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            child: Row(
              children: [
                Flexible(
                  flex: 4,
                  child: Text(
                    "${notification.notificationSender!.userName!} just followed you",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    DateFormat('MM-dd').format(notification.timeReceived!),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.all(20),
          ),
        ),
      );
    } else
      return InkWell(
        onTap: () {},
        child: Card(
          elevation: 5.0,
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            child: Row(
              children: [
                Flexible(
                  flex: 4,
                  child: Text(
                    "${notification.notificationSender!.userName!} invite you to join a room",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    notification.timeReceived.toString(),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.all(20),
          ),
        ),
      );
  }
}
