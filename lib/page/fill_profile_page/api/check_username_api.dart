import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/login_page/model/check_user_name_model.dart';
import 'package:tingle/utils/utils.dart';

/// GET /users/username/check?username=xxx - Check if username is available.
class CheckUsernameApi {
  static Future<CheckUserNameModel?> callApi({
    required String token,
    required String username,
  }) async {
    if (username.trim().length < 2) {
      return CheckUserNameModel(status: true, available: false, message: 'Username must be at least 2 characters');
    }
    try {
      final res = await ApiClient.instance.get(
        '/users/username/check',
        queryParameters: {'username': username.trim()},
        token: token,
      );
      return CheckUserNameModel(
        status: res['status'] as bool? ?? true,
        available: res['available'] as bool? ?? false,
        message: res['message'] as String?,
      );
    } catch (e) {
      Utils.showLog("Check Username API Error: $e");
      return null;
    }
  }
}
