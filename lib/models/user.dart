import 'package:flutter/foundation.dart';
import 'package:orbital_login/dummy_data/dummy_data.dart';
import 'package:orbital_login/models/game.dart';
import 'package:orbital_login/models/notification.dart';
import 'package:orbital_login/models/room.dart';

class User with ChangeNotifier {
  final String? id;
  final String? userName;
  final String? email;
  bool? isOnline;
  bool? isInsideRoom;
  List<Room> currentRoom = [];
  Game? currentGame;
  List<User>? friendList = [];
  List<Notification> notificationList = [];
  String? pictureUrl;
  DateTime? dateCreated;

  User({
    @required this.id,
    @required this.userName,
    @required this.dateCreated,
    @required this.email,
    @required this.isInsideRoom,
    @required this.isOnline,
    @required this.pictureUrl,
  });
  void addNotification(Notification newNotification) {
    notificationList.add(newNotification);
    notifyListeners();
  }

  void removeNotification(String notificationId) {
    notificationList.removeWhere((element) => element.id == notificationId);
    notifyListeners();
  }

  void addFriend(User newFriend) {
    friendList!.add(newFriend);
    newFriend.addNotification(
      Notification(
          id: DateTime.now().toString(),
          notificationSender: this,
          timeReceived: DateTime.now(),
          type: NotificationType.Follow),
    );
    notifyListeners();
  }

  void removeFriend(String id) {
    friendList!.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearNotification() {
    this.notificationList.clear();
    notifyListeners();
  }

  bool joinRoom(Room newRoom) {
    if (newRoom.addUser(this)) {
      isInsideRoom = true;
      currentRoom.add(newRoom);
      notifyListeners();
      return true;
    } else
      return false;
  }

  void leaveRoom() {
    currentRoom[0].removeUser(id!);
    currentRoom.clear();
    isInsideRoom = false;
    notifyListeners();
  }

  Room createRoom(Game gamePlayed, String description, int maxcapacity,
      String discordUrl, String roomName) {
    Room newRoom = Room(
      roomName: roomName,
      description: description,
      gamePlayed: gamePlayed,
      id: DateTime.now().toString(),
      maxCapacity: maxcapacity,
    );
    roomList.addRoom(newRoom);
    newRoom.addUser(this);
    isInsideRoom = true;
    currentRoom.add(newRoom);
    notifyListeners();
    return newRoom;
  }
}
