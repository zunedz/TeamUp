import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUserFunction {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String getUserId() {
    return _auth.currentUser!.uid;
  }

  Future<String> getUserUsername() async {
    var temp = await FirebaseFirestore.instance
        .collection('appUser')
        .where('userId', isEqualTo: this.getUserId())
        .get();
    return temp.docs[0].data()['username'];
  }
}
