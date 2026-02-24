import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';

class CreateLiveUserModel {
  bool? status;
  String? message;
  Data? data;

  CreateLiveUserModel({this.status, this.message, this.data});

  CreateLiveUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  PkConfig? pkConfig;
  String? name;
  String? userName;
  String? image;
  int? view;
  String? channel;
  String? token;
  int? liveType;
  int? agoraUid;
  bool? isPkMode;
  String? pkEndTime;
  String? pkId;
  int? audioLiveType;
  int? privateCode;
  String? roomName;
  String? roomWelcome;
  String? roomImage;
  String? bgTheme;
  bool? isAudio;
  String? id;
  List<Seat>? seat;
  String? liveHistoryId;
  String? createdAt;
  String? updatedAt;
  String? userId;

  Data(
      {this.pkConfig,
      this.name,
      this.userName,
      this.image,
      this.view,
      this.channel,
      this.token,
      this.liveType,
      this.agoraUid,
      this.isPkMode,
      this.pkEndTime,
      this.pkId,
      this.audioLiveType,
      this.privateCode,
      this.roomName,
      this.roomWelcome,
      this.roomImage,
      this.bgTheme,
      this.isAudio,
      this.id,
      this.seat,
      this.liveHistoryId,
      this.createdAt,
      this.updatedAt,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    pkConfig = json['pkConfig'] != null ? PkConfig.fromJson(json['pkConfig']) : null;
    name = json['name'];
    userName = json['userName'];
    image = json['image'];
    view = json['view'];
    channel = json['channel'];
    token = json['token'];
    liveType = json['liveType'];
    agoraUid = json['agoraUid'];
    isPkMode = json['isPkMode'];
    pkEndTime = json['pkEndTime'];
    pkId = json['pkId'];
    audioLiveType = json['audioLiveType'];
    privateCode = json['privateCode'];
    roomName = json['roomName'];
    roomWelcome = json['roomWelcome'];
    roomImage = json['roomImage'];
    bgTheme = json['bgTheme'];
    isAudio = json['isAudio'];
    id = json['_id'];
    if (json['seat'] != null) {
      seat = <Seat>[];
      json['seat'].forEach((v) {
        seat!.add(Seat.fromJson(v));
      });
    }
    liveHistoryId = json['liveHistoryId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pkConfig != null) {
      data['pkConfig'] = pkConfig!.toJson();
    }
    data['name'] = name;
    data['userName'] = userName;
    data['image'] = image;
    data['view'] = view;
    data['channel'] = channel;
    data['token'] = token;
    data['liveType'] = liveType;
    data['agoraUid'] = agoraUid;
    data['isPkMode'] = isPkMode;
    data['pkEndTime'] = pkEndTime;
    data['pkId'] = pkId;
    data['audioLiveType'] = audioLiveType;
    data['privateCode'] = privateCode;
    data['roomName'] = roomName;
    data['roomWelcome'] = roomWelcome;
    data['roomImage'] = roomImage;
    data['bgTheme'] = bgTheme;
    data['isAudio'] = isAudio;
    data['_id'] = id;
    if (seat != null) {
      data['seat'] = seat!.map((v) => v.toJson()).toList();
    }
    data['liveHistoryId'] = liveHistoryId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    return data;
  }
}

class PkConfig {
  Host1Details? host1Details;
  Host1Details? host2Details;
  String? host1Id;
  String? host2Id;
  String? host1UniqueId;
  String? host2UniqueId;
  String? host1Name;
  String? host2Name;
  String? host2userName;
  String? host1Image;
  String? host2Image;
  String? host1Token;
  String? host2Token;
  String? host1Channel;
  String? host2Channel;
  String? host1LiveId;
  String? host2LiveId;
  int? host1AgoraUID;
  int? host2AgoraUID;
  int? localRank;
  int? agoraUid;

  int? isWinner;

  PkConfig(
      {this.host1Details,
      this.host2Details,
      this.host1Id,
      this.host2Id,
      this.host1UniqueId,
      this.host2UniqueId,
      this.host1Name,
      this.host2Name,
      this.host2userName,
      this.host1Image,
      this.host2Image,
      this.host1Token,
      this.host2Token,
      this.host1Channel,
      this.host2Channel,
      this.host1LiveId,
      this.host2LiveId,
      this.host1AgoraUID,
      this.host2AgoraUID,
      this.localRank,
      this.agoraUid,
      this.isWinner});

