class SendFileToChatModel {
  SendFileToChatModel({
    bool? status,
    String? message,
    ChatFile? chat,
  }) {
    _status = status;
    _message = message;
    _chat = chat;
  }

  SendFileToChatModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _chat = json['chat'] != null ? ChatFile.fromJson(json['chat']) : null;
  }
  bool? _status;
  String? _message;
  ChatFile? _chat;
  SendFileToChatModel copyWith({
    bool? status,
    String? message,
    ChatFile? chat,
  }) =>
      SendFileToChatModel(
        status: status ?? _status,
        message: message ?? _message,
        chat: chat ?? _chat,
      );
  bool? get status => _status;
  String? get message => _message;
  ChatFile? get chat => _chat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_chat != null) {
      map['chat'] = _chat?.toJson();
    }
    return map;
  }
}

class ChatFile {
  ChatFile({
    String? chatTopicId,
    String? senderId,
    int? messageType,
    String? message,
    String? image,
    bool? isMediaBanned,
    bool? isRead,
    String? callId,
    int? callType,
    String? callDuration,
    String? date,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    _chatTopicId = chatTopicId;
    _senderId = senderId;
    _messageType = messageType;
    _message = message;
    _image = image;
    _isMediaBanned = isMediaBanned;
    _isRead = isRead;
    _callId = callId;
    _callType = callType;
    _callDuration = callDuration;
    _date = date;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  ChatFile.fromJson(dynamic json) {
    _chatTopicId = json['chatTopicId'];
    _senderId = json['senderId'];
    _messageType = json['messageType'];
    _message = json['message'];
    _image = json['image'];
    _isMediaBanned = json['isMediaBanned'];
    _isRead = json['isRead'];
    _callId = json['callId'];
    _callType = json['callType'];
    _callDuration = json['callDuration'];
    _date = json['date'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _chatTopicId;
  String? _senderId;
  int? _messageType;
  String? _message;
  String? _image;
  bool? _isMediaBanned;
  bool? _isRead;
  String? _callId;
  int? _callType;
  String? _callDuration;
  String? _date;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  ChatFile copyWith({
    String? chatTopicId,
    String? senderId,
    int? messageType,
    String? message,
    String? image,
    bool? isMediaBanned,
    bool? isRead,
    String? callId,
    int? callType,
    String? callDuration,
    String? date,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) =>
      ChatFile(
        chatTopicId: chatTopicId ?? _chatTopicId,
        senderId: senderId ?? _senderId,
        messageType: messageType ?? _messageType,
        message: message ?? _message,
        image: image ?? _image,
        isMediaBanned: isMediaBanned ?? _isMediaBanned,
        isRead: isRead ?? _isRead,
        callId: callId ?? _callId,
        callType: callType ?? _callType,
        callDuration: callDuration ?? _callDuration,
        date: date ?? _date,
        id: id ?? _id,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get chatTopicId => _chatTopicId;
  String? get senderId => _senderId;
  int? get messageType => _messageType;
  String? get message => _message;
  String? get image => _image;
  bool? get isMediaBanned => _isMediaBanned;
  bool? get isRead => _isRead;
  String? get callId => _callId;
  int? get callType => _callType;
  String? get callDuration => _callDuration;
  String? get date => _date;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chatTopicId'] = _chatTopicId;
    map['senderId'] = _senderId;
    map['messageType'] = _messageType;
    map['message'] = _message;
    map['image'] = _image;
    map['isMediaBanned'] = _isMediaBanned;
    map['isRead'] = _isRead;
    map['callId'] = _callId;
    map['callType'] = _callType;
    map['callDuration'] = _callDuration;
    map['date'] = _date;
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
