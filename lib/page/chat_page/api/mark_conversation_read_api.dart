import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/utils.dart';

class MarkConversationReadApi {
  /// PATCH /messages/conversations/:chatTopicId/read - Mark messages in topic as read.
  static Future<bool> callApi({required String token, required String chatTopicId}) async {
    if (chatTopicId.isEmpty) return false;
    try {
      final res = await ApiClient.instance.patch(
        '/messages/conversations/$chatTopicId/read',
        body: null,
        token: token,
      );
      return res['status'] == true;
    } catch (e) {
      Utils.showLog('MarkConversationReadApi error: $e');
      return false;
    }
  }
}
