// class FetchLiveUserModel {
//   bool? status;
//   String? message;
//   List<LiveUserList>? liveUserList;
//
//   FetchLiveUserModel({this.status, this.message, this.liveUserList});
//
//   FetchLiveUserModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['liveUserList'] != null) {
//       liveUserList = <LiveUserList>[];
//       json['liveUserList'].forEach((v) {
//         liveUserList!.add(LiveUserList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (liveUserList != null) {
//       data['liveUserList'] = liveUserList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class LiveUserList {
//   String? id;
//   String? userId;
//   String? name;
//   String? userName;
//   String? image;
//   String? countryFlagImage;
//   bool? isVerified;
//   int? view;
//   int? hostIsMuted;
//   String? channel;
//   String? token;
//   int? liveType;
//   bool? isPkMode;
//   String? videoUrl;
//   bool? isFake;
//   int? audioLiveType;
//   int? privateCode;
//   int? agoraUid;
//   String? roomName;
//   String? roomWelcome;
//   String? roomImage;
//   bool? isAudio;
//   List<Seat>? seat;
//   List<MultiLiveUsersModel>? requested;
//   String? liveHistoryId;
//   String? host2Id;
//   String? host2UniqueId;
//   String? host2Name;
//   String? host2userName;
//   String? host2Image;
//   String? host2Channel;
//   String? host2LiveId;
//   String? host2Token;
//   bool? isFollow;
//   bool? host2IsFollow;
//   List<dynamic>? blockedUsers;
//   List<Viewer>? viewers;
//   int? localRank;
//   int? localGiftCount;
//   int? remoteRank;
//   int? remoteGiftCount;
//   int? host2Coin;
//   String? host2wealthLevelImage;
//   String? uniqueId;
//   int? coin;
//   String? wealthLevelImage;
//
//   LiveUserList({
//     this.id,
//     this.userId,
//     this.name,
//     this.userName,
//     this.image,
//     this.countryFlagImage,
//     this.isVerified,
//     this.view,
//     this.hostIsMuted,
//     this.channel,
//     this.token,
//     this.liveType,
//     this.isPkMode,
//     this.videoUrl,
//     this.isFake,
//     this.audioLiveType,
//     this.privateCode,
//     this.agoraUid,
//     this.roomName,
//     this.roomWelcome,
//     this.roomImage,
//     this.isAudio,
//     this.seat,
//     this.requested,
//     this.liveHistoryId,
//     this.host2Id,
//     this.host2UniqueId,
//     this.host2Name,
//     this.host2userName,
//     this.host2Image,
//     this.host2Channel,
//     this.host2LiveId,
//     this.host2Token,
//     this.isFollow,
//     this.host2IsFollow,
//     this.blockedUsers,
//     this.viewers,
//     this.localRank,
//     this.localGiftCount,
//     this.remoteRank,
//     this.remoteGiftCount,
//     this.host2Coin,
//     this.host2wealthLevelImage,
//     this.uniqueId,
//     this.coin,
//     this.wealthLevelImage,
//   });
//
//   LiveUserList.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     userId = json['userId'];
//     name = json['name'];
//     userName = json['userName'];
//     image = json['image'];
//     countryFlagImage = json['countryFlagImage'];
//     isVerified = json['isVerified'];
//     view = json['view'];
//     hostIsMuted = json['hostIsMuted'];
//     channel = json['channel'];
//     token = json['token'];
//     liveType = json['liveType'];
//     isPkMode = json['isPkMode'];
//     videoUrl = json['videoUrl'];
//     isFake = json['isFake'];
//     audioLiveType = json['audioLiveType'];
//     privateCode = json['privateCode'];
//     agoraUid = json['agoraUid'];
//     roomName = json['roomName'];
//     roomWelcome = json['roomWelcome'];
//     roomImage = json['roomImage'];
//     isAudio = json['isAudio'];
//     if (json['seat'] != null) {
//       seat = <Seat>[];
//       json['seat'].forEach((v) {
//         seat!.add(Seat.fromJson(v));
//       });
//     }
//     if (json['requested'] != null) {
//       requested = <MultiLiveUsersModel>[];
//       json['requested'].forEach((v) {
//         requested!.add(MultiLiveUsersModel.fromJson(v));
//       });
//     }
//     liveHistoryId = json['liveHistoryId'];
//     host2Id = json['host2Id'];
//     host2UniqueId = json['host2UniqueId'];
//     host2Name = json['host2Name'];
//     host2userName = json['host2userName'];
//     host2Image = json['host2Image'];
//     host2Channel = json['host2Channel'];
//     host2LiveId = json['host2LiveId'];
//     host2Token = json['host2Token'];
//     isFollow = json['isFollow'];
//     host2IsFollow = json['host2IsFollow'];
//     blockedUsers = json['blockedUsers'];
//     localRank = json['localRank'];
//     localGiftCount = json['localGiftCount'];
//     remoteRank = json['remoteRank'];
//     remoteGiftCount = json['remoteGiftCount'];
//     host2Coin = json['host2Coin'];
//     host2wealthLevelImage = json['host2wealthLevelImage'];
//     uniqueId = json['uniqueId'];
//     coin = json['coin'];
//     wealthLevelImage = json['wealthLevelImage'];
//
//     if (json['viewers'] != null) {
//       viewers = <Viewer>[];
//       json['viewers'].forEach((v) {
//         viewers!.add(Viewer.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = id;
//     data['userId'] = userId;
//     data['name'] = name;
//     data['userName'] = userName;
//     data['image'] = image;
//     data['countryFlagImage'] = countryFlagImage;
//     data['isVerified'] = isVerified;
//     data['view'] = view;
//     data['hostIsMuted'] = hostIsMuted;
//     data['channel'] = channel;
//     data['token'] = token;
//     data['liveType'] = liveType;
//     data['isPkMode'] = isPkMode;
//     data['videoUrl'] = videoUrl;
//     data['isFake'] = isFake;
//     data['audioLiveType'] = audioLiveType;
//     data['privateCode'] = privateCode;
//     data['agoraUid'] = agoraUid;
//     data['roomName'] = roomName;
//     data['roomWelcome'] = roomWelcome;
//     data['roomImage'] = roomImage;
//     data['isAudio'] = isAudio;
//     if (seat != null) {
//       data['seat'] = seat!.map((v) => v.toJson()).toList();
//     }
//     if (requested != null) {
//       data['requested'] = requested!.map((v) => v.toJson()).toList();
//     }
//     data['liveHistoryId'] = liveHistoryId;
//     data['host2Id'] = host2Id;
//     data['host2UniqueId'] = host2UniqueId;
//     data['host2Name'] = host2Name;
//     data['host2userName'] = host2userName;
//     data['host2Image'] = host2Image;
//     data['host2Channel'] = host2Channel;
//     data['host2LiveId'] = host2LiveId;
//     data['host2Token'] = host2Token;
//     data['isFollow'] = isFollow;
//     data['host2IsFollow'] = host2IsFollow;
//     data['blockedUsers'] = blockedUsers;
//     data['localRank'] = localRank;
//     data['localGiftCount'] = localGiftCount;
//     data['remoteRank'] = remoteRank;
//     data['remoteGiftCount'] = remoteGiftCount;
//     data['host2Coin'] = host2Coin;
//     data['host2wealthLevelImage'] = host2wealthLevelImage;
//     data['uniqueId'] = uniqueId;
//     data['coin'] = coin;
//     data['wealthLevelImage'] = wealthLevelImage;
//     if (viewers != null) {
//       data['viewers'] = viewers!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// // Added new Viewer class
// class Viewer {
//   String? image;
//   bool? isProfilePicBanned;
//
//   Viewer({this.image, this.isProfilePicBanned});
//
//   Viewer.fromJson(Map<String, dynamic> json) {
//     image = json['image'];
//     isProfilePicBanned = json['isProfilePicBanned'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['image'] = image;
//     data['isProfilePicBanned'] = isProfilePicBanned;
//     return data;
//   }
// }
//
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
//   int? coin;
//
//   Seat({
//     this.id,
//     this.position,
//     this.mute,
//     this.lock,
//     this.reserved,
//     this.speaking,
//     this.invite,
//     this.userId,
//     this.name,
//     this.image,
//     this.agoraUid,
//     this.coin,
//   });
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
//     coin = json['coin'];
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
//     data['coin'] = coin;
//     return data;
//   }
// }
//
// class MultiLiveUsersModel {
//   String? userId;
//   String? name;
//   String? userName;
//   String? image;
//   String? country;
//   bool? isVerified;
//   int? agoraUid;
//   bool? isMute;
//   bool? isRequested;
//   bool? isAccepted;
//   bool? isInvited;
//
//   MultiLiveUsersModel(
//       {this.userId, this.name, this.userName, this.image, this.country, this.isVerified, this.agoraUid, this.isMute, this.isRequested, this.isAccepted, this.isInvited});
//
//   MultiLiveUsersModel.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     name = json['name'];
//     userName = json['userName'];
//     image = json['image'];
//     country = json['country'];
//     isVerified = json['isVerified'];
//     agoraUid = json['agoraUid'];
//     isMute = json['isMute'];
//     isRequested = json['isRequested'];
//     isAccepted = json['isAccepted'];
//     isInvited = json['isInvited'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['userId'] = userId;
//     data['name'] = name;
//     data['userName'] = userName;
//     data['image'] = image;
//     data['country'] = country;
//     data['isVerified'] = isVerified;
//     data['agoraUid'] = agoraUid;
//     data['isMute'] = isMute;
//     data['isRequested'] = isRequested;
//     data['isAccepted'] = isAccepted;
//     data['isInvited'] = isInvited;
//     return data;
//   }
// }
//

