import 'package:tingle/common/model/fetch_user_coin_model.dart';
import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/utils/utils.dart';

class FetchUserCoinApi {
  static Future<FetchUserCoinModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Fetch User Coin API Calling...");
    try {
      final res = await ApiClient.instance.get('/wallets/balance');
      final coin = (res['coin'] as num?)?.toInt() ?? (res['coinBalance'] as num?)?.toInt() ?? 0;
      return FetchUserCoinModel(
        status: true,
        message: 'Success',
        coinBalance: coin,
      );
    } catch (e) {
      Utils.showLog("Fetch User Coin API Error: $e");
      return FetchUserCoinModel(status: false, message: e.toString(), coinBalance: 0);
    }
  }
}
