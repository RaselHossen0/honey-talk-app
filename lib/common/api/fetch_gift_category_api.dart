import 'package:tingle/common/model/fetch_gift_category_model.dart';
import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class FetchGiftCategoryApi {
  static List<GiftData> giftCategory = [];

  /// Called on app init to preload gift categories (e.g. from bottom bar).
  static Future<void> onGetGiftCategory() async {
    final token = Database.accessToken;
    final uid = Database.fetchLoginUserProfile()?.user?.id ?? '';
    await callApi(token: token, uid: uid);
  }

  static Future<FetchGiftCategoryModel?> callApi({
    required String token,
    required String uid,
  }) async {
    Utils.showLog("Fetch Gift Category API Called...");
    try {
      final res = await ApiClient.instance.get('/gifts/categories');
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      for (var i = 0; i < list.length; i++) {
        final m = Map<String, dynamic>.from(list[i]);
        if (m['_id'] == null && m['id'] != null) m['_id'] = m['id'];
        list[i] = m;
      }
      giftCategory = list.map((e) => GiftData.fromJson(e)).toList();
      return FetchGiftCategoryModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        data: giftCategory,
      );
    } catch (e) {
      Utils.showLog("Fetch Gift Category API Error: $e");
      return FetchGiftCategoryModel(status: false, message: e.toString(), data: []);
    }
  }
}
