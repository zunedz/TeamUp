import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        child: TextField(
          controller: TextEditingController(),
          cursorColor: Colors.purple.shade300,
          decoration: InputDecoration(
            hintText: "search by username",
            contentPadding:
                EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
            suffixIcon: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
