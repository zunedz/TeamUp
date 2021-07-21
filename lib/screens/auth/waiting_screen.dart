import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  final auth = FirebaseAuth.instance;
  Timer? timer;

  @override
  void initState() {
    User user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      await checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Please verify your email"),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    User user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer!.cancel();
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}
