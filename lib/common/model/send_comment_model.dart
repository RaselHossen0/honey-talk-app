import 'dart:convert';

SendCommentModel sendCommentModelFromJson(String str) => SendCommentModel.fromJson(json.decode(str));
String sendCommentModelToJson(SendCommentModel data) => json.encode(data.toJson());

class SendCommentModel {
  SendCommentModel({
    bool? status,
    String? message,
    Comment? comment,
  }) {
    _status = status;
    _message = message;
    _comment = comment;
  }

  SendCommentModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _comment = json['comment'] != null ? Comment.fromJson(json['comment']) : null;
  }
  bool? _status;
  String? _message;
  Comment? _comment;
  SendCommentModel copyWith({
    bool? status,
    String? message,
    Comment? comment,
  }) =>
      SendCommentModel(
        status: status ?? _status,
        message: message ?? _message,
        comment: comment ?? _comment,
      );
  bool? get status => _status;
  String? get message => _message;
  Comment? get comment => _comment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_comment != null) {
      map['comment'] = _comment?.toJson();
    }
    return map;
  }
}

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));
String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    String? userId,
    String? postId,
    String? videoId,
    String? recursiveCommentId,
    String? commentText,
    num? like,
    num? dislike,
    num? totalReplies,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    _userId = userId;
    _postId = postId;
    _videoId = videoId;
    _recursiveCommentId = recursiveCommentId;
    _commentText = commentText;
    _like = like;
    _dislike = dislike;
    _totalReplies = totalReplies;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Comment.fromJson(dynamic json) {
    _userId = json['userId'];
    _postId = json['postId'];
    _videoId = json['videoId'];
    _recursiveCommentId = json['recursiveCommentId'];
    _commentText = json['commentText'];
    _like = json['like'];
    _dislike = json['dislike'];
    _totalReplies = json['totalReplies'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _userId;
  String? _postId;
  String? _videoId;
  String? _recursiveCommentId;
  String? _commentText;
  num? _like;
  num? _dislike;
  num? _totalReplies;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  Comment copyWith({
    String? userId,
    String? postId,
    String? videoId,
    String? recursiveCommentId,
    String? commentText,
    num? like,
    num? dislike,
    num? totalReplies,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) =>
      Comment(
        userId: userId ?? _userId,
        postId: postId ?? _postId,
        videoId: videoId ?? _videoId,
        recursiveCommentId: recursiveCommentId ?? _recursiveCommentId,
        commentText: commentText ?? _commentText,
        like: like ?? _like,
        dislike: dislike ?? _dislike,
        totalReplies: totalReplies ?? _totalReplies,
        id: id ?? _id,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get userId => _userId;
  String? get postId => _postId;
  String? get videoId => _videoId;
  String? get recursiveCommentId => _recursiveCommentId;
  String? get commentText => _commentText;
  num? get like => _like;
  num? get dislike => _dislike;
  num? get totalReplies => _totalReplies;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['postId'] = _postId;
    map['videoId'] = _videoId;
    map['recursiveCommentId'] = _recursiveCommentId;
    map['commentText'] = _commentText;
    map['like'] = _like;
    map['dislike'] = _dislike;
    map['totalReplies'] = _totalReplies;
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
