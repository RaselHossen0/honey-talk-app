import 'dart:convert';

SearchConnectionModel searchConnectionModelFromJson(String str) => SearchConnectionModel.fromJson(json.decode(str));

String searchConnectionModelToJson(SearchConnectionModel data) => json.encode(data.toJson());

class SearchConnectionModel {
  bool? status;
  String? message;
  List<SearchData>? searchData;

  SearchConnectionModel({
    this.status,
    this.message,
    this.searchData,
  });

  factory SearchConnectionModel.fromJson(Map<String, dynamic> json) => SearchConnectionModel(
        status: json["status"],
        message: json["message"],
        searchData: json["searchData"] == null ? [] : List<SearchData>.from(json["searchData"]!.map((x) => SearchData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "searchData": searchData == null ? [] : List<dynamic>.from(searchData!.map((x) => x.toJson())),
      };
}

class SearchData {
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

  SearchData({
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

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
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
