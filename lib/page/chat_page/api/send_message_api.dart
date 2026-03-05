import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/chat_page/model/fetch_user_chat_model.dart';
import 'package:tingle/utils/utils.dart';

class SendMessageApi {
  /// POST /messages/chat - Send a text message. Returns sent chat and chatTopicId (for first message).
  static Future<({Chat? chat, String? chatTopicId})> sendText({
    required String token,
    String? chatTopicId,
    String? otherUserId,
    required String message,
    String? replyToId,
  }) async {
    if (chatTopicId == null && otherUserId == null) return (chat: null, chatTopicId: null);
    try {
      final body = <String, dynamic>{
        'message': message,
        'messageType': 1,
      };
      if (chatTopicId != null) body['chatTopicId'] = chatTopicId;
      if (otherUserId != null) body['otherUserId'] = otherUserId;
      if (replyToId != null && replyToId.isNotEmpty) body['replyToId'] = replyToId;

      final res = await ApiClient.instance.post('/messages/chat', body: body, token: token);
      final data = res['data'];
      final topicId = res['chatTopicId'] as String?;
      if (data == null || data is! Map<String, dynamic>) return (chat: null, chatTopicId: topicId);
      return (chat: Chat.fromJson(Map<String, dynamic>.from(data)), chatTopicId: topicId);
    } catch (e) {
      Utils.showLog('SendMessageApi sendText error: $e');
      return (chat: null, chatTopicId: null);
    }
  }

  /// POST /messages/chat - Send an image message (image URL). Returns sent chat and chatTopicId.
  static Future<({Chat? chat, String? chatTopicId})> sendImage({
    required String token,
    String? chatTopicId,
    String? otherUserId,
    required String imageUrl,
  }) async {
    if (chatTopicId == null && otherUserId == null) return (chat: null, chatTopicId: null);
    try {
      final body = <String, dynamic>{
        'image': imageUrl,
        'messageType': 2,
      };
      if (chatTopicId != null) body['chatTopicId'] = chatTopicId;
      if (otherUserId != null) body['otherUserId'] = otherUserId;

      final res = await ApiClient.instance.post('/messages/chat', body: body, token: token);
      final data = res['data'];
      final topicId = res['chatTopicId'] as String?;
      if (data == null || data is! Map<String, dynamic>) return (chat: null, chatTopicId: topicId);
      return (chat: Chat.fromJson(Map<String, dynamic>.from(data)), chatTopicId: topicId);
    } catch (e) {
      Utils.showLog('SendMessageApi sendImage error: $e');
      return (chat: null, chatTopicId: null);
    }
  }
}
