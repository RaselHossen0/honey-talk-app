import 'package:tingle/common/model/fetch_gift_gallery_model.dart';
import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/utils.dart';

class FetchGiftGalleryApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchGiftGalleryModel?> callApi({
    required String uid,
    required String token,
    required String userId,
  }) async {
    Utils.showLog("Fetch Gift Gallery API Calling...");
    try {
      final res = await ApiClient.instance.get(
        '/gifts/gallery/$userId',
        queryParameters: {'limit': limitPagination.toString(), 'offset': startPagination.toString()},
      );
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final items = list.map((m) {
        final x = Map<String, dynamic>.from(m);
        x['_id'] = x['giftId'];
        return Data.fromJson(x);
      }).toList();
      return FetchGiftGalleryModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        data: items,
      );
    } catch (e) {
      Utils.showLog("Fetch Gift Gallery API Error: $e");
      return null;
    }
  }
}
