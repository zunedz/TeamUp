import "package:flutter/material.dart";
import 'package:orbital_login/styles/styles_login.dart';

import 'login.dart';
import '../helpers/validator.dart';

class ResetPassword extends StatelessWidget {
  final formKey = new GlobalKey<FormState>();

  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  "Your Email: ",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.purple,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                key: formKey,
                child: TextFormField(
                  validator: emailValidator,
                  onSaved: (value) {
                    email = value;
                  },
                  decoration: inputDecoration("Email"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: GestureDetector(
                  onTap: () {
                    if (!checkFields(formKey))
                      return; //send reset password email, to be implemented later
                  },
                  child: Material(
                    color: Colors.purple.shade200,
                    borderRadius: BorderRadius.circular(25.0),
                    elevation: 7.0,
                    child: Center(
                      child: Text(
                        "RESET PASSWORD",
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
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        "Back to LogIn page",
                        style: hyperlinkStyle,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}