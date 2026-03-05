class OtherUserInfo {
  OtherUserInfo({String? id, String? name, String? image, bool? isOnline}) {
    _id = id;
    _name = name;
    _image = image;
    _isOnline = isOnline ?? false;
  }
  String? _id;
  String? _name;
  String? _image;
  bool _isOnline = false;
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  bool get isOnline => _isOnline;
  OtherUserInfo copyWith({bool? isOnline}) =>
      OtherUserInfo(id: _id, name: _name, image: _image, isOnline: isOnline ?? _isOnline);
  static OtherUserInfo? fromJson(dynamic json) {
    if (json == null || json is! Map) return null;
    return OtherUserInfo(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      image: json['image']?.toString(),
      isOnline: json['isOnline'] as bool? ?? false,
    );
  }
}

class FetchUserChatModel {
  FetchUserChatModel({
    bool? status,
    String? message,
    String? chatTopic,
    List<Chat>? chat,
    OtherUserInfo? otherUser,
  }) {
    _status = status;
    _message = message;
    _chatTopic = chatTopic;
    _chat = chat;
    _otherUser = otherUser;
  }

  FetchUserChatModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _chatTopic = json['chatTopic'];
    _otherUser = OtherUserInfo.fromJson(json['otherUser']);
    if (json['chat'] != null) {
      _chat = [];
      json['chat'].forEach((v) {
        _chat?.add(Chat.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  String? _chatTopic;
  List<Chat>? _chat;
  OtherUserInfo? _otherUser;
  FetchUserChatModel copyWith({
    bool? status,
    String? message,
    String? chatTopic,
    List<Chat>? chat,
    OtherUserInfo? otherUser,
  }) =>
      FetchUserChatModel(
        status: status ?? _status,
        message: message ?? _message,
        chatTopic: chatTopic ?? _chatTopic,
        chat: chat ?? _chat,
        otherUser: otherUser ?? _otherUser,
      );
  bool? get status => _status;
  String? get message => _message;
  String? get chatTopic => _chatTopic;
  List<Chat>? get chat => _chat;
  OtherUserInfo? get otherUser => _otherUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['chatTopic'] = _chatTopic;
    if (_chat != null) {
      map['chat'] = _chat?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ReplyTo {
  ReplyTo({String? id, String? message, String? senderId}) {
    _id = id;
    _message = message;
    _senderId = senderId;
  }
  String? _id;
  String? _message;
  String? _senderId;
  String? get id => _id;
  String? get message => _message;
  String? get senderId => _senderId;
  static ReplyTo? fromJson(dynamic json) {
    if (json == null || json is! Map) return null;
    return ReplyTo(
      id: json['id']?.toString(),
      message: json['message']?.toString(),
      senderId: json['senderId']?.toString(),
    );
  }
}

class MessageReaction {
  MessageReaction({String? userId, String? emoji}) {
    _userId = userId;
    _emoji = emoji;
  }
  String? _userId;
  String? _emoji;
  String? get userId => _userId;
  String? get emoji => _emoji;
  static MessageReaction fromJson(dynamic json) {
    if (json is! Map) return MessageReaction();
    return MessageReaction(
      userId: json['userId']?.toString(),
      emoji: json['emoji']?.toString(),
    );
  }
}

class Chat {
  Chat({
    String? id,
    String? senderId,
    String? message,
    String? image,
    bool? isMediaBanned,
    bool? isRead,
    int? callType,
    String? callDuration,
    String? date,
    int? messageType,
    String? createdAt,
    ReplyTo? replyTo,
    List<MessageReaction>? reactions,
  }) {
    _id = id;
    _senderId = senderId;
    _message = message;
    _image = image;
    _isMediaBanned = isMediaBanned;
    _isRead = isRead;
    _callType = callType;
    _callDuration = callDuration;
    _date = date;
    _messageType = messageType;
    _createdAt = createdAt;
    _replyTo = replyTo;
    _reactions = reactions ?? [];
  }

  Chat.fromJson(dynamic json) {
    _id = json['_id'];
    _senderId = json['senderId'];
    _message = json['message'];
    _image = json['image'];
    _isMediaBanned = json['isMediaBanned'];
    _isRead = json['isRead'];
    _callType = json['callType'];
    _callDuration = json['callDuration'];
    _date = json['date'];
    _messageType = json['messageType'];
    _createdAt = json['createdAt'];
    _replyTo = ReplyTo.fromJson(json['replyTo']);
    _reactions = (json['reactions'] as List?)
        ?.map((e) => MessageReaction.fromJson(e))
        .toList() ?? [];
  }
  String? _id;
  String? _senderId;
  String? _message;
  String? _image;
  bool? _isMediaBanned;
  bool? _isRead;
  int? _callType;
  String? _callDuration;
  String? _date;
  int? _messageType;
  String? _createdAt;
  ReplyTo? _replyTo;
  List<MessageReaction> _reactions = [];
  ReplyTo? get replyTo => _replyTo;
  List<MessageReaction> get reactions => _reactions;
  Chat copyWith({
    String? id,
    String? senderId,
    String? message,
    String? image,
    bool? isMediaBanned,
    bool? isRead,
    int? callType,
    String? callDuration,
    String? date,
    int? messageType,
    String? createdAt,
    ReplyTo? replyTo,
    List<MessageReaction>? reactions,
  }) =>
      Chat(
        id: id ?? _id,
        senderId: senderId ?? _senderId,
        message: message ?? _message,
        image: image ?? _image,
        isMediaBanned: isMediaBanned ?? _isMediaBanned,
        isRead: isRead ?? _isRead,
        callType: callType ?? _callType,
        callDuration: callDuration ?? _callDuration,
        date: date ?? _date,
        messageType: messageType ?? _messageType,
        createdAt: createdAt ?? _createdAt,
        replyTo: replyTo ?? _replyTo,
        reactions: reactions ?? _reactions,
      );
  String? get id => _id;
  String? get senderId => _senderId;
  String? get message => _message;
  String? get image => _image;
  bool? get isMediaBanned => _isMediaBanned;
  bool? get isRead => _isRead;
  int? get callType => _callType;
  String? get callDuration => _callDuration;
  String? get date => _date;
  int? get messageType => _messageType;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['senderId'] = _senderId;
    map['message'] = _message;
    map['image'] = _image;
    map['isMediaBanned'] = _isMediaBanned;
    map['isRead'] = _isRead;
    map['callType'] = _callType;
    map['callDuration'] = _callDuration;
    map['date'] = _date;
    map['messageType'] = _messageType;
    map['createdAt'] = _createdAt;
    return map;
  }
}
