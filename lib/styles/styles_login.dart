import 'package:flutter/material.dart';

TextStyle titleStyle = TextStyle(
  fontSize: 80.0,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);

TextStyle signStyle = TextStyle(
  color: Colors.purple,
  fontSize: 80.0,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);

TextStyle labelStyle = TextStyle(
  fontFamily: "Montserrat",
  fontWeight: FontWeight.bold,
  color: Colors.grey,
);

InputDecoration inputDecoration(String field) {
  return new InputDecoration(
    labelText: field,
    fillColor: Colors.white,
    labelStyle: labelStyle,
    border: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(25.0),
      borderSide: new BorderSide(),
    ),
    //fillColor: Colors.green
  );
}

TextStyle hyperlinkStyle = TextStyle(
  color: Colors.purple,
  fontFamily: "Montserrat",
  fontWeight: FontWeight.bold,
);
