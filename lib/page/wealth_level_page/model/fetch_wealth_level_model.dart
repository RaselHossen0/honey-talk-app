class FetchWealthLevelModel {
  bool? status;
  String? message;
  WealthLevelData? data;

  FetchWealthLevelModel({this.status, this.message, this.data});

  FetchWealthLevelModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? WealthLevelData.fromJson(json['data']) : null;
  }
}

class WealthLevelData {
  int? currentLevel;
  int? nextLevel;
  int? currentToken;
  int? tokenToNextLevel;
  int? totalTokenToCurrentLevel;
  List<WealthRewardTier>? rewardTiers;
  List<WealthLevelRule>? levelRules;

  WealthLevelData({
    this.currentLevel,
    this.nextLevel,
    this.currentToken,
    this.tokenToNextLevel,
    this.totalTokenToCurrentLevel,
    this.rewardTiers,
    this.levelRules,
  });

  WealthLevelData.fromJson(Map<String, dynamic> json) {
    currentLevel = json['currentLevel'];
    nextLevel = json['nextLevel'];
    currentToken = json['currentToken'];
    tokenToNextLevel = json['tokenToNextLevel'];
    totalTokenToCurrentLevel = json['totalTokenToCurrentLevel'];
    if (json['rewardTiers'] != null) {
      rewardTiers = (json['rewardTiers'] as List).map((v) => WealthRewardTier.fromJson(v)).toList();
    }
    if (json['levelRules'] != null) {
      levelRules = (json['levelRules'] as List).map((v) => WealthLevelRule.fromJson(v)).toList();
    }
  }
}

class WealthRewardTier {
  String? levelRange;
  int? count;

  WealthRewardTier({this.levelRange, this.count});

  WealthRewardTier.fromJson(Map<String, dynamic> json) {
    levelRange = json['levelRange'];
    count = json['count'];
  }
}

class WealthLevelRule {
  int? level;
  int? rechargeToken;

  WealthLevelRule({this.level, this.rechargeToken});

  WealthLevelRule.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    rechargeToken = json['rechargeToken'];
  }
}
