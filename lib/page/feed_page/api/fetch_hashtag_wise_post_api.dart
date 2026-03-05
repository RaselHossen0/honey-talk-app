import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchHashtagWisePostApi {
  static Future<FetchPostModel?> callApi({
    required String hashTagId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final res = await ApiClient.instance.get('/posts/hashtag/$hashTagId', queryParameters: {
        'limit': limit.toString(),
        'offset': offset.toString(),
      });
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final posts = list.map((p) => Post.fromJson(Map<String, dynamic>.from(p))).toList();
      return FetchPostModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        post: posts,
      );
    } catch (e) {
      Utils.showLog('FetchHashtagWisePostApi error: $e');
      return null;
    }
  }
}
