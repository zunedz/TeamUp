import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  print("1");
  final GoogleSignInAccount googleUser =
      await GoogleSignIn().signIn() as GoogleSignInAccount;
  print("2");
  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  print("3");
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  print("4");
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
