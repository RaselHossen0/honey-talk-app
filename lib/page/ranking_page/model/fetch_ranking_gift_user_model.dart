class FetchRankingGiftUserModel {
  final bool? status;
  final String? message;
  final GiftStatsData? data;

  FetchRankingGiftUserModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchRankingGiftUserModel.fromJson(Map<String, dynamic> json) => FetchRankingGiftUserModel(
        status: json['status'],
        message: json['message'],
        data: json['data'] != null ? GiftStatsData.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}

class GiftStatsData {
  final TimeframeStats? daily;
  final TimeframeStats? weekly;
  final TimeframeStats? monthly;

  GiftStatsData({
    this.daily,
    this.weekly,
    this.monthly,
  });

  factory GiftStatsData.fromJson(Map<String, dynamic> json) => GiftStatsData(
        daily: json['daily'] != null ? TimeframeStats.fromJson(json['daily']) : null,
        weekly: json['weekly'] != null ? TimeframeStats.fromJson(json['weekly']) : null,
        monthly: json['monthly'] != null ? TimeframeStats.fromJson(json['monthly']) : null,
      );

  Map<String, dynamic> toJson() => {
        'daily': daily?.toJson(),
        'weekly': weekly?.toJson(),
        'monthly': monthly?.toJson(),
      };
}

class TimeframeStats {
  final List<UserStats>? topSenders;
  final List<UserStats>? topReceivers;

  TimeframeStats({
    this.topSenders,
    this.topReceivers,
  });

  factory TimeframeStats.fromJson(Map<String, dynamic> json) => TimeframeStats(
        topSenders: json['topSenders'] != null ? List<UserStats>.from(json['topSenders'].map((x) => UserStats.fromJson(x))) : null,
        topReceivers: json['topReceivers'] != null ? List<UserStats>.from(json['topReceivers'].map((x) => UserStats.fromJson(x))) : null,
      );

  Map<String, dynamic> toJson() => {
        'topSenders': topSenders != null ? List<dynamic>.from(topSenders!.map((x) => x.toJson())) : null,
        'topReceivers': topReceivers != null ? List<dynamic>.from(topReceivers!.map((x) => x.toJson())) : null,
      };
}

class UserStats {
  final String? userId;
  final String? name;
  final String? image;
  final bool? isProfilePicBanned;
  final String? gender;
  final int? age;
  final bool? isVerified;
  final String? wealthLevelImage;
  final String? avtarFrame;
  final int? avtarFrameType;
  final int? coin;

  UserStats({
    this.userId,
    this.name,
    this.image,
    this.isProfilePicBanned,
    this.gender,
    this.age,
    this.isVerified,
    this.wealthLevelImage,
    this.avtarFrame,
    this.avtarFrameType,
    this.coin,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) => UserStats(
        userId: json['userId'],
        name: json['name'],
        image: json['image'],
        isProfilePicBanned: json['isProfilePicBanned'],
        gender: json['gender'],
        age: json['age'],
        isVerified: json['isVerified'],
        wealthLevelImage: json['wealthLevelImage'],
        avtarFrame: json['avtarFrame'],
        avtarFrameType: json['avtarFrameType'],
        coin: json['coin'],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'image': image,
        'isProfilePicBanned': isProfilePicBanned,
        'gender': gender,
        'age': age,
        'isVerified': isVerified,
        'wealthLevelImage': wealthLevelImage,
        'avtarFrame': avtarFrame,
        'avtarFrameType': avtarFrameType,
        'coin': coin,
      };
}
