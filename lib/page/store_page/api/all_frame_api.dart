import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/store_page/model/all_store_item_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchAllFramesApi {
  static Future<AllStoreItemModel> callApi() async {
    try {
      final res = await ApiClient.instance.get('/store/items');
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final avatarFrames = <AvatarFrame>[];
      final themes = <AvatarFrame>[];
      final rides = <AvatarFrame>[];
      for (var i = 0; i < list.length; i++) {
        final m = list[i];
        final x = Map<String, dynamic>.from(m);
        x['_id'] ??= x['id'];
        x['isPurchased'] = false;
        final item = AvatarFrame.fromJson(x);
        final itemType = (m['itemType'] as String?)?.toUpperCase();
        if (itemType == 'FRAME' || m['type'] == 0) {
          avatarFrames.add(item);
        } else if (itemType == 'THEME' || m['type'] == 1) {
          themes.add(item);
        } else if (itemType == 'RIDE' || m['type'] == 2) {
          rides.add(item);
        }
      }
      return AllStoreItemModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        data: Data(
          avatarFrames: avatarFrames.isEmpty ? null : avatarFrames,
          themes: themes.isEmpty ? null : themes,
          rides: rides.isEmpty ? null : rides,
        ),
      );
    } catch (e) {
      Utils.showLog("Fetch Store Items API Error: $e");
      return AllStoreItemModel(
        status: false,
        message: e.toString(),
        data: Data(avatarFrames: [], themes: [], rides: []),
      );
    }
  }
}
