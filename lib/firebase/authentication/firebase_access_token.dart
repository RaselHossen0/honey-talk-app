import 'package:firebase_auth/firebase_auth.dart';
import 'package:tingle/utils/utils.dart';

class FirebaseAccessToken {
  static Future<String?> onGet() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      bool? isExpired = await user?.getIdTokenResult().then((tokenResult) {
        DateTime expiryTime = tokenResult.expirationTime!;
        Utils.showLog("Firebase Token Expire Time => $expiryTime");
        return expiryTime.isBefore(DateTime.now());
      });
      Utils.showLog("Firebase Token Is Expire => $isExpired");
      final token = isExpired == true ? await user?.getIdToken(true) : await user?.getIdToken();
      return token;
    } catch (e) {
      Utils.showLog("Firebase Access Token Failed => $e");
      return null;
    }
  }
}
