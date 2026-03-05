import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/recharge_coin_page/model/fetch_coin_plan_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchCoinPlanApi {
  static Future<FetchCoinPlanModel> callApi({
    required String token,
    required String uid,
  }) async {
    try {
      final res = await ApiClient.instance.get('/payments/coin-plans');
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final plans = <Data>[];
      for (var i = 0; i < list.length; i++) {
        final m = Map<String, dynamic>.from(list[i]);
        m['_id'] ??= m['id'];
        plans.add(Data.fromJson(m));
      }
      return FetchCoinPlanModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        data: plans,
      );
    } catch (e) {
      Utils.showLog("Fetch Coin Plan API Error: $e");
      return FetchCoinPlanModel(status: false, message: e.toString(), data: []);
    }
  }
}
