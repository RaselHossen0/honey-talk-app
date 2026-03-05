import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/message_page/model/fetch_live_female_model.dart';
import 'package:tingle/utils/utils.dart';

/// Fetches users currently live. Uses GET /live.
class FetchLiveFemaleApi {
  static Future<FetchLiveFemaleModel> callApi({
    required String uid,
    required String token,
  }) async {
    try {
      final res = await ApiClient.instance.get('/live');
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final items = list;
      final data = items.map((m) {
        final user = m['user'] as Map<String, dynamic>?;
        return LiveFemaleData(
          id: m['id'] as String?,
          userId: m['userId'] as String? ?? user?['id'],
          name: user?['name'] as String?,
          image: user?['image'] as String?,
          isProfilePicBanned: user?['isProfilePicBanned'] as bool?,
        );
      }).toList();
      return FetchLiveFemaleModel(
        status: true,
        message: 'Success',
        data: data,
      );
    } catch (e) {
      Utils.showLog("Fetch Live Female API Error: $e");
      return FetchLiveFemaleModel(status: false, message: e.toString(), data: []);
    }
  }
}
