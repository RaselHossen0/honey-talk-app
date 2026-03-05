import 'package:tingle/common/model/fetch_category_wise_gift_model.dart';
import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/utils.dart';

class FetchCategoryWiseGiftApi {
  static Map<String, List<CategoryWiseGift?>> categoryWiseGift = {};

  static Future<FetchCategoryWiseGiftModel?> callApi({
    required String token,
    required String uid,
    required String giftCategoryId,
  }) async {
    Utils.showLog("Fetch Category Wise Gift API Called...");
    try {
      final res = await ApiClient.instance.get('/gifts/category/$giftCategoryId');
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final items = <CategoryWiseGift>[];
      for (var i = 0; i < list.length; i++) {
        final m = Map<String, dynamic>.from(list[i]);
        if (m['_id'] == null && m['id'] != null) m['_id'] = m['id'];
        items.add(CategoryWiseGift.fromJson(m));
      }
      categoryWiseGift[giftCategoryId] = items;
      return FetchCategoryWiseGiftModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        data: items,
      );
    } catch (e) {
      Utils.showLog("Fetch Category Wise Gift API Error: $e");
      categoryWiseGift[giftCategoryId] = [];
      return FetchCategoryWiseGiftModel(status: false, message: e.toString(), data: []);
    }
  }
}
