class FetchUserWiseVideoModel {
  FetchUserWiseVideoModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchUserWiseVideoModel.fromJson(dynamic json) {
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
  FetchUserWiseVideoModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      FetchUserWiseVideoModel(
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
    String? caption,
    String? videoImage,
    String? videoUrl,
    bool? isBanned,
    String? createdAt,
    User? user,
    int? totalLikes,
    bool? isLikedByUser,
    int? totalComments,
    int? totalViews,
    List<String>? hashTag,
    dynamic song,
  }) {
    _id = id;
    _caption = caption;
    _videoImage = videoImage;
    _videoUrl = videoUrl;
    _isBanned = isBanned;
    _createdAt = createdAt;
    _user = user;
    _totalLikes = totalLikes;
    _isLikedByUser = isLikedByUser;
    _totalComments = totalComments;
    _totalViews = totalViews;
    _hashTag = hashTag;
    _song = song;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _caption = json['caption'];
    _videoImage = json['videoImage'];
    _videoUrl = json['videoUrl'];
    _isBanned = json['isBanned'];
    _createdAt = json['createdAt'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _totalLikes = json['totalLikes'];
    _isLikedByUser = json['isLikedByUser'];
    _totalComments = json['totalComments'];
    _totalViews = json['totalViews'];
    _hashTag = json['hashTag'] != null ? json['hashTag'].cast<String>() : [];
    _song = json['song'];
  }
  String? _id;
  String? _caption;
  String? _videoImage;
  String? _videoUrl;
  bool? _isBanned;
  String? _createdAt;
  User? _user;
  int? _totalLikes;
  bool? _isLikedByUser;
  int? _totalComments;
  int? _totalViews;
  List<String>? _hashTag;
  dynamic _song;
  Data copyWith({
    String? id,
    String? caption,
    String? videoImage,
    String? videoUrl,
    bool? isBanned,
    String? createdAt,
    User? user,
    int? totalLikes,
    bool? isLikedByUser,
    int? totalComments,
    int? totalViews,
    List<String>? hashTag,
    dynamic song,
  }) =>
      Data(
        id: id ?? _id,
        caption: caption ?? _caption,
        videoImage: videoImage ?? _videoImage,
        videoUrl: videoUrl ?? _videoUrl,
        isBanned: isBanned ?? _isBanned,
        createdAt: createdAt ?? _createdAt,
        user: user ?? _user,
        totalLikes: totalLikes ?? _totalLikes,
        isLikedByUser: isLikedByUser ?? _isLikedByUser,
        totalComments: totalComments ?? _totalComments,
        totalViews: totalViews ?? _totalViews,
        hashTag: hashTag ?? _hashTag,
        song: song ?? _song,
      );
  String? get id => _id;
  String? get caption => _caption;
  String? get videoImage => _videoImage;
  String? get videoUrl => _videoUrl;
  bool? get isBanned => _isBanned;
  String? get createdAt => _createdAt;
  User? get user => _user;
  int? get totalLikes => _totalLikes;
  bool? get isLikedByUser => _isLikedByUser;
  int? get totalComments => _totalComments;
  int? get totalViews => _totalViews;
  List<String>? get hashTag => _hashTag;
  dynamic get song => _song;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['caption'] = _caption;
    map['videoImage'] = _videoImage;
    map['videoUrl'] = _videoUrl;
    map['isBanned'] = _isBanned;
    map['createdAt'] = _createdAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['totalLikes'] = _totalLikes;
    map['isLikedByUser'] = _isLikedByUser;
    map['totalComments'] = _totalComments;
    map['totalViews'] = _totalViews;
    map['hashTag'] = _hashTag;
    map['song'] = _song;
    return map;
  }
}

class User {
  User({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    bool? isFake,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _isFake = isFake;
  }

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _isFake = json['isFake'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  bool? _isFake;
  User copyWith({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    bool? isFake,
  }) =>
      User(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        isFake: isFake ?? _isFake,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  bool? get isFake => _isFake;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['isFake'] = _isFake;
    return map;
  }
}
