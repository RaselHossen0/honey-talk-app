import 'package:tingle/page/charming_level_page/model/fetch_charming_level_model.dart';

class FetchCharmingLevelApi {
  static Future<FetchCharmingLevelModel> callApi() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return FetchCharmingLevelModel(
      status: true,
      message: "Success",
      data: CharmingLevelData(
        currentLevel: 4,
        nextLevel: 5,
        currentBonus: 169336,
        bonusToNextLevel: 130664,
        totalBonusToCurrentLevel: 169336,
        rewardTiers: [
          LevelRewardTier(levelRange: "L1~5", count: 3),
          LevelRewardTier(levelRange: "L6~10", count: 8),
          LevelRewardTier(levelRange: "L11~15", count: 11),
        ],
        levelRules: [
          LevelRule(level: 0, earnBonus: 0),
          LevelRule(level: 1, earnBonus: 10000),
          LevelRule(level: 2, earnBonus: 30000),
          LevelRule(level: 3, earnBonus: 60000),
          LevelRule(level: 4, earnBonus: 150000),
          LevelRule(level: 5, earnBonus: 300000),
        ],
      ),
    );
  }
}
