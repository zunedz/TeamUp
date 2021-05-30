import "package:flutter/material.dart";

import "login.dart";

class ResetPassword extends StatelessWidget {
  final formKey = new GlobalKey<FormState>();

  String? email, password;

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
      return 'Enter Valid Email';
    else
      return null;
  }

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
              Form(
                key: formKey,
                child: TextFormField(
                  validator: (value) => value == ""
                      ? "Email is required"
                      : validateEmail(value as String),
                  onSaved: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    labelText: "EMAIL",
                    labelStyle: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
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
                    if (!checkFields())
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
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
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
        ),
      ),
    );
  }
}
