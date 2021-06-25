import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  String? uid;
  User? user;
  String? email;
  bool isVerified = false;
  bool isAnon = false;
  String? profilePicURL;

  AppUser.fromFirebaseUser(User user) {
    this.user = user;
    this.uid = user.uid;
    this.email = user.email;
    this.isVerified = user.emailVerified;
    this.isAnon = user.isAnonymous;
    this.profilePicURL = user.photoURL;
  }
}