  PkConfig.fromJson(Map<String, dynamic> json) {
    host1Details = json['host1Details'] != null ? Host1Details.fromJson(json['host1Details']) : null;
    host2Details = json['host2Details'] != null ? Host1Details.fromJson(json['host2Details']) : null;
    host1Id = json['host1Id'];
    host2Id = json['host2Id'];
    host1UniqueId = json['host1UniqueId'];
    host2UniqueId = json['host2UniqueId'];
    host1Name = json['host1Name'];
    host2Name = json['host2Name'];
    host2userName = json['host2userName'];
    host1Image = json['host1Image'];
    host2Image = json['host2Image'];
    host1Token = json['host1Token'];
    host2Token = json['host2Token'];
    host1Channel = json['host1Channel'];
    host2Channel = json['host2Channel'];
    host1LiveId = json['host1LiveId'];
    host2LiveId = json['host2LiveId'];
    host1AgoraUID = json['host1AgoraUID'];
    host2AgoraUID = json['host2AgoraUID'];
    localRank = json['localRank'];

    agoraUid = json['agoraUid'];
    isWinner = json['isWinner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (host1Details != null) {
      data['host1Details'] = host1Details!.toJson();
    }
    if (host2Details != null) {
      data['host2Details'] = host2Details!.toJson();
    }
    data['host1Id'] = host1Id;
    data['host2Id'] = host2Id;
    data['host1UniqueId'] = host1UniqueId;
    data['host2UniqueId'] = host2UniqueId;
    data['host1Name'] = host1Name;
    data['host2Name'] = host2Name;
    data['host2userName'] = host2userName;
    data['host1Image'] = host1Image;
    data['host2Image'] = host2Image;
    data['host1Token'] = host1Token;
    data['host2Token'] = host2Token;
    data['host1Channel'] = host1Channel;
    data['host2Channel'] = host2Channel;
    data['host1LiveId'] = host1LiveId;
    data['host2LiveId'] = host2LiveId;
    data['host1AgoraUID'] = host1AgoraUID;
    data['host2AgoraUID'] = host2AgoraUID;
    data['localRank'] = localRank;

    data['agoraUid'] = agoraUid;
    data['isWinner'] = isWinner;
    return data;
  }
}

class Host1Details {
  String? userId;
  String? name;
  int? coin;
  String? image;
  String? countryFlagImage;
  String? country;
  String? uniqueId;

  Host1Details({this.userId, this.name, this.coin, this.image, this.countryFlagImage, this.country, this.uniqueId});

  Host1Details.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    coin = json['coin'];
    image = json['image'];
    countryFlagImage = json['countryFlagImage'];
    country = json['country'];
    uniqueId = json['uniqueId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['coin'] = coin;
    data['image'] = image;
    data['countryFlagImage'] = countryFlagImage;
    data['country'] = country;
    data['uniqueId'] = uniqueId;
    return data;
  }
}

// class Seat {
//   String? id;
//   int? position;
//   int? mute;
//   bool? lock;
//   bool? reserved;
//   bool? speaking;
//   bool? invite;
//   String? userId;
//   String? name;
//   String? image;
//   int? agoraUid;
//
//   Seat({this.id, this.position, this.mute, this.lock, this.reserved, this.speaking, this.invite, this.userId, this.name, this.image, this.agoraUid});
//
//   Seat.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     position = json['position'];
//     mute = json['mute'];
//     lock = json['lock'];
//     reserved = json['reserved'];
//     speaking = json['speaking'];
//     invite = json['invite'];
//     userId = json['userId'];
//     name = json['name'];
//     image = json['image'];
//     agoraUid = json['agoraUid'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = id;
//     data['position'] = position;
//     data['mute'] = mute;
//     data['lock'] = lock;
//     data['reserved'] = reserved;
//     data['speaking'] = speaking;
//     data['invite'] = invite;
//     data['userId'] = userId;
//     data['name'] = name;
//     data['image'] = image;
//     data['agoraUid'] = agoraUid;
//     return data;
//   }
// }

// Live Stream Response Model

class UserValue {
  final String? id;
  final ActiveTheme? activeTheme;

  UserValue({
    this.id,
    this.activeTheme,
  });

  factory UserValue.fromJson(Map<String, dynamic> json) {
    return UserValue(
      id: json['_id'],
      activeTheme: json['activeTheme'] != null ? ActiveTheme.fromJson(json['activeTheme']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    if (activeTheme != null) {
      data['activeTheme'] = activeTheme!.toJson();
    }
    return data;
  }
}

class ActiveTheme {
  final String? id;
  final String? image;

  ActiveTheme({
    this.id,
    this.image,
  });

  factory ActiveTheme.fromJson(Map<String, dynamic> json) {
    return ActiveTheme(
      id: json['_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['image'] = image;
    return data;
  }
}
