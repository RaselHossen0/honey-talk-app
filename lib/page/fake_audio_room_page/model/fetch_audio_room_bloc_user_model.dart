class FetchAudioRoomBlocUserModel {
  FetchAudioRoomBlocUserModel({
    bool? status,
    String? message,
    List<BlockedUsers>? blockedUsers,
  }) {
    _status = status;
    _message = message;
    _blockedUsers = blockedUsers;
  }

  FetchAudioRoomBlocUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['blockedUsers'] != null) {
      _blockedUsers = [];
      json['blockedUsers'].forEach((v) {
        _blockedUsers?.add(BlockedUsers.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<BlockedUsers>? _blockedUsers;
  FetchAudioRoomBlocUserModel copyWith({
    bool? status,
    String? message,
    List<BlockedUsers>? blockedUsers,
  }) =>
      FetchAudioRoomBlocUserModel(
        status: status ?? _status,
        message: message ?? _message,
        blockedUsers: blockedUsers ?? _blockedUsers,
      );
  bool? get status => _status;
  String? get message => _message;
  List<BlockedUsers>? get blockedUsers => _blockedUsers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_blockedUsers != null) {
      map['blockedUsers'] = _blockedUsers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class BlockedUsers {
  BlockedUsers({
    BlockedUserId? blockedUserId,
    String? id,
  }) {
    _blockedUserId = blockedUserId;
    _id = id;
  }

  BlockedUsers.fromJson(dynamic json) {
    _blockedUserId = json['blockedUserId'] != null ? BlockedUserId.fromJson(json['blockedUserId']) : null;
    _id = json['_id'];
  }
  BlockedUserId? _blockedUserId;
  String? _id;
  BlockedUsers copyWith({
    BlockedUserId? blockedUserId,
    String? id,
  }) =>
      BlockedUsers(
        blockedUserId: blockedUserId ?? _blockedUserId,
        id: id ?? _id,
      );
  BlockedUserId? get blockedUserId => _blockedUserId;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_blockedUserId != null) {
      map['blockedUserId'] = _blockedUserId?.toJson();
    }
    map['_id'] = _id;
    return map;
  }
}

class BlockedUserId {
  BlockedUserId({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? uniqueId,
    bool? isVerified,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _uniqueId = uniqueId;
    _isVerified = isVerified;
  }

  BlockedUserId.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _uniqueId = json['uniqueId'];
    _isVerified = json['isVerified'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  String? _uniqueId;
  bool? _isVerified;
  BlockedUserId copyWith({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? uniqueId,
    bool? isVerified,
  }) =>
      BlockedUserId(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        uniqueId: uniqueId ?? _uniqueId,
        isVerified: isVerified ?? _isVerified,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  String? get uniqueId => _uniqueId;
  bool? get isVerified => _isVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['uniqueId'] = _uniqueId;
    map['isVerified'] = _isVerified;
    return map;
  }
}
