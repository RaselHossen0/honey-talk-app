import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/utils.dart';

/// GET /users/username/suggest - Get a suggested unique username.
class SuggestUsernameApi {
  static Future<String?> callApi({required String token}) async {
    try {
      final res = await ApiClient.instance.get('/users/username/suggest', token: token);
      return res['username'] as String?;
    } catch (e) {
      Utils.showLog("Suggest Username API Error: $e");
      return null;
    }
  }
}
