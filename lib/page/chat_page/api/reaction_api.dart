import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/utils.dart';

class ReactionApi {
  static const List<String> allowedEmojis = ['like', 'love', 'laugh', 'wow', 'sad', 'angry', 'heart', 'thumbsup'];

  /// POST /messages/:messageId/reaction - Add or set reaction.
  static Future<bool> addReaction({
    required String token,
    required String messageId,
    String emoji = 'like',
  }) async {
    if (messageId.isEmpty) return false;
    if (!allowedEmojis.contains(emoji)) emoji = 'like';
    try {
      final res = await ApiClient.instance.post(
        '/messages/$messageId/reaction',
        body: {'emoji': emoji},
        token: token,
      );
      return res['status'] == true;
    } catch (e) {
      Utils.showLog('ReactionApi addReaction error: $e');
      return false;
    }
  }

  /// PATCH /messages/:messageId/reaction - Remove reaction.
  static Future<bool> removeReaction({
    required String token,
    required String messageId,
  }) async {
    if (messageId.isEmpty) return false;
    try {
      final res = await ApiClient.instance.patch(
        '/messages/$messageId/reaction',
        body: {},
        token: token,
      );
      return res['status'] == true;
    } catch (e) {
      Utils.showLog('ReactionApi removeReaction error: $e');
      return false;
    }
  }
}
