import 'package:tingle/database/new_fake_datas/purchased_theme_fake_data.dart';
import 'package:tingle/page/backpack_page/model/fetch_purchased_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchPurchasedFrameApi {
  static Future<FetchPurchasedFrameModel?> callApi({required String token, required String uid}) async {
    try {
      Utils.showLog("Get PurchaseFrame Api Response => ${fetchPurchasedFrameData().toJson()}");

      return FetchPurchasedFrameModel.fromJson(fetchPurchasedFrameData().toJson());
    } catch (error) {
      Utils.showLog("Get PurchaseFrame Api Error => $error");
    }
    return null;
  }
}
