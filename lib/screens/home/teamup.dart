import "package:flutter/material.dart";
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

Widget teamUp() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Colors.purple.shade200,
          ),
          child: MaterialButton(
            onPressed: () {},
            child: Center(
              child: Icon(
                LineIcons.search,
                color: Colors.white,
                size: 100,
                semanticLabel: "Find Existing session",
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Colors.purple.shade200,
          ),
          child: MaterialButton(
            onPressed: () {},
            child: Center(
              child: Icon(
                LineIcons.plus,
                color: Colors.white,
                size: 120,
                semanticLabel: "Find Existing session",
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
