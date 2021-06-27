import 'package:flutter/foundation.dart';
import 'package:orbital_login/models/room.dart';
import 'package:orbital_login/models/user.dart';

enum NotificationType {
  Invitation,
  Follow,
}

class Notification {
  final String? id;
  final AppUser? notificationSender;
  final NotificationType? type;
  final DateTime? timeReceived;

  Notification({
    @required this.id,
    @required this.notificationSender,
    @required this.timeReceived,
    @required this.type,
  });
}

class InviteNotification extends Notification {
  final Room? invitedRoom;

  InviteNotification(AppUser notificationSender, Room invitedRoom, String id)
      : this.invitedRoom = invitedRoom,
        super(
          id: id,
          notificationSender: notificationSender,
          timeReceived: DateTime.now(),
          type: NotificationType.Invitation,
        );
}

class FollowNotification extends Notification {
  FollowNotification(AppUser notificationSender, Room invitedRoom, String id)
      : super(
          id: id,
          notificationSender: notificationSender,
          timeReceived: DateTime.now(),
          type: NotificationType.Follow,
        );
}

class Notifications with ChangeNotifier {
  List<Notification> notifList = [];

  void addNotification(Notification newNotif) {
    notifList.add(newNotif);
    notifyListeners();
  }

  void removeNotification(String notificationId) {
    notifList.removeWhere((element) => element.id == notificationId);
    notifyListeners();
  }
}
