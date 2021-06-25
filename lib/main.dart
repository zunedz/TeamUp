import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:orbital_login/dummy_data/dummy_data.dart';
import 'package:orbital_login/screens/auth/reset_password.dart';
import 'package:orbital_login/screens/auth/signup.dart';
import 'package:orbital_login/screens/home/create_new_room.dart';
import 'package:orbital_login/screens/home/home.dart';
import 'package:provider/provider.dart';

import 'screens/auth/login.dart';
import 'screens/home/find_room.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => roomList),
        ChangeNotifierProvider(create: (_) => user1)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.purpleAccent,
          buttonColor: Colors.purpleAccent,
          fontFamily: "Montserrat",
        ),
        initialRoute: '/auth/login',
        routes: {
          '/auth/login': (ctx) => LogIn(),
          '/auth/signup': (ctx) => SignUp(),
          '/auth/reset-password': (ctx) => ResetPassword(),
          '/home': (ctx) => Home(),
          '/home/find-room': (ctx) => FindRoom(),
          '/home/create-room': (ctx) => CreateNewRoom(),
        },
      ),
    );
  }
}
