import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";

import 'screens/auth/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogIn(),
      theme: ThemeData(
        primaryColor: Colors.purple.shade300,
        fontFamily: "Montserrat",
      ),
    );
  }
}
