class FetchVideoModel {
  FetchVideoModel({
    bool? status,
    String? message,
    List<VideoData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchVideoModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(VideoData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<VideoData>? _data;
  FetchVideoModel copyWith({
    bool? status,
    String? message,
    List<VideoData>? data,
  }) =>
      FetchVideoModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<VideoData>? get data => _data;

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

class VideoData {
  VideoData({
    String? id,
    dynamic songId,
    String? caption,
    int? videoTime,
    String? videoImage,
    String? videoUrl,
    int? shareCount,
    bool? isFake,
    bool? isBanned,
    String? createdAt,
    String? songTitle,
    String? songImage,
    String? songLink,
    String? singerName,
    List<String>? hashTagId,
    List<String>? hashTag,
    String? userId,
    String? name,
    String? userName,
    String? gender,
    int? age,
    String? country,
    String? countryFlagImage,
    String? userImage,
    bool? isProfilePicBanned,
    bool? isVerified,
    bool? userIsFake,
    bool? isLike,
    bool? isFollow,
    int? totalLikes,
    int? totalComments,
    String? time,
  }) {
    _id = id;
    _songId = songId;
    _caption = caption;
    _videoTime = videoTime;
    _videoImage = videoImage;
    _videoUrl = videoUrl;
    _shareCount = shareCount;
    _isFake = isFake;
    _isBanned = isBanned;
    _createdAt = createdAt;
    _songTitle = songTitle;
    _songImage = songImage;
    _songLink = songLink;
    _singerName = singerName;
    _hashTagId = hashTagId;
    _hashTag = hashTag;
    _userId = userId;
    _name = name;
    _userName = userName;
    _gender = gender;
    _age = age;
    _country = country;
    _countryFlagImage = countryFlagImage;
    _userImage = userImage;
    _isProfilePicBanned = isProfilePicBanned;
    _isVerified = isVerified;
    _userIsFake = userIsFake;
    _isLike = isLike;
    _isFollow = isFollow;
    _totalLikes = totalLikes;
    _totalComments = totalComments;
    _time = time;
  }

  VideoData.fromJson(dynamic json) {
    _id = json['_id'];
    _songId = json['songId'];
    _caption = json['caption'];
    _videoTime = json['videoTime'];
    _videoImage = json['videoImage'];
    _videoUrl = json['videoUrl'];
    _shareCount = json['shareCount'];
    _isFake = json['isFake'];
    _isBanned = json['isBanned'];
    _createdAt = json['createdAt'];
    _songTitle = json['songTitle'];
    _songImage = json['songImage'];
    _songLink = json['songLink'];
    _singerName = json['singerName'];
    _hashTagId = json['hashTagId'] != null ? json['hashTagId'].cast<String>() : [];
    _hashTag = json['hashTag'] != null ? json['hashTag'].cast<String>() : [];
    _userId = json['userId'];
    _name = json['name'];
    _userName = json['userName'];
    _gender = json['gender'];
    _age = json['age'];
    _country = json['country'];
    _countryFlagImage = json['countryFlagImage'];
    _userImage = json['userImage'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _isVerified = json['isVerified'];
    _userIsFake = json['userIsFake'];
    _isLike = json['isLike'];
    _isFollow = json['isFollow'];
    _totalLikes = json['totalLikes'];
    _totalComments = json['totalComments'];
    _time = json['time'];
  }
  String? _id;
  dynamic _songId;
  String? _caption;
  int? _videoTime;
  String? _videoImage;
  String? _videoUrl;
  int? _shareCount;
  bool? _isFake;
  bool? _isBanned;
  String? _createdAt;
  String? _songTitle;
  String? _songImage;
  String? _songLink;
  String? _singerName;
  List<String>? _hashTagId;
  List<String>? _hashTag;
  String? _userId;
  String? _name;
  String? _userName;
  String? _gender;
  int? _age;
  String? _country;
  String? _countryFlagImage;
  String? _userImage;
  bool? _isProfilePicBanned;
  bool? _isVerified;
  bool? _userIsFake;
  bool? _isLike;
  bool? _isFollow;
  int? _totalLikes;
  int? _totalComments;
  String? _time;
  VideoData copyWith({
    String? id,
    dynamic songId,
    String? caption,
    int? videoTime,
    String? videoImage,
    String? videoUrl,
    int? shareCount,
    bool? isFake,
    bool? isBanned,
    String? createdAt,
    String? songTitle,
    String? songImage,
    String? songLink,
    String? singerName,
    List<String>? hashTagId,
    List<String>? hashTag,
    String? userId,
    String? name,
    String? userName,
    String? gender,
    int? age,
    String? country,
    String? countryFlagImage,
    String? userImage,
    bool? isProfilePicBanned,
    bool? isVerified,
    bool? userIsFake,
    bool? isLike,
    bool? isFollow,
    int? totalLikes,
    int? totalComments,
    String? time,
  }) =>
      VideoData(
        id: id ?? _id,
        songId: songId ?? _songId,
        caption: caption ?? _caption,
        videoTime: videoTime ?? _videoTime,
        videoImage: videoImage ?? _videoImage,
        videoUrl: videoUrl ?? _videoUrl,
        shareCount: shareCount ?? _shareCount,
        isFake: isFake ?? _isFake,
        isBanned: isBanned ?? _isBanned,
        createdAt: createdAt ?? _createdAt,
        songTitle: songTitle ?? _songTitle,
        songImage: songImage ?? _songImage,
        songLink: songLink ?? _songLink,
        singerName: singerName ?? _singerName,
        hashTagId: hashTagId ?? _hashTagId,
        hashTag: hashTag ?? _hashTag,
        userId: userId ?? _userId,
        name: name ?? _name,
        userName: userName ?? _userName,
        gender: gender ?? _gender,
        age: age ?? _age,
        country: country ?? _country,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        userImage: userImage ?? _userImage,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        isVerified: isVerified ?? _isVerified,
        userIsFake: userIsFake ?? _userIsFake,
        isLike: isLike ?? _isLike,
        isFollow: isFollow ?? _isFollow,
        totalLikes: totalLikes ?? _totalLikes,
        totalComments: totalComments ?? _totalComments,
        time: time ?? _time,
      );
  String? get id => _id;
  dynamic get songId => _songId;
  String? get caption => _caption;
  int? get videoTime => _videoTime;
  String? get videoImage => _videoImage;
  String? get videoUrl => _videoUrl;
  int? get shareCount => _shareCount;
  bool? get isFake => _isFake;
  bool? get isBanned => _isBanned;
  String? get createdAt => _createdAt;
  String? get songTitle => _songTitle;
  String? get songImage => _songImage;
  String? get songLink => _songLink;
  String? get singerName => _singerName;
  List<String>? get hashTagId => _hashTagId;
  List<String>? get hashTag => _hashTag;
  String? get userId => _userId;
  String? get name => _name;
  String? get userName => _userName;
  String? get gender => _gender;
  int? get age => _age;
  String? get country => _country;
  String? get countryFlagImage => _countryFlagImage;
  String? get userImage => _userImage;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  bool? get isVerified => _isVerified;
  bool? get userIsFake => _userIsFake;
  bool? get isLike => _isLike;
  bool? get isFollow => _isFollow;
  int? get totalLikes => _totalLikes;
  int? get totalComments => _totalComments;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['songId'] = _songId;
    map['caption'] = _caption;
    map['videoTime'] = _videoTime;
    map['videoImage'] = _videoImage;
    map['videoUrl'] = _videoUrl;
    map['shareCount'] = _shareCount;
    map['isFake'] = _isFake;
    map['isBanned'] = _isBanned;
    map['createdAt'] = _createdAt;
    map['songTitle'] = _songTitle;
    map['songImage'] = _songImage;
    map['songLink'] = _songLink;
    map['singerName'] = _singerName;
    map['hashTagId'] = _hashTagId;
    map['hashTag'] = _hashTag;
    map['userId'] = _userId;
    map['name'] = _name;
    map['userName'] = _userName;
    map['gender'] = _gender;
    map['age'] = _age;
    map['country'] = _country;
    map['countryFlagImage'] = _countryFlagImage;
    map['userImage'] = _userImage;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['isVerified'] = _isVerified;
    map['userIsFake'] = _userIsFake;
    map['isLike'] = _isLike;
    map['isFollow'] = _isFollow;
    map['totalLikes'] = _totalLikes;
    map['totalComments'] = _totalComments;
    map['time'] = _time;
    return map;
  }
}
