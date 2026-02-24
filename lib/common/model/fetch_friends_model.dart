class FetchFriendsModel {
  FetchFriendsModel({
    bool? success,
    String? message,
    List<Friends>? friends,
  }) {
    _success = success;
    _message = message;
    _friends = friends;
  }

  FetchFriendsModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['friends'] != null) {
      _friends = [];
      json['friends'].forEach((v) {
        _friends?.add(Friends.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Friends>? _friends;
  FetchFriendsModel copyWith({
    bool? success,
    String? message,
    List<Friends>? friends,
  }) =>
      FetchFriendsModel(
        success: success ?? _success,
        message: message ?? _message,
        friends: friends ?? _friends,
      );
  bool? get success => _success;
  String? get message => _message;
  List<Friends>? get friends => _friends;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_friends != null) {
      map['friends'] = _friends?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Friends {
  Friends({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    bool? isVerified,
    int? age,
    String? uniqueId,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _isVerified = isVerified;
    _age = age;
    _uniqueId = uniqueId;
  }

  Friends.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _isVerified = json['isVerified'];
    _age = json['age'];
    _uniqueId = json['uniqueId'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  bool? _isVerified;
  int? _age;
  String? _uniqueId;
  Friends copyWith({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    bool? isVerified,
    int? age,
    String? uniqueId,
  }) =>
      Friends(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        isVerified: isVerified ?? _isVerified,
        age: age ?? _age,
        uniqueId: uniqueId ?? _uniqueId,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  bool? get isVerified => _isVerified;
  int? get age => _age;
  String? get uniqueId => _uniqueId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['isVerified'] = _isVerified;
    map['age'] = _age;
    map['uniqueId'] = _uniqueId;
    return map;
  }
}
