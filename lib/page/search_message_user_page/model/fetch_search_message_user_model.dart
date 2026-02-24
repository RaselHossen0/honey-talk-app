class FetchSearchMessageUserModel {
  FetchSearchMessageUserModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchSearchMessageUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
  FetchSearchMessageUserModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      FetchSearchMessageUserModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    bool? isFake,
    bool? isVerified,
    bool? isOnline,
    String? chatTopicId,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _isFake = isFake;
    _isVerified = isVerified;
    _isOnline = isOnline;
    _chatTopicId = chatTopicId;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _isFake = json['isFake'];
    _isVerified = json['isVerified'];
    _isOnline = json['isOnline'];
    _chatTopicId = json['chatTopicId'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  bool? _isFake;
  bool? _isVerified;
  bool? _isOnline;
  String? _chatTopicId;
  Data copyWith({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    bool? isFake,
    bool? isVerified,
    bool? isOnline,
    String? chatTopicId,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        isFake: isFake ?? _isFake,
        isVerified: isVerified ?? _isVerified,
        isOnline: isOnline ?? _isOnline,
        chatTopicId: chatTopicId ?? _chatTopicId,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  bool? get isFake => _isFake;
  bool? get isVerified => _isVerified;
  bool? get isOnline => _isOnline;
  String? get chatTopicId => _chatTopicId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['isFake'] = _isFake;
    map['isVerified'] = _isVerified;
    map['isOnline'] = _isOnline;
    map['chatTopicId'] = _chatTopicId;
    return map;
  }
}
