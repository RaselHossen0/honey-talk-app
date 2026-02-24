class FetchFakeAvailableLiveUserForPkModel {
  FetchFakeAvailableLiveUserForPkModel({
    bool? status,
    String? message,
    List<LiveUserList>? liveUserList,
  }) {
    _status = status;
    _message = message;
    _liveUserList = liveUserList;
  }

  FetchFakeAvailableLiveUserForPkModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['liveUserList'] != null) {
      _liveUserList = [];
      json['liveUserList'].forEach((v) {
        _liveUserList?.add(LiveUserList.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<LiveUserList>? _liveUserList;
  FetchFakeAvailableLiveUserForPkModel copyWith({
    bool? status,
    String? message,
    List<LiveUserList>? liveUserList,
  }) =>
      FetchFakeAvailableLiveUserForPkModel(
        status: status ?? _status,
        message: message ?? _message,
        liveUserList: liveUserList ?? _liveUserList,
      );
  bool? get status => _status;
  String? get message => _message;
  List<LiveUserList>? get liveUserList => _liveUserList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_liveUserList != null) {
      map['liveUserList'] = _liveUserList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class LiveUserList {
  LiveUserList({
    String? id,
    String? userId,
    String? liveHistoryId,
    String? channel,
    String? token,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? countryFlagImage,
    String? country,
    bool? isVerified,
  }) {
    _id = id;
    _userId = userId;
    _liveHistoryId = liveHistoryId;
    _channel = channel;
    _token = token;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _countryFlagImage = countryFlagImage;
    _country = country;
    _isVerified = isVerified;
  }

  LiveUserList.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _liveHistoryId = json['liveHistoryId'];
    _channel = json['channel'];
    _token = json['token'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _countryFlagImage = json['countryFlagImage'];
    _country = json['country'];
    _isVerified = json['isVerified'];
  }
  String? _id;
  String? _userId;
  String? _liveHistoryId;
  String? _channel;
  String? _token;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  String? _countryFlagImage;
  String? _country;
  bool? _isVerified;
  LiveUserList copyWith({
    String? id,
    String? userId,
    String? liveHistoryId,
    String? channel,
    String? token,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? countryFlagImage,
    String? country,
    bool? isVerified,
  }) =>
      LiveUserList(
        id: id ?? _id,
        userId: userId ?? _userId,
        liveHistoryId: liveHistoryId ?? _liveHistoryId,
        channel: channel ?? _channel,
        token: token ?? _token,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        country: country ?? _country,
        isVerified: isVerified ?? _isVerified,
      );
  String? get id => _id;
  String? get userId => _userId;
  String? get liveHistoryId => _liveHistoryId;
  String? get channel => _channel;
  String? get token => _token;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  String? get countryFlagImage => _countryFlagImage;
  String? get country => _country;
  bool? get isVerified => _isVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    map['liveHistoryId'] = _liveHistoryId;
    map['channel'] = _channel;
    map['token'] = _token;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['countryFlagImage'] = _countryFlagImage;
    map['country'] = _country;
    map['isVerified'] = _isVerified;
    return map;
  }
}
