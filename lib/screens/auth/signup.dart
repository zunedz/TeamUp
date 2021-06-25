import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

import 'package:orbital_login/screens/auth/login.dart';
import 'package:orbital_login/styles/styles_login.dart';
import '../home/home.dart';
import '../../helpers/validator.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = new GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  String? username, email, password, passwordConfirm;

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
                style: signStyle,
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
                    validator: usernameValidator,
                    onSaved: (value) {
                      username = value!.trim();
                    },
                    decoration: inputDecoration("Username"),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
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
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (value) =>
                        confirmPassword(password, passwordConfirm),
                    onChanged: (value) {
                      passwordConfirm = value;
                    },
                    obscureText: true,
                    decoration: inputDecoration("Confirm Password"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
          Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: MaterialButton(
              onPressed: () async {
                if (!checkFields(formKey)) return; //implement auth here
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
                Navigator.of(context).pushReplacementNamed('/home');
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
                    Navigator.of(context).pushReplacementNamed('/auth/login');
                  },
                  child: Text(
                    "Log In",
                    style: hyperlinkStyle,
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
