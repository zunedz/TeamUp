import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:orbital_login/models/game.dart';
import 'package:orbital_login/models/notification.dart';
import 'package:orbital_login/models/room.dart';

// class AppUser {
//   String? uid;
//   User? user;
//   String? email;
//   bool isVerified = false;
//   bool isAnon = false;
//   String? profilePicURL;
//   String? username;

//   AppUser();
// }

class AppUser with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String? id;
  String? username;
  String? email;
  bool? isVerified;
  bool? isOnline;
  bool? isInsideRoom;
  List<Room> currentRoom = [];
  Game? currentGame;
  List<AppUser>? friendList = [];
  List<Notification> notificationList = [];
  String? pictureUrl;
  DateTime? dateCreated;

  AppUser({
    @required this.id,
    @required this.username,
    @required this.dateCreated,
    @required this.email,
    @required this.isInsideRoom,
    @required this.isOnline,
    @required this.pictureUrl,
  });

  String getUserId() {
    return _auth.currentUser!.uid;
  }

  AppUser.fromFirebaseUser(User user) {
    // this.user = user;
    this.id = user.uid;
    this.username = user.displayName;
    this.email = user.email;
    this.isVerified = user.emailVerified;
    this.pictureUrl = user.photoURL;
  }

  void addNotification(Notification newNotification) {
    notificationList.add(newNotification);
    notifyListeners();
  }

  void removeNotification(String notificationId) {
    notificationList.removeWhere((element) => element.id == notificationId);
    notifyListeners();
  }

  void addFriend(AppUser newFriend) {
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
        gamePlayed: "gamePlayed",
        id: DateTime.now().toString(),
        maxCapacity: maxcapacity,
        users: []);

    newRoom.addUser(this);
    isInsideRoom = true;
    currentRoom.add(newRoom);
    notifyListeners();
    return newRoom;
  }
}
