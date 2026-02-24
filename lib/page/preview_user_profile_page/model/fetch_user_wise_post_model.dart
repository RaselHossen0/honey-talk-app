class FetchUserWisePostModel {
  FetchUserWisePostModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchUserWisePostModel.fromJson(dynamic json) {
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
  FetchUserWisePostModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      FetchUserWisePostModel(
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
    String? mainPostImage,
    List<PostImage>? postImage,
    String? createdAt,
  }) {
    _id = id;
    _caption = caption;
    _mainPostImage = mainPostImage;
    _postImage = postImage;
    _createdAt = createdAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _caption = json['caption'];
    _mainPostImage = json['mainPostImage'];
    if (json['postImage'] != null) {
      _postImage = [];
      json['postImage'].forEach((v) {
        _postImage?.add(PostImage.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
  }
  String? _id;
  String? _caption;
  String? _mainPostImage;
  List<PostImage>? _postImage;
  String? _createdAt;
  Data copyWith({
    String? id,
    String? caption,
    String? mainPostImage,
    List<PostImage>? postImage,
    String? createdAt,
  }) =>
      Data(
        id: id ?? _id,
        caption: caption ?? _caption,
        mainPostImage: mainPostImage ?? _mainPostImage,
        postImage: postImage ?? _postImage,
        createdAt: createdAt ?? _createdAt,
      );
  String? get id => _id;
  String? get caption => _caption;
  String? get mainPostImage => _mainPostImage;
  List<PostImage>? get postImage => _postImage;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['caption'] = _caption;
    map['mainPostImage'] = _mainPostImage;
    if (_postImage != null) {
      map['postImage'] = _postImage?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
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
