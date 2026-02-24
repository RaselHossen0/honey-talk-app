import 'dart:convert';

FetchPurchasedFrameModel fetchPurchasedFrameModelFromJson(String str) => FetchPurchasedFrameModel.fromJson(json.decode(str));

String fetchPurchasedFrameModelToJson(FetchPurchasedFrameModel data) => json.encode(data.toJson());

class FetchPurchasedFrameModel {
  bool? status;
  String? message;
  Data? data;

  FetchPurchasedFrameModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchPurchasedFrameModel.fromJson(Map<String, dynamic> json) => FetchPurchasedFrameModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  AvatarFrames? themes;
  AvatarFrames? avatarFrames;
  AvatarFrames? rides;

  Data({
    this.themes,
    this.avatarFrames,
    this.rides,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        themes: json["themes"] == null ? null : AvatarFrames.fromJson(json["themes"]),
        avatarFrames: json["avatarFrames"] == null ? null : AvatarFrames.fromJson(json["avatarFrames"]),
        rides: json["rides"] == null ? null : AvatarFrames.fromJson(json["rides"]),
      );

  Map<String, dynamic> toJson() => {
        "themes": themes?.toJson(),
        "avatarFrames": avatarFrames?.toJson(),
        "rides": rides?.toJson(),
      };
}

class AvatarFrames {
  List<Active>? active;
  List<Active>? expired;

  AvatarFrames({
    this.active,
    this.expired,
  });

  factory AvatarFrames.fromJson(Map<String, dynamic> json) => AvatarFrames(
        active: json["active"] == null ? [] : List<Active>.from(json["active"]!.map((x) => Active.fromJson(x))),
        expired: json["expired"] == null ? [] : List<Active>.from(json["expired"]!.map((x) => Active.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "active": active == null ? [] : List<dynamic>.from(active!.map((x) => x.toJson())),
        "expired": expired == null ? [] : List<dynamic>.from(expired!.map((x) => x.toJson())),
      };
}

class Active {
  DateTime? expiryDate;
  DateTime? purchaseDate;
  bool? isExpired;
  bool? isSelected;
  String? itemId;
  int? type;
  String? image;
  String? svgaImage;
  String? name;

  Active({
    this.expiryDate,
    this.purchaseDate,
    this.isExpired,
    this.isSelected,
    this.itemId,
    this.type,
    this.image,
    this.svgaImage,
    this.name,
  });

  factory Active.fromJson(Map<String, dynamic> json) => Active(
        expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
        purchaseDate: json["purchaseDate"] == null ? null : DateTime.parse(json["purchaseDate"]),
        isExpired: json["isExpired"],
        isSelected: json["isSelected"],
        itemId: json["itemId"],
        type: json["type"],
        image: json["image"],
        svgaImage: json["svgaImage"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "expiryDate": expiryDate?.toIso8601String(),
        "purchaseDate": purchaseDate?.toIso8601String(),
        "isExpired": isExpired,
        "isSelected": isSelected,
        "itemId": itemId,
        "type": type,
        "image": image,
        "svgaImage": svgaImage,
        "name": name,
      };
}
