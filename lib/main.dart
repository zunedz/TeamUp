import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbital_login/screens/home/chat_room_screen.dart';
import 'package:orbital_login/screens/home/search_following.dart';
import 'package:orbital_login/services/authentication/authentication_cubit.dart';
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
  final AuthenticationCubit auth = AuthenticationCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: MultiProvider(
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
          initialRoute: '/',
          routes: {
            '/': (ctx) => Wrapper(),
            '/auth/login': (ctx) => LogIn(),
            '/auth/signup': (ctx) => SignUp(),
            '/auth/reset-password': (ctx) => ResetPassword(),
            '/home': (ctx) => Home(),
            '/home/find-room': (ctx) => FindRoom(),
            '/home/create-room': (ctx) => CreateNewRoom(),
            '/home/chat-room-screen': (ctx) => ChatRoomScreen(),
            '/home/search-following-screen': (ctx) => SearchFollowingScreen()
          },
        ),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Widget screen = _auth.currentUser == null ? LogIn() : Home();
    print('back to wrapper');

    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        screen = LogIn();
      } else {
        print('User is signed in!');
        screen = Home();
      }
    });

    return screen;
  }
}




















// return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => roomList),
//         ChangeNotifierProvider(create: (_) => user1)
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primaryColor: Colors.white,
//           accentColor: Colors.purpleAccent,
//           buttonColor: Colors.purpleAccent,
//           fontFamily: "Montserrat",
//         ),
//         initialRoute: '/auth/login',
//         routes: {
//           '/auth/login': (ctx) => LogIn(),
//           '/auth/signup': (ctx) => SignUp(),
//           '/auth/reset-password': (ctx) => ResetPassword(),
//           '/home': (ctx) => Home(),
//           '/home/find-room': (ctx) => FindRoom(),
//           '/home/create-room': (ctx) => CreateNewRoom(),
//         },
//       ),
//     );