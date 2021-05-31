import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";

import "signup.dart";
import "reset_password.dart";
import "home.dart";

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final formKey = new GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  String? email, password;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser =
        await GoogleSignIn().signIn() as GoogleSignInAccount;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  bool checkFields() {
    final form = formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        form.save();
        return true;
      }
    }
    return false;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter a Valid Email';
    else
      return null;
  }

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
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(25.0, 175.0, 0.0, 0.0),
                  child: Text(
                    "Up",
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(150.0, 175.0, 0.0, 0.0),
                  child: Text(
                    "!",
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
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
                        validator: (value) => value == ""
                            ? "Email is required"
                            : validateEmail(value as String),
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: new InputDecoration(
                          labelText: "Email",
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (value) =>
                            value == "" ? "Password is required" : null,
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: true,
                        decoration: new InputDecoration(
                          labelText: "Password",
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
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
                      style: TextStyle(
                        color: Colors.purple,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
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
            child: GestureDetector(
              onTap: () async {
                if (!checkFields()) return;
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
              child: Material(
                color: Colors.purple.shade200,
                borderRadius: BorderRadius.circular(25.0),
                shadowColor: Colors.transparent,
                elevation: 7.0,
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
          ),
          Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () async {
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
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple.shade200,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(25)),
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
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: "Montserrat",
                      color: Colors.purple,
                    ),
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
