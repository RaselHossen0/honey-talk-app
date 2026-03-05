import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/wealth_level_page/model/fetch_wealth_level_model.dart';
import 'package:tingle/utils/utils.dart';

class FetchWealthLevelApi {
  static Future<FetchWealthLevelModel> callApi() async {
    try {
      final res = await ApiClient.instance.get('/wealth-levels');
      final list = (res['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final levelRules = <WealthLevelRule>[];
      for (var i = 0; i < list.length; i++) {
        final m = list[i];
        levelRules.add(WealthLevelRule(
          level: (m['level'] as num?)?.toInt() ?? i,
          rechargeToken: (m['requiredIntegralValue'] as num?)?.toInt() ?? 0,
        ));
      }
      return FetchWealthLevelModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Success',
        data: WealthLevelData(
          currentLevel: 0,
          nextLevel: 1,
          currentToken: 0,
          tokenToNextLevel: levelRules.isNotEmpty ? (levelRules[0].rechargeToken ?? 0) : 0,
          totalTokenToCurrentLevel: 0,
          rewardTiers: null,
          levelRules: levelRules.isEmpty ? null : levelRules,
        ),
      );
    } catch (e) {
      Utils.showLog("Fetch Wealth Level API Error: $e");
      return FetchWealthLevelModel(
        status: false,
        message: e.toString(),
        data: WealthLevelData(
          currentLevel: 0,
          nextLevel: 1,
          currentToken: 0,
          tokenToNextLevel: 0,
          totalTokenToCurrentLevel: 0,
          rewardTiers: null,
          levelRules: null,
        ),
      );
    }
  }
}
