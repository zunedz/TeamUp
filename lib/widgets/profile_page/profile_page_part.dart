import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:orbital_login/services/firebaseAuth.dart';
import 'package:orbital_login/widgets/loadingScreen.dart';

class ProfilePagePart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('appUser')
          .where("userId", isEqualTo: userId)
          .get(),
      builder: (ctx,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> userSnapShot) {
        if (userSnapShot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        }
        var appUser = userSnapShot.data!.docs[0].data();
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Material(
                  elevation: 4.0,
                  shape: CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: Ink.image(
                    image: NetworkImage(appUser["avatarUrl"]),
                    fit: BoxFit.cover,
                    width: 200.0,
                    height: 200.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/home/image-capture-screen');
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: TextStyle(color: Colors.purple),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      appUser["username"],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(color: Colors.purple),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      appUser["email"],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Joined since",
                      style: TextStyle(color: Colors.purple),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat('dd-MM-yyyy').format(DateTime.parse(
                          appUser["createdAt"].toDate().toString())),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        CoolAlert.show(
                          context: ctx,
                          type: CoolAlertType.confirm,
                          cancelBtnText: "Cancel",
                          onCancelBtnTap: () => Navigator.of(context).pop(),
                          confirmBtnText: "Log Out",
                          onConfirmBtnTap: () => AuthMethods().signOut(context),
                        );
                      },
                      child: Text(
                        "Sign Out",
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
