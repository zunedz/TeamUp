import 'package:flutter/material.dart';
import 'package:orbital_login/models/user.dart';
import 'package:orbital_login/widgets/notification_list/notifications_list_item.dart';
import 'package:provider/provider.dart';

class NotificationListPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationList = Provider.of<User>(context).notificationList;

    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return NotificationListItem(notificationList[index]);
              },
              itemCount: notificationList.length,
            ),
          )
        ],
      ),
    );
  }
}
