import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:orbital_login/models/user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();

  AppUser? get user => this.state.props[0];

  // AppUser get currentUser => AppUser.fromFirebaseUser(_firebaseAuth.currentUser!);

  bool get isLoggedIn => this.user != null;

  void logInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleAuth.signIn() as GoogleSignInAccount;
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      this.emit(AuthenticationLogged.fromFirebaseUser(user));
    } catch(e) {
      print(e);
    }
  }

  void logOut() async {
    try {
      _firebaseAuth.signOut();
      _googleAuth.signOut();
      this.emit(AuthenticationInitial());
    } catch (e) {
      print(e);
    }
  }
}
