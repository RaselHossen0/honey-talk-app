import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchVideoApi {
  static const int _defaultLimit = 20;

  static Future<FetchVideoModel?> callApi({int limit = _defaultLimit, int offset = 0}) async {
    try {
      final res = await ApiClient.instance.get('/videos', queryParameters: {
        'limit': limit.toString(),
        'offset': offset.toString(),
      });
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final videos = list.map((v) => VideoData.fromJson(Map<String, dynamic>.from(v))).toList();
      return FetchVideoModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        data: videos,
      );
    } catch (e) {
      Utils.showLog('FetchVideoApi error: $e');
      return null;
    }
  }
}
