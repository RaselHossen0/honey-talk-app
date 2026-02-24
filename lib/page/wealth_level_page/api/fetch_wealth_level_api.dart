import 'package:tingle/page/wealth_level_page/model/fetch_wealth_level_model.dart';

class FetchWealthLevelApi {
  static Future<FetchWealthLevelModel> callApi() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return FetchWealthLevelModel(
      status: true,
      message: "Success",
      data: WealthLevelData(
        currentLevel: 5,
        nextLevel: 6,
        currentToken: 514338,
        tokenToNextLevel: 85662,
        totalTokenToCurrentLevel: 514338,
        rewardTiers: [
          WealthRewardTier(levelRange: "L1~5", count: 3),
          WealthRewardTier(levelRange: "L6~10", count: 8),
          WealthRewardTier(levelRange: "L11~15", count: 11),
        ],
        levelRules: [
          WealthLevelRule(level: 0, rechargeToken: 0),
          WealthLevelRule(level: 1, rechargeToken: 10000),
          WealthLevelRule(level: 2, rechargeToken: 30000),
          WealthLevelRule(level: 3, rechargeToken: 60000),
          WealthLevelRule(level: 4, rechargeToken: 150000),
          WealthLevelRule(level: 5, rechargeToken: 300000),
        ],
      ),
    );
  }
}
