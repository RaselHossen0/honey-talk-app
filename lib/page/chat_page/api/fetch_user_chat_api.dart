import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/chat_page/model/fetch_user_chat_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchUserChatApi {
  static const int defaultLimit = 20;

  /// GET /messages/chat - Get or create topic and list messages.
  /// Pass [chatTopicId] for existing room, or [otherUserId] to get/create DM.
  static Future<FetchUserChatModel?> callApi({
    required String token,
    String? chatTopicId,
    String? otherUserId,
    int limit = defaultLimit,
    int offset = 0,
    String? before,
  }) async {
    if (chatTopicId == null && otherUserId == null) {
      Utils.showLog('FetchUserChatApi: provide chatTopicId or otherUserId');
      return null;
    }
    try {
      final query = <String, String>{
        'limit': limit.toString(),
        'offset': offset.toString(),
      };
      if (chatTopicId != null) query['chatTopicId'] = chatTopicId;
      if (otherUserId != null) query['otherUserId'] = otherUserId;
      if (before != null && before.isNotEmpty) query['before'] = before;

      final res = await ApiClient.instance.get(
        '/messages/chat',
        queryParameters: query,
        token: token,
      );

      final chatList = (res['chat'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final chat = chatList.map((e) => Chat.fromJson(Map<String, dynamic>.from(e))).toList();

      final otherUser = res['otherUser'] != null
          ? OtherUserInfo.fromJson(res['otherUser'])
          : null;
      return FetchUserChatModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        chatTopic: res['chatTopic'] as String? ?? '',
        chat: chat,
        otherUser: otherUser,
      );
    } catch (e) {
      Utils.showLog('FetchUserChatApi error: $e');
      return null;
    }
  }
}
