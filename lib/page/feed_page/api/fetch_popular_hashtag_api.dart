import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/feed_page/model/fetch_popular_hashtag_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchPopularHashtagApi {
  static Future<FetchPopularHashtagModel?> callApi({int limit = 20}) async {
    try {
      final res = await ApiClient.instance.get('/hashtags/popular', queryParameters: {'limit': limit.toString()});
      final list = (res['hashtags'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final hashtags = list.map((h) => Hashtags.fromJson(Map<String, dynamic>.from(h))).toList();
      return FetchPopularHashtagModel(
        success: res['success'] as bool? ?? res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        hashtags: hashtags,
      );
    } catch (e) {
      Utils.showLog('FetchPopularHashtagApi error: $e');
      return null;
    }
  }
}
