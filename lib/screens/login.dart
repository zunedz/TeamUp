import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";

import 'signup.dart';
import 'reset_password.dart';
import 'home.dart';
import '../helpers/validator.dart';
import '../services/googleAuth.dart';
import '../styles/styles_login.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final formKey = new GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    "Team",
                    style: titleStyle,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(25.0, 175.0, 0.0, 0.0),
                  child: Text(
                    "Up",
                    style: titleStyle,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(150.0, 175.0, 0.0, 0.0),
                  child: Text(
                    "!",
                    style: signStyle,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: emailValidator,
                        onChanged: (value) {
                          email = value.trim();
                        },
                        decoration: inputDecoration("Email"),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: passwordValidator,
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: true,
                        decoration: inputDecoration("Password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment(1, 0),
                  child: InkWell(
                    onTap: () {
                      print("tapped");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ResetPassword();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password",
                      style: hyperlinkStyle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
          SizedBox(height: 0.0),
          Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: MaterialButton(
              onPressed: () async {
                if (!checkFields(formKey)) return;
                try {
                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email as String,
                    password: password as String,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                    return;
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                    return;
                  }
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Home();
                    },
                  ),
                );
              },
              elevation: 0,
              height: 50,
              color: Colors.purple.shade200,
              minWidth: 10000,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Center(
                child: Text(
                  "LOGIN",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            color: Colors.transparent,
            child: MaterialButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await signInWithGoogle();
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                    return;
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                    return;
                  }
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Home();
                    },
                  ),
                );
              },
              elevation: 0,
              height: 50,
              color: Colors.white,
              minWidth: 10000,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                side: BorderSide(color: Colors.purple.shade200, width: 1),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset("assets/images/google.png"),
                    ),
                    SizedBox(width: 15),
                    Center(
                      child: Text(
                        "LOG IN WITH GOOGLE",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.purple.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account yet?",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                  ),
                ),
                SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUp();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: hyperlinkStyle,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
