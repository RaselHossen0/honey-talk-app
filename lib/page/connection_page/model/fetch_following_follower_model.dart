import 'dart:convert';

FollowerFollowingModel followerFollowingModelFromJson(String str) => FollowerFollowingModel.fromJson(json.decode(str));

String followerFollowingModelToJson(FollowerFollowingModel data) => json.encode(data.toJson());

class FollowerFollowingModel {
  bool? status;
  String? message;
  List<Follower>? friends;
  List<Follower>? following;
  List<Follower>? followers;

  FollowerFollowingModel({
    this.status,
    this.message,
    this.friends,
    this.following,
    this.followers,
  });

  factory FollowerFollowingModel.fromJson(Map<String, dynamic> json) => FollowerFollowingModel(
        status: json["status"],
        message: json["message"],
        friends: json["friends"] == null ? [] : List<Follower>.from(json["friends"]!.map((x) => Follower.fromJson(x))),
        following: json["following"] == null ? [] : List<Follower>.from(json["following"]!.map((x) => Follower.fromJson(x))),
        followers: json["followers"] == null ? [] : List<Follower>.from(json["followers"]!.map((x) => Follower.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "friends": friends == null ? [] : List<dynamic>.from(friends!.map((x) => x.toJson())),
        "following": following == null ? [] : List<dynamic>.from(following!.map((x) => x.toJson())),
        "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x.toJson())),
      };
}

class Follower {
  String? id;
  String? name;
  String? userName;
  String? image;
  bool? isProfilePicBanned;
  int? age;
  bool? isVerified;
  String? country;
  String? countryFlagImage;
  int? coin;
  String? uniqueId;
  bool? isOnline;
  DateTime? date;
  String? wealthLevelImage;
  bool? isFollow;

  Follower({
    this.id,
    this.name,
    this.userName,
    this.image,
    this.isProfilePicBanned,
    this.age,
    this.isVerified,
    this.country,
    this.countryFlagImage,
    this.coin,
    this.uniqueId,
    this.isOnline,
    this.date,
    this.wealthLevelImage,
    this.isFollow,
  });

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        id: json["_id"],
        name: json["name"],
        userName: json["userName"],
        image: json["image"],
        isProfilePicBanned: json["isProfilePicBanned"],
        age: json["age"],
        isVerified: json["isVerified"],
        country: json["country"],
        countryFlagImage: json["countryFlagImage"],
        coin: json["coin"],
        uniqueId: json["uniqueId"],
        isOnline: json["isOnline"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        wealthLevelImage: json["wealthLevelImage"],
        isFollow: json["isFollow"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "userName": userName,
        "image": image,
        "isProfilePicBanned": isProfilePicBanned,
        "age": age,
        "isVerified": isVerified,
        "country": country,
        "countryFlagImage": countryFlagImage,
        "coin": coin,
        "uniqueId": uniqueId,
        "isOnline": isOnline,
        "date": date?.toIso8601String(),
        "wealthLevelImage": wealthLevelImage,
        "isFollow": isFollow,
      };
}
