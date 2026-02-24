class LiveTopGiftUserModel {
  final UserId? userId;
  final int? totalCoins;
  final String? id;
  final bool? isFollow;

  LiveTopGiftUserModel({
    this.userId,
    this.totalCoins,
    this.id,
    this.isFollow,
  });

  factory LiveTopGiftUserModel.fromJson(Map<String, dynamic> json) {
    return LiveTopGiftUserModel(
      userId: json['userId'] != null ? UserId.fromJson(json['userId']) : null,
      totalCoins: json['totalCoins'],
      id: json['_id'],
      isFollow: json['isFollow'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId?.toJson(),
      'totalCoins': totalCoins,
      '_id': id,
      'isFollow': isFollow,
    };
  }
}

class UserId {
  final String? id;
  final String? name;
  final String? userName;
  final String? image;
  final bool? isProfilePicBanned;
  final int? activeAvtarFrameType;
  final String? activeAvtarFrameImage;

  UserId({
    this.id,
    this.name,
    this.userName,
    this.image,
    this.isProfilePicBanned,
    this.activeAvtarFrameType,
    this.activeAvtarFrameImage,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['_id'],
      name: json['name'],
      userName: json['userName'],
      image: json['image'],
      isProfilePicBanned: json['isProfilePicBanned'],
      activeAvtarFrameType: json['activeAvtarFrameType'],
      activeAvtarFrameImage: json['activeAvtarFrameImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'userName': userName,
      'image': image,
      'isProfilePicBanned': isProfilePicBanned,
      'activeAvtarFrameType': activeAvtarFrameType,
      'activeAvtarFrameImage': activeAvtarFrameImage,
    };
  }
}
