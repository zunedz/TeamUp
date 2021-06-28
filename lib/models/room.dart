import 'package:flutter/foundation.dart';
import 'package:orbital_login/models/user.dart';

import 'game.dart';

class Room with ChangeNotifier {
  final String? id;
  final String? roomName;
  final int? maxCapacity;
  List<AppUser> users = [];
  String? gamePlayed;
  String? description;

  Room({
    @required this.roomName,
    @required this.id,
    @required this.description,
    @required this.gamePlayed,
    @required this.maxCapacity,
  });

  bool addUser(AppUser newUser) {
    if (users.length < maxCapacity!) {
      users.add(newUser);
      notifyListeners();
      return true;
    } else
      return false;
  }

  void removeUser(String userId) {
    users.removeWhere((element) => element.id == userId);
    notifyListeners();
  }
}

class Rooms with ChangeNotifier {
  List<Room> roomList = [];

  void addRoom(Room newRoom) {
    roomList.add(newRoom);
    notifyListeners();
  }

  void removeRoom(String roomId) {
    roomList.removeWhere((element) => element.id == roomId);
    notifyListeners();
  }

  int getLength() {
    return roomList.length;
  }

  List<Room> getRoom() {
    return roomList;
  }

  Room getRoomAtIndex(int index) {
    return roomList[index];
  }
}
