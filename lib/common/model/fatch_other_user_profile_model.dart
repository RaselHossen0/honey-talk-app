import 'dart:convert';

OtherUserProfileModel otherUserProfileModelFromJson(String str) => OtherUserProfileModel.fromJson(json.decode(str));

String otherUserProfileModelToJson(OtherUserProfileModel data) => json.encode(data.toJson());

class OtherUserProfileModel {
  bool? status;
  String? message;
  User? user;

  OtherUserProfileModel({
    this.status,
    this.message,
    this.user,
  });

  factory OtherUserProfileModel.fromJson(Map<String, dynamic> json) => OtherUserProfileModel(
        status: json["status"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user?.toJson(),
      };
}

class User {
  String? id;
  String? name;
  String? userName;
  String? gender;
  int? age;
  String? image;
  bool? isProfilePicBanned;
  String? countryFlagImage;
  String? country;
  String? uniqueId;
  int? coin;
  int? receivedGifts;
  WealthLevel? wealthLevel;
  bool? isVerified;
  int? totalFollowers;
  int? totalFollowing;
  int? totalFriends;
  int? totalVisitors;

  bool? isFollowed;

  User({
    this.id,
    this.name,
    this.userName,
    this.gender,
    this.age,
    this.image,
    this.isProfilePicBanned,
    this.countryFlagImage,
    this.country,
    this.uniqueId,
    this.coin,
    this.receivedGifts,
    this.wealthLevel,
    this.isVerified,
    this.totalFollowers,
    this.totalFollowing,
    this.totalFriends,
    this.totalVisitors,
    this.isFollowed,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        userName: json["userName"],
        gender: json["gender"],
        age: json["age"],
        image: json["image"],
        isProfilePicBanned: json["isProfilePicBanned"],
        countryFlagImage: json["countryFlagImage"],
        country: json["country"],
        uniqueId: json["uniqueId"],
        coin: json["coin"],
        receivedGifts: json["receivedGifts"],
        wealthLevel: json["wealthLevel"] == null ? null : WealthLevel.fromJson(json["wealthLevel"]),
        isVerified: json["isVerified"],
        totalFollowers: json["totalFollowers"],
        totalFollowing: json["totalFollowing"],
        totalFriends: json["totalFriends"],
        totalVisitors: json["totalVisitors"],
        isFollowed: json["isFollowed"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "userName": userName,
        "gender": gender,
        "age": age,
        "image": image,
        "isProfilePicBanned": isProfilePicBanned,
        "countryFlagImage": countryFlagImage,
        "country": country,
        "uniqueId": uniqueId,
        "coin": coin,
        "receivedGifts": receivedGifts,
        "wealthLevel": wealthLevel?.toJson(),
        "isVerified": isVerified,
        "totalFollowers": totalFollowers,
        "totalFollowing": totalFollowing,
        "totalFriends": totalFriends,
        "totalVisitors": totalVisitors,
        "isFollowed": isFollowed,
      };
}

class WealthLevel {
  String? id;
  String? levelImage;

  WealthLevel({
    this.id,
    this.levelImage,
  });

  factory WealthLevel.fromJson(Map<String, dynamic> json) => WealthLevel(
        id: json["_id"],
        levelImage: json["levelImage"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "levelImage": levelImage,
      };
}
