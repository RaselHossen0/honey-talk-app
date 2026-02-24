class FetchPostModel {
  FetchPostModel({
    bool? status,
    String? message,
    List<Post>? post,
  }) {
    _status = status;
    _message = message;
    _post = post;
  }

  FetchPostModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['post'] != null) {
      _post = [];
      json['post'].forEach((v) {
        _post?.add(Post.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Post>? _post;
  FetchPostModel copyWith({
    bool? status,
    String? message,
    List<Post>? post,
  }) =>
      FetchPostModel(
        status: status ?? _status,
        message: message ?? _message,
        post: post ?? _post,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Post>? get post => _post;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_post != null) {
      map['post'] = _post?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Post {
  Post({
    String? id,
    String? caption,
    List<PostImage>? postImage,
    int? shareCount,
    bool? isFake,
    String? createdAt,
    String? postId,
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
    _caption = caption;
    _postImage = postImage;
    _shareCount = shareCount;
    _isFake = isFake;
    _createdAt = createdAt;
    _postId = postId;
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

  Post.fromJson(dynamic json) {
    _id = json['_id'];
    _caption = json['caption'];
    if (json['postImage'] != null) {
      _postImage = [];
      json['postImage'].forEach((v) {
        _postImage?.add(PostImage.fromJson(v));
      });
    }
    _shareCount = json['shareCount'];
    _isFake = json['isFake'];
    _createdAt = json['createdAt'];
    _postId = json['postId'];
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
  String? _caption;
  List<PostImage>? _postImage;
  int? _shareCount;
  bool? _isFake;
  String? _createdAt;
  String? _postId;
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
  Post copyWith({
    String? id,
    String? caption,
    List<PostImage>? postImage,
    int? shareCount,
    bool? isFake,
    String? createdAt,
    String? postId,
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
      Post(
        id: id ?? _id,
        caption: caption ?? _caption,
        postImage: postImage ?? _postImage,
        shareCount: shareCount ?? _shareCount,
        isFake: isFake ?? _isFake,
        createdAt: createdAt ?? _createdAt,
        postId: postId ?? _postId,
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
  String? get caption => _caption;
  List<PostImage>? get postImage => _postImage;
  int? get shareCount => _shareCount;
  bool? get isFake => _isFake;
  String? get createdAt => _createdAt;
  String? get postId => _postId;
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
    map['caption'] = _caption;
    if (_postImage != null) {
      map['postImage'] = _postImage?.map((v) => v.toJson()).toList();
    }
    map['shareCount'] = _shareCount;
    map['isFake'] = _isFake;
    map['createdAt'] = _createdAt;
    map['postId'] = _postId;
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

class PostImage {
  PostImage({
    String? url,
    bool? isBanned,
    String? id,
  }) {
    _url = url;
    _isBanned = isBanned;
    _id = id;
  }

  PostImage.fromJson(dynamic json) {
    _url = json['url'];
    _isBanned = json['isBanned'];
    _id = json['_id'];
  }
  String? _url;
  bool? _isBanned;
  String? _id;
  PostImage copyWith({
    String? url,
    bool? isBanned,
    String? id,
  }) =>
      PostImage(
        url: url ?? _url,
        isBanned: isBanned ?? _isBanned,
        id: id ?? _id,
      );
  String? get url => _url;
  bool? get isBanned => _isBanned;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['isBanned'] = _isBanned;
    map['_id'] = _id;
    return map;
  }
}
