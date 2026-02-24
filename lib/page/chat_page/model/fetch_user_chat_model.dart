class FetchUserChatModel {
  FetchUserChatModel({
    bool? status,
    String? message,
    String? chatTopic,
    List<Chat>? chat,
  }) {
    _status = status;
    _message = message;
    _chatTopic = chatTopic;
    _chat = chat;
  }

  FetchUserChatModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _chatTopic = json['chatTopic'];
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
  FetchUserChatModel copyWith({
    bool? status,
    String? message,
    String? chatTopic,
    List<Chat>? chat,
  }) =>
      FetchUserChatModel(
        status: status ?? _status,
        message: message ?? _message,
        chatTopic: chatTopic ?? _chatTopic,
        chat: chat ?? _chat,
      );
  bool? get status => _status;
  String? get message => _message;
  String? get chatTopic => _chatTopic;
  List<Chat>? get chat => _chat;

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
