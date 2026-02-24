import 'dart:convert';

AllStoreItemModel allStoreItemModelFromJson(String str) => AllStoreItemModel.fromJson(json.decode(str));

String allStoreItemModelToJson(AllStoreItemModel data) => json.encode(data.toJson());

class AllStoreItemModel {
  bool? status;
  String? message;
  Data? data;

  AllStoreItemModel({
    this.status,
    this.message,
    this.data,
  });

  factory AllStoreItemModel.fromJson(Map<String, dynamic> json) => AllStoreItemModel(
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
  List<AvatarFrame>? avatarFrames;
  List<AvatarFrame>? themes;
  List<AvatarFrame>? rides;

  Data({
    this.avatarFrames,
    this.themes,
    this.rides,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        avatarFrames: json["avatarFrames"] == null ? [] : List<AvatarFrame>.from(json["avatarFrames"]!.map((x) => AvatarFrame.fromJson(x))),
        themes: json["themes"] == null ? [] : List<AvatarFrame>.from(json["themes"]!.map((x) => AvatarFrame.fromJson(x))),
        rides: json["rides"] == null ? [] : List<AvatarFrame>.from(json["rides"]!.map((x) => AvatarFrame.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "avatarFrames": avatarFrames == null ? [] : List<dynamic>.from(avatarFrames!.map((x) => x.toJson())),
        "themes": themes == null ? [] : List<dynamic>.from(themes!.map((x) => x.toJson())),
        "rides": rides == null ? [] : List<dynamic>.from(rides!.map((x) => x.toJson())),
      };
}

class AvatarFrame {
  String? id;
  String? name;
  int? type;
  String? image;
  String? svgaImage;
  int? coin;
  int? validity;
  int? validityType;
  DateTime? createdAt;
  bool? isPurchased;

  AvatarFrame({
    this.id,
    this.name,
    this.type,
    this.image,
    this.svgaImage,
    this.coin,
    this.validity,
    this.validityType,
    this.createdAt,
    this.isPurchased,
  });

  factory AvatarFrame.fromJson(Map<String, dynamic> json) => AvatarFrame(
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        image: json["image"],
        svgaImage: json["svgaImage"],
        coin: json["coin"],
        validity: json["validity"],
        validityType: json["validityType"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        isPurchased: json["isPurchased"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "type": type,
        "image": image,
        "svgaImage": svgaImage,
        "coin": coin,
        "validity": validity,
        "validityType": validityType,
        "createdAt": createdAt?.toIso8601String(),
        "isPurchased": isPurchased,
      };
}
