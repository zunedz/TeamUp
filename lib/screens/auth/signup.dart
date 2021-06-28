import 'package:cool_alert/cool_alert.dart';
import "package:flutter/material.dart";
import 'package:loading_indicator/loading_indicator.dart';
import 'package:orbital_login/services/firebaseAuth.dart';
import 'package:orbital_login/styles/styles_login.dart';

import '../../helpers/validator.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = new GlobalKey<FormState>();
  final AuthMethods authMethods = AuthMethods();
  bool isLoading = false;
  String? username, email, password, passwordConfirm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(100.0),
              child: LoadingIndicator(
                indicatorType: Indicator.lineScale,
                color: Colors.purple.shade300,
              ),
            ))
          : ListView(
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
                          onChanged: (value) {
                            username = value.trim();
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
                      if (!checkFields(formKey)) return;
                      setState(() {
                        isLoading = true;
                      });
                      String? message =
                          await authMethods.signUpWithEmailAndPassword(
                              username!, email!, password!);
                      setState(() {
                        isLoading = false;
                      });
                      if (message != null) {
                        await CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          text: message,
                          title: "Failed to LogIn",
                          autoCloseDuration: Duration(seconds: 3),
                        );
                        return;
                      }
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
                          Navigator.of(context)
                              .pushReplacementNamed('/auth/login');
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
