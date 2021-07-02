import 'package:cool_alert/cool_alert.dart';
import "package:flutter/material.dart";
import 'package:loading_indicator/loading_indicator.dart';
import 'package:orbital_login/services/firebaseAuth.dart';
import 'package:orbital_login/styles/styles_login.dart';

import '../../helpers/validator.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = new GlobalKey<FormState>();
  AuthMethods authMethods = AuthMethods();
  bool isLoading = false;
  String? email, password;

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
          : Container(
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
                        onChanged: (value) {
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
                      child: MaterialButton(
                        onPressed: () async {
                          if (!checkFields(formKey)) {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              await authMethods.resetPass(email!);
                              setState(() {
                                isLoading = false;
                              });
                              await CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: "An email has been sent",
                                title: "Failed to LogIn",
                              );
                              return;
                            } catch (e) {
                              print(e);
                            }
                          }
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
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/auth/login');
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
