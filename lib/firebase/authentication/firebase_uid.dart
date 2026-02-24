import 'package:firebase_auth/firebase_auth.dart';
import 'package:tingle/utils/utils.dart';

class FirebaseUid {
  static String? onGet() {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      Utils.showLog("Firebase Uid => ${user?.uid}");
      return user?.uid;
    } catch (e) {
      Utils.showLog("Firebase Uid Failed => $e");
      return null;
    }
  }
}
