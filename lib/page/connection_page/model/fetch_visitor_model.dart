import 'dart:convert';

VisitorModel visitorModelFromJson(String str) => VisitorModel.fromJson(json.decode(str));

String visitorModelToJson(VisitorModel data) => json.encode(data.toJson());

class VisitorModel {
  bool? status;
  String? message;
  List<ProfileVisitor>? profileVisitors;
  List<ProfileVisitor>? visitedProfiles;

  VisitorModel({
    this.status,
    this.message,
    this.profileVisitors,
    this.visitedProfiles,
  });

  factory VisitorModel.fromJson(Map<String, dynamic> json) => VisitorModel(
        status: json["status"],
        message: json["message"],
        profileVisitors: json["profileVisitors"] == null ? [] : List<ProfileVisitor>.from(json["profileVisitors"]!.map((x) => ProfileVisitor.fromJson(x))),
        visitedProfiles: json["visitedProfiles"] == null ? [] : List<ProfileVisitor>.from(json["visitedProfiles"]!.map((x) => ProfileVisitor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "profileVisitors": profileVisitors == null ? [] : List<dynamic>.from(profileVisitors!.map((x) => x.toJson())),
        "visitedProfiles": visitedProfiles == null ? [] : List<dynamic>.from(visitedProfiles!.map((x) => x.toJson())),
      };
}

class ProfileVisitor {
  bool? isFollow;
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
  String? wealthLevelImage;
  DateTime? date;

  ProfileVisitor({
    this.isFollow,
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
    this.wealthLevelImage,
    this.date,
  });

  factory ProfileVisitor.fromJson(Map<String, dynamic> json) => ProfileVisitor(
        isFollow: json["isFollow"],
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
        wealthLevelImage: json["wealthLevelImage"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "isFollow": isFollow,
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
        "wealthLevelImage": wealthLevelImage,
        "date": date?.toIso8601String(),
      };
}
