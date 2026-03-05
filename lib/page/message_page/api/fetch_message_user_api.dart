import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/message_page/model/fetch_message_user_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchMessageUserApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  /// Fetches message list from GET /messages/conversations.
  /// type: all, online, unread. Supports pagination via startPagination.
  static Future<FetchMessageUserModel> callApi({
    required String uid,
    required String token,
    required String type,
  }) async {
    try {
      startPagination += 1;
      final page = startPagination;
      final res = await ApiClient.instance.get(
        '/messages/conversations',
        queryParameters: {
          'type': type,
          'page': page.toString(),
          'limit': limitPagination.toString(),
        },
        token: token,
      );

      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final data = list.map((e) => MessageData.fromJson(Map<String, dynamic>.from(e))).toList();

      return FetchMessageUserModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        data: data,
      );
    } catch (e) {
      Utils.showLog('FetchMessageUserApi error: $e');
      return FetchMessageUserModel(
        status: false,
        message: e.toString(),
        data: [],
      );
    }
  }
}
