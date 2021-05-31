import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

import 'package:orbital_login/login.dart';
import "home.dart";

class SignUp extends StatelessWidget {
  final formKey = new GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  String? username, email, password, passwordConfirm;

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

  String? validatePassword(String value) {
    if (value.length < 8) {
      return "Password must be at least 8 characters length";
    } else
      return null;
  }

  String? confirmPassword() {
    if (password != null && passwordConfirm != null) {
      if (password != passwordConfirm) {
        return "Password does not match";
      }
      return null;
    } else
      return "Password is required";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(15.0, 0, 15, 0),
        children: [
          SizedBox(height: 50),
          Container(
            height: 150,
            child: Center(
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.purple.shade200,
                  fontSize: 80,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Form(
            key: formKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == "") {
                        return "Username is required";
                      } else
                        return null;
                    },
                    onSaved: (value) {
                      username = value;
                    },
                    decoration: new InputDecoration(
                      labelText: "Username",
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
                    validator: (value) => value == ""
                        ? "Password is required"
                        : validatePassword(value as String),
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
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (value) => value == ""
                        ? "Password is required"
                        : confirmPassword(),
                    onChanged: (value) {
                      passwordConfirm = value;
                    },
                    obscureText: true,
                    decoration: new InputDecoration(
                      labelText: "Confirm Password",
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
          ),
          SizedBox(height: 50),
          Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: GestureDetector(
              onTap: () async {
                if (!checkFields()) return; //implement auth here
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email as String,
                    password: password as String,
                  );
                  User? user = FirebaseAuth.instance.currentUser;
                  if (!user!.emailVerified) user.sendEmailVerification();

                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                    return;
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                    return;
                  }
                } catch (e) {
                  print(e);
                  return;
                }
                print(username);
                print(email);
                print(password);
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
                elevation: 7.0,
                child: Center(
                  child: Text(
                    "SIGN UP",
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
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
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
                          return LogIn();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: "Montserrat",
                      color: Colors.purple,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
