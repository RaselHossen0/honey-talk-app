import 'dart:convert';

TopFramesModel topFramesModelFromJson(String str) => TopFramesModel.fromJson(json.decode(str));

String topFramesModelToJson(TopFramesModel data) => json.encode(data.toJson());

class TopFramesModel {
  bool? status;
  String? message;
  List<Recommended>? topFrames;
  List<Recommended>? recommended;

  TopFramesModel({
    this.status,
    this.message,
    this.topFrames,
    this.recommended,
  });

  factory TopFramesModel.fromJson(Map<String, dynamic> json) => TopFramesModel(
        status: json["status"],
        message: json["message"],
        topFrames: json["topFrames"] == null ? [] : List<Recommended>.from(json["topFrames"]!.map((x) => Recommended.fromJson(x))),
        recommended: json["recommended"] == null ? [] : List<Recommended>.from(json["recommended"]!.map((x) => Recommended.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "topFrames": topFrames == null ? [] : List<dynamic>.from(topFrames!.map((x) => x.toJson())),
        "recommended": recommended == null ? [] : List<dynamic>.from(recommended!.map((x) => x.toJson())),
      };
}

class Recommended {
  String? id;
  String? name;
  String? image;
  int? coin;
  int? validity;
  int? validityType;
  bool? isPurchased;
  ItemType? itemType;
  String? svgaImage;
  int? type;

  Recommended({
    this.id,
    this.name,
    this.image,
    this.coin,
    this.validity,
    this.validityType,
    this.isPurchased,
    this.itemType,
    this.svgaImage,
    this.type,
  });

  factory Recommended.fromJson(Map<String, dynamic> json) => Recommended(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        image: json["image"] ?? "",
        coin: json["coin"] ?? 0,
        validity: json["validity"] ?? 0,
        validityType: json["validityType"] ?? 0,
        isPurchased: json["isPurchased"] ?? false,
        itemType: itemTypeValues.map[json["itemType"]] ?? ItemType.frame,
        svgaImage: json["svgaImage"] ?? "",
        type: json["type"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "coin": coin,
        "validity": validity,
        "validityType": validityType,
        "isPurchased": isPurchased,
        "itemType": itemTypeValues.reverse[itemType],
        "svgaImage": svgaImage,
        "type": type,
      };
}

enum ItemType { frame, ride, theme }

final itemTypeValues = EnumValues({"frame": ItemType.frame, "ride": ItemType.ride, "theme": ItemType.theme});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
