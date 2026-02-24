class FetchUserProfileModel {
  FetchUserProfileModel({
    bool? status,
    String? message,
    User? user,
  }) {
    _status = status;
    _message = message;
    _user = user;
  }

  FetchUserProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? _status;
  String? _message;
  User? _user;
  FetchUserProfileModel copyWith({
    bool? status,
    String? message,
    User? user,
  }) =>
      FetchUserProfileModel(
        status: status ?? _status,
        message: message ?? _message,
        user: user ?? _user,
      );
  bool? get status => _status;
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    String? id,
    String? name,
    String? userName,
    String? gender,
    int? age,
    String? image,
    bool? isProfilePicBanned,
    String? countryFlagImage,
    String? country,
    String? uniqueId,
    int? coin,
    int? receivedGifts,
    WealthLevel? wealthLevel,
    ActiveAvtarFrame? activeAvtarFrame,
    bool? isVerified,
    int? totalFollowers,
    int? totalFollowing,
    int? totalFriends,
    int? totalVisitors,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _gender = gender;
    _age = age;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _countryFlagImage = countryFlagImage;
    _country = country;
    _uniqueId = uniqueId;
    _coin = coin;
    _receivedGifts = receivedGifts;
    _wealthLevel = wealthLevel;
    _activeAvtarFrame = activeAvtarFrame;
    _isVerified = isVerified;
    _totalFollowers = totalFollowers;
    _totalFollowing = totalFollowing;
    _totalFriends = totalFriends;
    _totalVisitors = totalVisitors;
  }

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _gender = json['gender'];
    _age = json['age'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _countryFlagImage = json['countryFlagImage'];
    _country = json['country'];
    _uniqueId = json['uniqueId'];
    _coin = json['coin'];
    _receivedGifts = json['receivedGifts'];
    _wealthLevel = json['wealthLevel'] != null ? WealthLevel.fromJson(json['wealthLevel']) : null;
    _activeAvtarFrame = json['activeAvtarFrame'] != null ? ActiveAvtarFrame.fromJson(json['activeAvtarFrame']) : null;
    _isVerified = json['isVerified'];
    _totalFollowers = json['totalFollowers'];
    _totalFollowing = json['totalFollowing'];
    _totalFriends = json['totalFriends'];
    _totalVisitors = json['totalVisitors'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _gender;
  int? _age;
  String? _image;
  bool? _isProfilePicBanned;
  String? _countryFlagImage;
  String? _country;
  String? _uniqueId;
  int? _coin;
  int? _receivedGifts;
  WealthLevel? _wealthLevel;
  ActiveAvtarFrame? _activeAvtarFrame;
  bool? _isVerified;
  int? _totalFollowers;
  int? _totalFollowing;
  int? _totalFriends;
  int? _totalVisitors;
  User copyWith({
    String? id,
    String? name,
    String? userName,
    String? gender,
    int? age,
    String? image,
    bool? isProfilePicBanned,
    String? countryFlagImage,
    String? country,
    String? uniqueId,
    int? coin,
    int? receivedGifts,
    WealthLevel? wealthLevel,
    ActiveAvtarFrame? activeAvtarFrame,
    bool? isVerified,
    int? totalFollowers,
    int? totalFollowing,
    int? totalFriends,
    int? totalVisitors,
  }) =>
      User(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        gender: gender ?? _gender,
        age: age ?? _age,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        country: country ?? _country,
        uniqueId: uniqueId ?? _uniqueId,
        coin: coin ?? _coin,
        receivedGifts: receivedGifts ?? _receivedGifts,
        wealthLevel: wealthLevel ?? _wealthLevel,
        activeAvtarFrame: activeAvtarFrame ?? _activeAvtarFrame,
        isVerified: isVerified ?? _isVerified,
        totalFollowers: totalFollowers ?? _totalFollowers,
        totalFollowing: totalFollowing ?? _totalFollowing,
        totalFriends: totalFriends ?? _totalFriends,
        totalVisitors: totalVisitors ?? _totalVisitors,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get gender => _gender;
  int? get age => _age;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  String? get countryFlagImage => _countryFlagImage;
  String? get country => _country;
  String? get uniqueId => _uniqueId;
  int? get coin => _coin;
  int? get receivedGifts => _receivedGifts;
  WealthLevel? get wealthLevel => _wealthLevel;
  ActiveAvtarFrame? get activeAvtarFrame => _activeAvtarFrame;
  bool? get isVerified => _isVerified;
  int? get totalFollowers => _totalFollowers;
  int? get totalFollowing => _totalFollowing;
  int? get totalFriends => _totalFriends;
  int? get totalVisitors => _totalVisitors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['gender'] = _gender;
    map['age'] = _age;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['countryFlagImage'] = _countryFlagImage;
    map['country'] = _country;
    map['uniqueId'] = _uniqueId;
    map['coin'] = _coin;
    map['receivedGifts'] = _receivedGifts;
    if (_wealthLevel != null) {
      map['wealthLevel'] = _wealthLevel?.toJson();
    }
    if (_activeAvtarFrame != null) {
      map['activeAvtarFrame'] = _activeAvtarFrame?.toJson();
    }
    map['isVerified'] = _isVerified;
    map['totalFollowers'] = _totalFollowers;
    map['totalFollowing'] = _totalFollowing;
    map['totalFriends'] = _totalFriends;
    map['totalVisitors'] = _totalVisitors;
    return map;
  }
}

class ActiveAvtarFrame {
  ActiveAvtarFrame({
    String? id,
    int? type,
    String? image,
  }) {
    _id = id;
    _type = type;
    _image = image;
  }

  ActiveAvtarFrame.fromJson(dynamic json) {
    _id = json['_id'];
    _type = json['type'];
    _image = json['image'];
  }
  String? _id;
  int? _type;
  String? _image;
  ActiveAvtarFrame copyWith({
    String? id,
    int? type,
    String? image,
  }) =>
      ActiveAvtarFrame(
        id: id ?? _id,
        type: type ?? _type,
        image: image ?? _image,
      );
  String? get id => _id;
  int? get type => _type;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['type'] = _type;
    map['image'] = _image;
    return map;
  }
}

class WealthLevel {
  WealthLevel({
    String? id,
    String? levelImage,
  }) {
    _id = id;
    _levelImage = levelImage;
  }

  WealthLevel.fromJson(dynamic json) {
    _id = json['_id'];
    _levelImage = json['levelImage'];
  }
  String? _id;
  String? _levelImage;
  WealthLevel copyWith({
    String? id,
    String? levelImage,
  }) =>
      WealthLevel(
        id: id ?? _id,
        levelImage: levelImage ?? _levelImage,
      );
  String? get id => _id;
  String? get levelImage => _levelImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['levelImage'] = _levelImage;
    return map;
  }
}
