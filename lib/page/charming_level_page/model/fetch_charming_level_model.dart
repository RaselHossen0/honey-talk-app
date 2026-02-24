class FetchCharmingLevelModel {
  bool? status;
  String? message;
  CharmingLevelData? data;

  FetchCharmingLevelModel({this.status, this.message, this.data});

  FetchCharmingLevelModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CharmingLevelData.fromJson(json['data']) : null;
  }
}

class CharmingLevelData {
  int? currentLevel;
  int? nextLevel;
  int? currentBonus;
  int? bonusToNextLevel;
  int? totalBonusToCurrentLevel;
  List<LevelRewardTier>? rewardTiers;
  List<LevelRule>? levelRules;

  CharmingLevelData({
    this.currentLevel,
    this.nextLevel,
    this.currentBonus,
    this.bonusToNextLevel,
    this.totalBonusToCurrentLevel,
    this.rewardTiers,
    this.levelRules,
  });

  CharmingLevelData.fromJson(Map<String, dynamic> json) {
    currentLevel = json['currentLevel'];
    nextLevel = json['nextLevel'];
    currentBonus = json['currentBonus'];
    bonusToNextLevel = json['bonusToNextLevel'];
    totalBonusToCurrentLevel = json['totalBonusToCurrentLevel'];
    if (json['rewardTiers'] != null) {
      rewardTiers = (json['rewardTiers'] as List).map((v) => LevelRewardTier.fromJson(v)).toList();
    }
    if (json['levelRules'] != null) {
      levelRules = (json['levelRules'] as List).map((v) => LevelRule.fromJson(v)).toList();
    }
  }
}

class LevelRewardTier {
  String? levelRange;
  int? count;

  LevelRewardTier({this.levelRange, this.count});

  LevelRewardTier.fromJson(Map<String, dynamic> json) {
    levelRange = json['levelRange'];
    count = json['count'];
  }
}

class LevelRule {
  int? level;
  int? earnBonus;

  LevelRule({this.level, this.earnBonus});

  LevelRule.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    earnBonus = json['earnBonus'];
  }
}
