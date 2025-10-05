import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign-In
  signInWithGoogle() async {
    // bring interavtion with Google Sign-In API
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // finally sign in user with credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
