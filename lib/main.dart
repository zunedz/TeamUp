import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbital_login/screens/auth/waiting_screen.dart';
import 'package:orbital_login/screens/home/chat_room_screen.dart';
import 'package:orbital_login/screens/home/image_capture_screen.dart';
import 'package:orbital_login/screens/home/invite_friend.dart';
import 'package:orbital_login/screens/home/people_inside_room.dart';
import 'package:orbital_login/screens/home/post_image_picker.dart';
import 'package:orbital_login/screens/home/reply_Section.dart';
import 'package:orbital_login/screens/home/search_following.dart';
import 'package:orbital_login/screens/home/share_room_screen.dart';
import 'package:orbital_login/screens/home/write_post_screen.dart';
import 'package:orbital_login/screens/home/write_reply_screen.dart';
import 'package:orbital_login/services/authentication/authentication_cubit.dart';
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
          '/auth/waiting-screen': (ctx) => WaitingScreen(),
          '/home': (ctx) => Home(),
          '/home/find-room': (ctx) => FindRoom(),
          '/home/create-room': (ctx) => CreateNewRoom(),
          '/home/chat-room-screen': (ctx) => ChatRoomScreen(),
          '/home/search-following-screen': (ctx) => SearchFollowingScreen(),
          '/home/invite-friend-screen': (ctx) => InviteFriendScreen(),
          '/home/write-post-screen': (ctx) => WritePostScreen(),
          '/home/reply-section-screen': (ctx) => ReplySectionScreen(),
          '/home/write-reply-screen': (ctx) => WriteReplyScreen(),
          '/home/image-capture-screen': (ctx) => ImageCapture(),
          '/home/people-inside-room': (ctx) => PeopleInsideRoom(),
          '/home/share-room': (ctx) => ShareRoom(),
          '/home/post-image-picker': (ctx) => PostImagePicker(),
        },
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Widget screen =
        (_auth.currentUser == null) || !_auth.currentUser!.emailVerified
            ? LogIn()
            : Home();
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