class FetchLiveUserModel {
  bool? status;
  String? message;
  List<LiveUserList>? liveUserList;

  FetchLiveUserModel({this.status, this.message, this.liveUserList});

  FetchLiveUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['liveUserList'] != null) {
      liveUserList = <LiveUserList>[];
      json['liveUserList'].forEach((v) {
        liveUserList!.add(LiveUserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (liveUserList != null) {
      data['liveUserList'] = liveUserList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveUserList {
  String? id;
  String? userId;
  List<String>? pkThumbnails;
  String? streamSource;
  List<String>? pkStreamSources;
  String? name;
  String? userName;
  String? image;
  bool? isProfilePicBanned;
  String? countryFlagImage;
  String? country;
  bool? isVerified;
  int? view;
  int? hostIsMuted;
  String? channel;
  String? token;
  int? liveType;
  bool? isPkMode;
  String? videoUrl;
  bool? isFake;
  int? audioLiveType;
  int? privateCode;
  int? agoraUid;
  String? roomName;
  String? roomWelcome;
  String? roomImage;
  bool? isAudio;
  List<Seat>? seat;
  List<MultiLiveUsersModel>? requested;
  String? liveHistoryId;
  String? host2Id;
  String? host2UniqueId;
  String? host2Name;
  String? host2userName;
  String? host2Image;
  bool? host2IsProfilePicBanned;
  String? host2Channel;
  String? host2LiveId;
  String? host2Token;
  String? bgTheme;
  bool? isFollow;
  bool? host2IsFollow;
  List<dynamic>? blockedUsers;
  List<Viewer>? viewers;
  int? localRank;
  int? localGiftCount;
  int? remoteRank;
  int? remoteGiftCount;
  int? host2Coin;
  String? host2wealthLevelImage;
  String? uniqueId;
  int? coin;
  String? wealthLevelImage;
  String? themeId; // New parameter
  String? theme; // New parameter

  LiveUserList({
    this.id,
    this.userId,
    this.pkThumbnails,
    this.streamSource,
    this.pkStreamSources,
    this.name,
    this.userName,
    this.image,
    this.isProfilePicBanned,
    this.countryFlagImage,
    this.country,
    this.isVerified,
    this.view,
    this.hostIsMuted,
    this.channel,
    this.token,
    this.liveType,
    this.isPkMode,
    this.videoUrl,
    this.isFake,
    this.audioLiveType,
    this.privateCode,
    this.agoraUid,
    this.roomName,
    this.roomWelcome,
    this.roomImage,
    this.isAudio,
    this.seat,
    this.requested,
    this.liveHistoryId,
    this.host2Id,
    this.host2UniqueId,
    this.host2Name,
    this.host2userName,
    this.host2Image,
    this.host2IsProfilePicBanned,
    this.host2Channel,
    this.host2LiveId,
    this.host2Token,
    this.bgTheme,
    this.isFollow,
    this.host2IsFollow,
    this.blockedUsers,
    this.viewers,
    this.localRank,
    this.localGiftCount,
    this.remoteRank,
    this.remoteGiftCount,
    this.host2Coin,
    this.host2wealthLevelImage,
    this.uniqueId,
    this.coin,
    this.wealthLevelImage,
    this.themeId, // New parameter in constructor
    this.theme, // New parameter in constructor
  });

  LiveUserList.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    pkThumbnails = json['pkThumbnails'] != null ? List<String>.from(json['pkThumbnails']) : null;
    streamSource = json['streamSource'];
    pkStreamSources = json['pkStreamSources'] != null ? List<String>.from(json['pkStreamSources']) : null;
    name = json['name'];
    userName = json['userName'];
    image = json['image'];
    isProfilePicBanned = json['isProfilePicBanned'];
    countryFlagImage = json['countryFlagImage'];
    country = json['country'];
    isVerified = json['isVerified'];
    view = json['view'];
    hostIsMuted = json['hostIsMuted'];
    channel = json['channel'];
    token = json['token'];
    liveType = json['liveType'];
    isPkMode = json['isPkMode'];
    videoUrl = json['videoUrl'];
    isFake = json['isFake'];
    audioLiveType = json['audioLiveType'];
    privateCode = json['privateCode'];
    agoraUid = json['agoraUid'];
    roomName = json['roomName'];
    roomWelcome = json['roomWelcome'];
    roomImage = json['roomImage'];
    isAudio = json['isAudio'];
    if (json['seat'] != null) {
      seat = <Seat>[];
      json['seat'].forEach((v) {
        seat!.add(Seat.fromJson(v));
      });
    }
    if (json['requested'] != null) {
      requested = <MultiLiveUsersModel>[];
      json['requested'].forEach((v) {
        requested!.add(MultiLiveUsersModel.fromJson(v));
      });
    }
    liveHistoryId = json['liveHistoryId'];
    host2Id = json['host2Id'];
    host2UniqueId = json['host2UniqueId'];
    host2Name = json['host2Name'];
    host2userName = json['host2userName'];
    host2Image = json['host2Image'];
    host2IsProfilePicBanned = json['host2isProfilePicBanned'];
    host2Channel = json['host2Channel'];
    host2LiveId = json['host2LiveId'];
    host2Token = json['host2Token'];
    bgTheme = json['bgTheme'];
    isFollow = json['isFollow'];
    host2IsFollow = json['host2IsFollow'];
    blockedUsers = json['blockedUsers'] != null ? List<dynamic>.from(json['blockedUsers']) : null;
    localRank = json['localRank'];
    localGiftCount = json['localGiftCount'];
    remoteRank = json['remoteRank'];
    remoteGiftCount = json['remoteGiftCount'];
    host2Coin = json['host2Coin'];
    host2wealthLevelImage = json['host2wealthLevelImage'];
    uniqueId = json['uniqueId'];
    coin = json['coin'];
    wealthLevelImage = json['wealthLevelImage'];
    themeId = json['themeId']; // New parameter in fromJson
    theme = json['theme']; // New parameter in fromJson

    if (json['viewers'] != null) {
      viewers = <Viewer>[];
      json['viewers'].forEach((v) {
        viewers!.add(Viewer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userId'] = userId;
    if (pkThumbnails != null) data['pkThumbnails'] = pkThumbnails;
    data['streamSource'] = streamSource;
    if (pkStreamSources != null) data['pkStreamSources'] = pkStreamSources;
    data['name'] = name;
    data['userName'] = userName;
    data['image'] = image;
    data['isProfilePicBanned'] = isProfilePicBanned;
    data['countryFlagImage'] = countryFlagImage;
    data['country'] = country;
    data['isVerified'] = isVerified;
    data['view'] = view;
    data['hostIsMuted'] = hostIsMuted;
    data['channel'] = channel;
    data['token'] = token;
    data['liveType'] = liveType;
    data['isPkMode'] = isPkMode;
    data['videoUrl'] = videoUrl;
    data['isFake'] = isFake;
    data['audioLiveType'] = audioLiveType;
    data['privateCode'] = privateCode;
    data['agoraUid'] = agoraUid;
    data['roomName'] = roomName;
    data['roomWelcome'] = roomWelcome;
    data['roomImage'] = roomImage;
    data['isAudio'] = isAudio;
    if (seat != null) {
      data['seat'] = seat!.map((v) => v.toJson()).toList();
    }
    if (requested != null) {
      data['requested'] = requested!.map((v) => v.toJson()).toList();
    }
    data['liveHistoryId'] = liveHistoryId;
    data['host2Id'] = host2Id;
    data['host2UniqueId'] = host2UniqueId;
    data['host2Name'] = host2Name;
    data['host2userName'] = host2userName;
    data['host2Image'] = host2Image;
    data['host2isProfilePicBanned'] = host2IsProfilePicBanned;
    data['host2Channel'] = host2Channel;
    data['host2LiveId'] = host2LiveId;
    data['host2Token'] = host2Token;
    data['bgTheme'] = bgTheme;
    data['isFollow'] = isFollow;
    data['host2IsFollow'] = host2IsFollow;
    if (blockedUsers != null) data['blockedUsers'] = blockedUsers;
    data['localRank'] = localRank;
    data['localGiftCount'] = localGiftCount;
    data['remoteRank'] = remoteRank;
    data['remoteGiftCount'] = remoteGiftCount;
    data['host2Coin'] = host2Coin;
    data['host2wealthLevelImage'] = host2wealthLevelImage;
    data['uniqueId'] = uniqueId;
    data['coin'] = coin;
    data['wealthLevelImage'] = wealthLevelImage;
    data['themeId'] = themeId; // New parameter in toJson
    data['theme'] = theme; // New parameter in toJson
    if (viewers != null) {
      data['viewers'] = viewers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Viewer {
  String? image;
  bool? isProfilePicBanned;

  Viewer({this.image, this.isProfilePicBanned});

  Viewer.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    isProfilePicBanned = json['isProfilePicBanned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['isProfilePicBanned'] = isProfilePicBanned;
    return data;
  }
}

class Seat {
  String? id;
  int? position;
  int? mute;
  bool? lock;
  bool? reserved;
  bool? speaking;
  bool? invite;
  bool? isProfilePicBanned;
  String? userId;
  String? name;
  String? image;
  String? avtarFrame;
  int? agoraUid;
  int? coin;
  int? avtarFrameType;

  Seat({
    this.id,
    this.position,
    this.mute,
    this.lock,
    this.reserved,
    this.speaking,
    this.invite,
    this.isProfilePicBanned,
    this.userId,
    this.name,
    this.image,
    this.avtarFrame,
    this.agoraUid,
    this.coin,
    this.avtarFrameType,
  });

  Seat.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    position = json['position'];
    mute = json['mute'];
    lock = json['lock'];
    reserved = json['reserved'];
    speaking = json['speaking'];
    invite = json['invite'];
    isProfilePicBanned = json['isProfilePicBanned'];
    userId = json['userId'];
    name = json['name'];
    image = json['image'];
    avtarFrame = json['avtarFrame'];
    agoraUid = json['agoraUid'];
    coin = json['coin'];
    avtarFrameType = json['avtarFrameType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['position'] = position;
    data['mute'] = mute;
    data['lock'] = lock;
    data['reserved'] = reserved;
    data['speaking'] = speaking;
    data['invite'] = invite;
    data['isProfilePicBanned'] = isProfilePicBanned;
    data['userId'] = userId;
    data['name'] = name;
    data['image'] = image;
    data['avtarFrame'] = avtarFrame;
    data['agoraUid'] = agoraUid;
    data['coin'] = coin;
    data['avtarFrameType'] = avtarFrameType;
    return data;
  }
}

class MultiLiveUsersModel {
  String? userId;
  String? name;
  String? userName;
  String? image;
  String? country;
  bool? isVerified;
  int? agoraUid;
  bool? isMute;
  bool? isRequested;
  bool? isAccepted;
  bool? isInvited;

  MultiLiveUsersModel({
    this.userId,
    this.name,
    this.userName,
    this.image,
    this.country,
    this.isVerified,
    this.agoraUid,
    this.isMute,
    this.isRequested,
    this.isAccepted,
    this.isInvited,
  });

  MultiLiveUsersModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    userName = json['userName'];
    image = json['image'];
    country = json['country'];
    isVerified = json['isVerified'];
    agoraUid = json['agoraUid'];
    isMute = json['isMute'];
    isRequested = json['isRequested'];
    isAccepted = json['isAccepted'];
    isInvited = json['isInvited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['userName'] = userName;
    data['image'] = image;
    data['country'] = country;
    data['isVerified'] = isVerified;
    data['agoraUid'] = agoraUid;
    data['isMute'] = isMute;
    data['isRequested'] = isRequested;
    data['isAccepted'] = isAccepted;
    data['isInvited'] = isInvited;
    return data;
  }
}
