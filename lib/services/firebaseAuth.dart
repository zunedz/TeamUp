import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(FirebaseAuth.instance.currentUser!.emailVerified);
      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        FirebaseAuth.instance.signOut();
        return "Please verify your email";
      }
      print(userCredential.user!.uid);
      return null;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      } else {
        return "Too many request, try again later";
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> signUpWithEmailAndPassword(
      String username, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('appUser')
          .doc('${userCredential.user!.uid}')
          .set({
        'createdAt': Timestamp.now(),
        'email': email,
        'isInsideRoom': false,
        'roomId': "",
        "userId": userCredential.user!.uid,
        'username': username,
        'avatarUrl':
            "https://miro.medium.com/max/720/1*W35QUSvGpcLuxPo3SRTH4w.png",
        "followerIdArray": [],
        "followingIdArray": [],
      });
      print(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> resetPass(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      // await GoogleSignIn().disconnect();
      await GoogleSignIn().signOut();

      Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (route) => false,
      );
      // Navigator.of(context).pushReplacementNamed('/');
      final snackBar = SnackBar(
        content: Text('Logged out'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e);
    }
  }
}
