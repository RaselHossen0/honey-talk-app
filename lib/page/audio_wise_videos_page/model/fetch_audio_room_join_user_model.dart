class FetchAudioRoomJoinUserModel {
  FetchAudioRoomJoinUserModel({
    bool? status,
    String? message,
    List<ViewerList>? viewerList,
  }) {
    _status = status;
    _message = message;
    _viewerList = viewerList;
  }

  FetchAudioRoomJoinUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['viewerList'] != null) {
      _viewerList = [];
      json['viewerList'].forEach((v) {
        _viewerList?.add(ViewerList.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ViewerList>? _viewerList;
  FetchAudioRoomJoinUserModel copyWith({
    bool? status,
    String? message,
    List<ViewerList>? viewerList,
  }) =>
      FetchAudioRoomJoinUserModel(
        status: status ?? _status,
        message: message ?? _message,
        viewerList: viewerList ?? _viewerList,
      );
  bool? get status => _status;
  String? get message => _message;
  List<ViewerList>? get viewerList => _viewerList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_viewerList != null) {
      map['viewerList'] = _viewerList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ViewerList {
  ViewerList({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? gender,
    String? countryFlagImage,
    String? country,
    String? uniqueId,
    bool? isVerified,
    String? userId,
    String? liveHistoryId,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _gender = gender;
    _countryFlagImage = countryFlagImage;
    _country = country;
    _uniqueId = uniqueId;
    _isVerified = isVerified;
    _userId = userId;
    _liveHistoryId = liveHistoryId;
  }

  ViewerList.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _gender = json['gender'];
    _countryFlagImage = json['countryFlagImage'];
    _country = json['country'];
    _uniqueId = json['uniqueId'];
    _isVerified = json['isVerified'];
    _userId = json['userId'];
    _liveHistoryId = json['liveHistoryId'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  String? _gender;
  String? _countryFlagImage;
  String? _country;
  String? _uniqueId;
  bool? _isVerified;
  String? _userId;
  String? _liveHistoryId;
  ViewerList copyWith({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? gender,
    String? countryFlagImage,
    String? country,
    String? uniqueId,
    bool? isVerified,
    String? userId,
    String? liveHistoryId,
  }) =>
      ViewerList(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        gender: gender ?? _gender,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        country: country ?? _country,
        uniqueId: uniqueId ?? _uniqueId,
        isVerified: isVerified ?? _isVerified,
        userId: userId ?? _userId,
        liveHistoryId: liveHistoryId ?? _liveHistoryId,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  String? get gender => _gender;
  String? get countryFlagImage => _countryFlagImage;
  String? get country => _country;
  String? get uniqueId => _uniqueId;
  bool? get isVerified => _isVerified;
  String? get userId => _userId;
  String? get liveHistoryId => _liveHistoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['gender'] = _gender;
    map['countryFlagImage'] = _countryFlagImage;
    map['country'] = _country;
    map['uniqueId'] = _uniqueId;
    map['isVerified'] = _isVerified;
    map['userId'] = _userId;
    map['liveHistoryId'] = _liveHistoryId;
    return map;
  }
}
