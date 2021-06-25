import 'package:orbital_login/models/game.dart';
import 'package:orbital_login/models/room.dart';
import 'package:orbital_login/models/user.dart';

User user1 = User(
  isInsideRoom: false,
  isOnline: false,
  pictureUrl: "https://miro.medium.com/max/239/1*U8_90Kf74Oc0xRF8iOV6jw.png",
  userName: "username1",
  dateCreated: DateTime.now(),
  email: "asda@gmail.com",
  id: "1",
);

User user2 = User(
  isInsideRoom: false,
  isOnline: false,
  pictureUrl: "",
  userName: "username2",
  dateCreated: DateTime.now(),
  email: "asda2@gmail.com",
  id: "2",
);

User user3 = User(
  isInsideRoom: false,
  isOnline: false,
  pictureUrl: "",
  userName: "username3",
  dateCreated: DateTime.now(),
  email: "asda3@gmail.com",
  id: "3",
);

User user4 = User(
  isInsideRoom: false,
  isOnline: false,
  pictureUrl: "",
  userName: "username4",
  dateCreated: DateTime.now(),
  email: "asda4@gmail.com",
  id: "4",
);

Game dota2 = Game(
    "gameUrl",
    "https://m.media-amazon.com/images/M/MV5BZDQxMjVmMjYtZTU4OC00MzRhLTljNTgtMTAwMDg3YzhlY2M4L2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_.jpg",
    "dota2");

Rooms roomList = Rooms();
