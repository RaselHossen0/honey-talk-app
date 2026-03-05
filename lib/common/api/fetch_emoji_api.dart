import 'package:tingle/common/model/fetch_emoji_model.dart';
import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/utils.dart';

class FetchEmojiApi {
  static Future<FetchEmojiModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Fetch Emoji API Called...");
    try {
      final res = await ApiClient.instance.get('/emoji');
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final items = list.map((m) {
        final x = Map<String, dynamic>.from(m);
        x['_id'] ??= x['id'];
        x['title'] ??= x['emoji'];
        return EmojiData.fromJson(x);
      }).toList();
      return FetchEmojiModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        data: items,
      );
    } catch (e) {
      Utils.showLog("Fetch Emoji API Error: $e");
      return null;
    }
  }
}
