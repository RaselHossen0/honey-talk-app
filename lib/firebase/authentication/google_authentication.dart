import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tingle/utils/utils.dart';

class GoogleAuthentication {
  static bool _googleSignInInitialized = false;

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      if (!_googleSignInInitialized) {
        await GoogleSignIn.instance.initialize();
        _googleSignInInitialized = true;
      }
      await GoogleSignIn.instance.signOut();
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
      final result = await FirebaseAuth.instance.signInWithCredential(credential);

      Utils.showLog("Google Authentication Response => $result");

      Utils.showLog("Google Authentication Name => ${result.user?.displayName}");
      Utils.showLog("Google Authentication Email => ${result.user?.email}");
      Utils.showLog("Google Authentication Image => ${result.user?.photoURL}");
      Utils.showLog("Google Authentication isNewUser => ${result.additionalUserInfo?.isNewUser}");

      return result;
    } catch (error) {
      Utils.showLog("Google Authentication Error => $error");
    }
    return null;
  }
}
