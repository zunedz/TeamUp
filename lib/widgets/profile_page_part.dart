import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orbital_login/models/user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePagePart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppUser userData = Provider.of<AppUser>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Material(
              elevation: 4.0,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              color: Colors.transparent,
              child: Ink.image(
                image: NetworkImage(userData.pictureUrl!),
                fit: BoxFit.cover,
                width: 200.0,
                height: 200.0,
                child: InkWell(
                  onTap: () {},
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username",
                  style: TextStyle(color: Colors.purple),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  userData.userName!,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Email",
                  style: TextStyle(color: Colors.purple),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  userData.email!,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Joined since",
                  style: TextStyle(color: Colors.purple),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  DateFormat('dd-MM-yyyy').format(userData.dateCreated!),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
