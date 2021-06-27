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
  String _log = "";

  // AppUser? get user => this.state is AuthenticationLogged ? this.state.user : null;

  AppUser get currentUser => AppUser.fromFirebaseUser(_firebaseAuth.currentUser!);

  bool get isSignedIn => this.currentUser != null; // remember to change to AppUser

  String get log => this._log;

  void signUpWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      this.emit(AuthenticationLogged.fromFirebaseUser(user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        this._log = ('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void signInWithGoogle() async {
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

  void signInWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      this.emit(AuthenticationLogged.fromFirebaseUser(user));
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        this._log = ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        this._log = ('Wrong password provided for that user.');
      } else {
        this._log = "Too many request, try again later";
      }
    } catch (e) {
      print(e);
    }
  }

  void signOut() async {
    try {
      _firebaseAuth.signOut();
      _googleAuth.signOut();
      this.emit(AuthenticationInitial());
    } catch (e) {
      print(e);
    }
  }

  @override
  void onChange(Change<AuthenticationState> change) {
    print(change);
    super.onChange(change);
  }

  void resetPass(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }
}

Change change = Change(currentState: AuthenticationInitial, nextState: AuthenticationLogged);