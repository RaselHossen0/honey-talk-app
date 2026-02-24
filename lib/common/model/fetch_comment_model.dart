import 'dart:convert';

FetchCommentModel fetchCommentModelFromJson(String str) => FetchCommentModel.fromJson(json.decode(str));
String fetchCommentModelToJson(FetchCommentModel data) => json.encode(data.toJson());

class FetchCommentModel {
  FetchCommentModel({
    bool? status,
    String? message,
    List<Comments>? comments,
  }) {
    _status = status;
    _message = message;
    _comments = comments;
  }

  FetchCommentModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['comments'] != null) {
      _comments = [];
      json['comments'].forEach((v) {
        _comments?.add(Comments.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Comments>? _comments;
  FetchCommentModel copyWith({
    bool? status,
    String? message,
    List<Comments>? comments,
  }) =>
      FetchCommentModel(
        status: status ?? _status,
        message: message ?? _message,
        comments: comments ?? _comments,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Comments>? get comments => _comments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_comments != null) {
      map['comments'] = _comments?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Comments commentsFromJson(String str) => Comments.fromJson(json.decode(str));
String commentsToJson(Comments data) => json.encode(data.toJson());

class Comments {
  Comments({
    String? id,
    String? commentText,
    String? createdAt,
    String? userId,
    String? name,
    String? userName,
    String? userImage,
    bool? isProfilePicBanned,
    String? time,
  }) {
    _id = id;
    _commentText = commentText;
    _createdAt = createdAt;
    _userId = userId;
    _name = name;
    _userName = userName;
    _userImage = userImage;
    _isProfilePicBanned = isProfilePicBanned;
    _time = time;
  }

  Comments.fromJson(dynamic json) {
    _id = json['_id'];
    _commentText = json['commentText'];
    _createdAt = json['createdAt'];
    _userId = json['userId'];
    _name = json['name'];
    _userName = json['userName'];
    _userImage = json['userImage'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _time = json['time'];
  }
  String? _id;
  String? _commentText;
  String? _createdAt;
  String? _userId;
  String? _name;
  String? _userName;
  String? _userImage;
  bool? _isProfilePicBanned;
  String? _time;
  Comments copyWith({
    String? id,
    String? commentText,
    String? createdAt,
    String? userId,
    String? name,
    String? userName,
    String? userImage,
    bool? isProfilePicBanned,
    String? time,
  }) =>
      Comments(
        id: id ?? _id,
        commentText: commentText ?? _commentText,
        createdAt: createdAt ?? _createdAt,
        userId: userId ?? _userId,
        name: name ?? _name,
        userName: userName ?? _userName,
        userImage: userImage ?? _userImage,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        time: time ?? _time,
      );
  String? get id => _id;
  String? get commentText => _commentText;
  String? get createdAt => _createdAt;
  String? get userId => _userId;
  String? get name => _name;
  String? get userName => _userName;
  String? get userImage => _userImage;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['commentText'] = _commentText;
    map['createdAt'] = _createdAt;
    map['userId'] = _userId;
    map['name'] = _name;
    map['userName'] = _userName;
    map['userImage'] = _userImage;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['time'] = _time;
    return map;
  }
}
