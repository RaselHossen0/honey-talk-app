class FetchConnectionCommonModel {
  FetchConnectionCommonModel({
    bool? status,
    String? message,
    List<ConnectionData>? friends,
    List<ConnectionData>? following,
    List<ConnectionData>? followers,
  }) {
    _status = status;
    _message = message;
    _friends = friends;
    _following = following;
    _followers = followers;
  }

  FetchConnectionCommonModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['friends'] != null) {
      _friends = [];
      json['friends'].forEach((v) {
        _friends?.add(ConnectionData.fromJson(v));
      });
    }
    if (json['following'] != null) {
      _following = [];
      json['following'].forEach((v) {
        _following?.add(ConnectionData.fromJson(v));
      });
    }
    if (json['followers'] != null) {
      _followers = [];
      json['followers'].forEach((v) {
        _followers?.add(ConnectionData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ConnectionData>? _friends;
  List<ConnectionData>? _following;
  List<ConnectionData>? _followers;
  FetchConnectionCommonModel copyWith({
    bool? status,
    String? message,
    List<ConnectionData>? friends,
    List<ConnectionData>? following,
    List<ConnectionData>? followers,
  }) =>
      FetchConnectionCommonModel(
        status: status ?? _status,
        message: message ?? _message,
        friends: friends ?? _friends,
        following: following ?? _following,
        followers: followers ?? _followers,
      );
  bool? get status => _status;
  String? get message => _message;
  List<ConnectionData>? get friends => _friends;
  List<ConnectionData>? get following => _following;
  List<ConnectionData>? get followers => _followers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_friends != null) {
      map['friends'] = _friends?.map((v) => v.toJson()).toList();
    }
    if (_following != null) {
      map['following'] = _following?.map((v) => v.toJson()).toList();
    }
    if (_followers != null) {
      map['followers'] = _followers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ConnectionData {
  ConnectionData({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    int? age,
    bool? isVerified,
    String? country,
    String? countryFlagImage,
    int? coin,
    String? uniqueId,
    bool? isOnline,
    String? date,
    String? wealthLevelImage,
    String? avtarFrame,
    int? avtarFrameType,
    bool? isFollow,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _age = age;
    _isVerified = isVerified;
    _country = country;
    _countryFlagImage = countryFlagImage;
    _coin = coin;
    _uniqueId = uniqueId;
    _isOnline = isOnline;
    _date = date;
    _wealthLevelImage = wealthLevelImage;
    _avtarFrame = avtarFrame;
    _avtarFrameType = avtarFrameType;
    _isFollow = isFollow;
  }

  ConnectionData.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _age = json['age'];
    _isVerified = json['isVerified'];
    _country = json['country'];
    _countryFlagImage = json['countryFlagImage'];
    _coin = json['coin'];
    _uniqueId = json['uniqueId'];
    _isOnline = json['isOnline'];
    _date = json['date'];
    _wealthLevelImage = json['wealthLevelImage'];
    _avtarFrame = json['avtarFrame'];
    _avtarFrameType = json['avtarFrameType'];
    _isFollow = json['isFollow'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  int? _age;
  bool? _isVerified;
  String? _country;
  String? _countryFlagImage;
  int? _coin;
  String? _uniqueId;
  bool? _isOnline;
  String? _date;
  String? _wealthLevelImage;
  String? _avtarFrame;
  int? _avtarFrameType;
  bool? _isFollow;
  ConnectionData copyWith({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    int? age,
    bool? isVerified,
    String? country,
    String? countryFlagImage,
    int? coin,
    String? uniqueId,
    bool? isOnline,
    String? date,
    String? wealthLevelImage,
    String? avtarFrame,
    int? avtarFrameType,
    bool? isFollow,
  }) =>
      ConnectionData(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        age: age ?? _age,
        isVerified: isVerified ?? _isVerified,
        country: country ?? _country,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        coin: coin ?? _coin,
        uniqueId: uniqueId ?? _uniqueId,
        isOnline: isOnline ?? _isOnline,
        date: date ?? _date,
        wealthLevelImage: wealthLevelImage ?? _wealthLevelImage,
        avtarFrame: avtarFrame ?? _avtarFrame,
        avtarFrameType: avtarFrameType ?? _avtarFrameType,
        isFollow: isFollow ?? _isFollow,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  int? get age => _age;
  bool? get isVerified => _isVerified;
  String? get country => _country;
  String? get countryFlagImage => _countryFlagImage;
  int? get coin => _coin;
  String? get uniqueId => _uniqueId;
  bool? get isOnline => _isOnline;
  String? get date => _date;
  String? get wealthLevelImage => _wealthLevelImage;
  String? get avtarFrame => _avtarFrame;
  int? get avtarFrameType => _avtarFrameType;
  bool? get isFollow => _isFollow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['age'] = _age;
    map['isVerified'] = _isVerified;
    map['country'] = _country;
    map['countryFlagImage'] = _countryFlagImage;
    map['coin'] = _coin;
    map['uniqueId'] = _uniqueId;
    map['isOnline'] = _isOnline;
    map['date'] = _date;
    map['wealthLevelImage'] = _wealthLevelImage;
    map['avtarFrame'] = _avtarFrame;
    map['avtarFrameType'] = _avtarFrameType;
    map['isFollow'] = _isFollow;
    return map;
  }
}
