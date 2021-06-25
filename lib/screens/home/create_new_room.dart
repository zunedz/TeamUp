import 'package:flutter/material.dart';
import 'package:orbital_login/models/game.dart';
import 'package:orbital_login/models/room.dart';
import 'package:orbital_login/models/user.dart';
import 'package:provider/provider.dart';

class CreateNewRoom extends StatefulWidget {
  @override
  _CreateNewRoomState createState() => _CreateNewRoomState();
}

class _CreateNewRoomState extends State<CreateNewRoom> {
  final formKey = new GlobalKey<FormState>();

  String? roomName, gameName, description;
  int? maxCapacity;

  InputDecoration inputDecoration(String field) {
    return new InputDecoration(
      labelText: field,
      fillColor: Colors.white,
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
      border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(25.0),
        borderSide: new BorderSide(),
      ),
      //fillColor: Colors.green
    );
  }

  @override
  Widget build(BuildContext context) {
    final Rooms roomList = Provider.of<Rooms>(context);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.fromLTRB(15.0, 0, 15, 0),
        children: [
          SizedBox(height: 10),
          Container(
            height: 150,
            child: Center(
              child: Text(
                "Create a New Room",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Form(
            key: formKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) => val == null ? "Cannot be empty" : null,
                    onSaved: (value) {
                      roomName = value!.trim();
                    },
                    decoration: inputDecoration("Room Name"),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (val) => val == null ? "Cannot be empty" : null,
                    onChanged: (value) {
                      gameName = value.trim();
                    },
                    decoration: inputDecoration("Game Name"),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val == null) {
                        return "Field cannot be empty";
                      } else if (int.parse(val) < 0) {
                        return "Maximum capacity cannot be less than 0";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      maxCapacity = int.parse(value);
                    },
                    decoration: inputDecoration("Maximum Room Capacity"),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (value) {
                      description = value;
                    },
                    decoration: inputDecoration("Description"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
          Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: MaterialButton(
              onPressed: () {
                final form = formKey.currentState;
                if (form != null) {
                  if (form.validate()) {
                    form.save();
                    Game newGame = Game("gameUrl", "imageUrl", gameName!);
                    Room newRoom = Room(
                        roomName: roomName,
                        id: DateTime.now().toString(),
                        description: description,
                        gamePlayed: newGame,
                        maxCapacity: maxCapacity);
                    roomList.addRoom(newRoom);
                    Navigator.of(context).pop();
                  }
                }
                return;
              },
              elevation: 0,
              height: 50,
              color: Colors.purple.shade200,
              minWidth: 10000,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Center(
                child: Text(
                  "Create Room",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
